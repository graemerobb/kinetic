import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { DefaultAzureCredential } from "@azure/identity";

const credential = new DefaultAzureCredential();



export async function proxyMessages(
  request: HttpRequest,
  context: InvocationContext
): Promise<HttpResponseInit> {
  try {

    return {
      status: 201,
      jsonBody: {
        success: true
      }
    };

  } catch (err: any) {
    context.error("Proxy failed", err);

    return {
      status: 500,
      jsonBody: {
        error: "Proxy failed",
        detail: err.message
      }
    };
  }
}

app.http("proxy-messages", {
  methods: ["POST"],
  authLevel: "anonymous",
  handler: proxyMessages
});
