import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { DefaultAzureCredential } from "@azure/identity";
import { AIProjectClient } from "@azure/ai-projects";

const projectEndpoint = "https://agent-training-resource-test.services.ai.azure.com/api/projects/agent-training";
const agentName = "kinetic-agent";

type FoundryTestBody = {
  prompt?: string;
  message?: string;
};

app.http("foundry-test", {
  methods: ["POST"],
  authLevel: "anonymous",
  handler: foundryTest
});

export async function foundryTest(
  request: HttpRequest,
  context: InvocationContext
): Promise<HttpResponseInit> {
  try {
    const body = (await request.json().catch(() => ({}))) as FoundryTestBody;
    const result = await testit();

    return {
      status: 200,
      jsonBody: {
        success: true,
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


async function testit() {

    const projectEndpoint =
    process.env.FOUNDRY_PROJECT_ENDPOINT ??
    "https://agent-training-resource-test.services.ai.azure.com/api/projects/agent-training";

    const agentName = process.env.FOUNDRY_AGENT_NAME ?? "kinetic-agent";
    const apiVersion = process.env.OPENAI_API_VERSION ?? "2024-10-21";

  const projectClient = new AIProjectClient(projectEndpoint, new DefaultAzureCredential());

  // Resolve agent ID from name (because getAgent expects an ID, not a name)
  let resolvedAgentId: string | undefined;
  for await (const a of projectClient.agents.listAgents()) {
    if (a.name === agentName) {
      resolvedAgentId = a.id;
      break;
    }
  }
  if (!resolvedAgentId) {
    throw new Error(`Agent not found by name: ${agentName}`);
  }

  const retrievedAgent = await projectClient.agents.getAgent(resolvedAgentId);
  console.log("Retrieved agent - name:", retrievedAgent.name, "id:", retrievedAgent.id);

  // Your SDK version does NOT have projectClient.inference.*
  // Use getAzureOpenAIClient and pass apiVersion explicitly
  const openAIClient = await projectClient.getAzureOpenAIClient({ apiVersion });

  console.log("\nCreating conversation with initial user message...");
  const conversation = await openAIClient.conversations.create({
    items: [{ type: "message", role: "user", content: "What is the size of France in square miles?" }],
  });
  console.log("Created conversation (id):", conversation.id);

  console.log("\nGenerating response...");
  const response = await openAIClient.responses.create(
    { conversation: conversation.id },
    {
      body: {
        agent: { id: retrievedAgent.id, type: "agent_reference" }, // use id (most reliable)
      },
    }
  );

  console.log("Response output:");
  console.log(response.output_text);
}