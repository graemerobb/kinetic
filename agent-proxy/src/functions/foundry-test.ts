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
    // Create AI Project client
const projectClient = new AIProjectClient(projectEndpoint, new DefaultAzureCredential());

    // Retrieve Agent by name (latest version)
  //const retrievedAgent = await projectClient.agents.get(agentName);
  const retrievedAgent = await projectClient.agents.getAgent(agentName);

  console.log("Retrieved latest agent - name:", retrievedAgent.versions.latest.name, " id:", retrievedAgent.id);
  // Use the retrieved agent to create a conversation and generate a response
  //const openAIClient = await projectClient.getOpenAIClient();
  const openAIClient = await projectClient.inference.azureOpenAI({
    apiVersion: process.env.OPENAI_API_VERSION ?? "2024-10-21",
    });


  // Create conversation with initial user message
  console.log("\nCreating conversation with initial user message...");
  const conversation = await openAIClient.conversations.create({
    items: [{ type: "message", role: "user", content: "What is the size of France in square miles?" }]
    });
  console.log("Created conversation with initial user message (id: ");
  console.log(conversation.id);
  
  // Generate response using the agent
  console.log("\nGenerating response...");
  const response = await openAIClient.responses.create(
      {
          conversation: conversation.id,
      },
      {
          body: { agent: { name: retrievedAgent.name, type: "agent_reference" } },
      },
  );
  console.log("Response output: ");
  console.log(response.output_text);
}
