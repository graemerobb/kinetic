import { HttpRequest, HttpResponseInit } from "@azure/functions";

export function json(status: number, body: unknown): HttpResponseInit {
  return {
    status,
    headers: { "content-type": "application/json" },
    body: JSON.stringify(body),
  };
}

export function badRequest(message: string, details?: unknown): HttpResponseInit {
  return json(400, { error: message, details });
}

export function serverError(message = "Server error", details?: unknown): HttpResponseInit {
  return json(500, { error: message, details });
}

export async function readJson<T = any>(req: HttpRequest): Promise<T> {
  const t = await req.text();
  return t ? (JSON.parse(t) as T) : ({} as T);
}
