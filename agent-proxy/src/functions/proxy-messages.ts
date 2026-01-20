import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { DefaultAzureCredential } from "@azure/identity";
import { AIProjectClient } from "@azure/ai-projects";

type ProxyRequestBody = {
  prompt?: string;
  message?: string;
};

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
    const body = (await request.json().catch(() => ({}))) as ProxyRequestBody;

    const prompt =
      body.prompt ??
      body.message ??
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
      jsonBody: { error: "Proxy failed", detail: err?.message ?? String(err) }
    };
  }
}

async function doProxy(prompt: string, context: InvocationContext) {
  const projectEndpoint =
    process.env.FOUNDRY_PROJECT_ENDPOINT ??
    "https://agent-training-resource-test.services.ai.azure.com/api/projects/agent-training";

  const agentName = process.env.FOUNDRY_AGENT_NAME ?? "kinetic-agent"; // or use ID if you prefer

  context.log("Connecting to endpoint " + projectEndpoint);

  const credential = new DefaultAzureCredential();
  const projectClient = new AIProjectClient(projectEndpoint, credential);

  // ✅ Foundry OpenAI-compatible client (for Conversations + Responses against the project)
  const openAIClient = await projectClient.getOpenAIClient();

  // Optional but very useful: confirm agent exists and get the canonical name/id
  const retrievedAgent = await projectClient.agents.get(agentName);
  context.log("Retrieved agent:", retrievedAgent.name, "id:", retrievedAgent.id);

  context.log("Creating conversation...");
  const conversation = await openAIClient.conversations.create({
    items: [{ type: "message", role: "user", content: prompt }],
  });
  context.log("Conversation created:", conversation.id);

  context.log("Generating response...");
  const response = await openAIClient.responses.create(
    { conversation: conversation.id },
    {
      body: {
        agent: { name: retrievedAgent.name, type: "agent_reference" },
        // OR: agent: { id: retrievedAgent.id, type: "agent_reference" }  (depending on SDK version)
      },
    }
  );

  return {
    conversationId: conversation.id,
    outputText: response.output_text ?? "",
  };
}
