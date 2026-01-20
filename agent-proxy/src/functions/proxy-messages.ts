import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { DefaultAzureCredential } from "@azure/identity";
import { AIProjectClient } from "@azure/ai-projects";

const credential = new DefaultAzureCredential();

// Prefer env vars so you can change without redeploy
const projectEndpoint =
  process.env.FOUNDRY_PROJECT_ENDPOINT ??
  "https://agent-training-resource-test.services.ai.azure.com/api/projects/agent-training";

const agentName = process.env.FOUNDRY_AGENT_NAME ?? "kinetic-agent";

// Create client once (reused across invocations)
const projectClient = new AIProjectClient(projectEndpoint, credential);

app.http("proxy-messages", {
  methods: ["POST"],
  authLevel: "anonymous",
  handler: proxyMessages
});

export async function proxyMessages(
  request: HttpRequest,
  context: InvocationContext
): Promise<HttpResponseInit> {
  try {
    // You can accept a prompt from the caller
    const body = await request.json().catch(() => ({} as any));
    const prompt: string =
      body?.prompt ??
      body?.message ??
      "What is the size of France in square miles?";

    const result = await doProxy(prompt, context);

    return {
      status: 200,
      jsonBody: {
        success: true,
        conversationId: result.conversationId,
        outputText: result.outputText
      }
    };
  } catch (err: any) {
    context.error("Proxy failed", err);

    return {
      status: 500,
      jsonBody: {
        error: "Proxy failed",
        detail: err?.message ?? String(err)
      }
    };
  }
}

async function doProxy(prompt: string, context: InvocationContext): Promise<{ conversationId: string; outputText: string }> {
  // Retrieve the agent
  const retrievedAgent = await projectClient.agents.get(agentName);

  context.log(
    "Retrieved agent:",
    "name=",
    retrievedAgent?.name,
    "id=",
    retrievedAgent?.id
  );

  // Get OpenAI client from the project client
  const openAIClient = await projectClient.getOpenAIClient();

  context.log("Creating conversation...");
  const conversation = await openAIClient.conversations.create({
    items: [{ type: "message", role: "user", content: prompt }]
  });

  context.log("Conversation created:", conversation.id);

  context.log("Generating response...");
  const response = await openAIClient.responses.create(
    { conversation: conversation.id },
    { body: { agent: { name: retrievedAgent.name, type: "agent_reference" } } }
  );

  // Some SDK responses expose output_text; keep it defensive
  const outputText = (response as any).output_text ?? (response as any).outputText ?? "";

  context.log("Response received. chars=", outputText.length);

  return { conversationId: conversation.id, outputText };
}
