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

async function doProxy(
  prompt: string,
  context: InvocationContext
): Promise<{ conversationId: string; outputText: string }> {
  // Resolve config at invocation time (no startup throws)
  const projectEndpoint =
    process.env.FOUNDRY_PROJECT_ENDPOINT ??
    "https://agent-training-resource-test.services.ai.azure.com/api/projects/agent-training";

  context.log("Connecting to endpoint "+projectEndpoint);

  let agentId = process.env.FOUNDRY_AGENT_ID;
  const agentVersion = process.env.FOUNDRY_AGENT_VERSION;

  if (!agentId) {
    // Return a clean error instead of crashing indexing
    context.log("Missing FOUNDRY_AGENT_ID app setting");
    agentId = "";
  }

  // Create credential + client at invocation time (no static init)
  const credential = new DefaultAzureCredential();
  const projectClient = new AIProjectClient(projectEndpoint, credential);

  // Use the Azure OpenAI client provided by the Projects SDK
  const aoaiClient = await projectClient.getAzureOpenAIClient();

  context.log("Creating conversation...");
  const conversation = await aoaiClient.conversations.create({
    items: [{ type: "message", role: "user", content: prompt }]
  });

  context.log("Conversation created:", conversation.id);

  context.log("Generating response...");
  const response = await aoaiClient.responses.create(
    { conversation: conversation.id },
    {
      body: {
        agent: agentVersion
          ? { id: agentId, version: agentVersion, type: "agent_reference" }
          : { id: agentId, type: "agent_reference" }
      }
    }
  );

  const outputText =
    (response as any).output_text ??
    (response as any).outputText ??
    (response as any).output?.[0]?.content?.[0]?.text ??
    "";

  context.log("Response received chars=", outputText.length);

  return { conversationId: conversation.id, outputText };
}
