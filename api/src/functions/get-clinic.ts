import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import sql from "mssql";
import { DefaultAzureCredential } from "@azure/identity";

const credential = new DefaultAzureCredential();

async function getSqlPool() {
  const token = await credential.getToken("https://database.windows.net/.default");

  if (!token) {
    throw new Error("Failed to acquire Azure SQL access token");
  }

  return sql.connect({
    server: process.env.SQL_SERVER!,
    database: process.env.SQL_DATABASE!,
    options: {
      encrypt: true
    },
    authentication: {
      type: "azure-active-directory-access-token",
      options: {
        token: token.token
      }
    }
  });
}

export async function getClinic(
  request: HttpRequest,
  context: InvocationContext
): Promise<HttpResponseInit> {
  try {
    const clinicId =
      request.query.get("id") ??
      (await request.json().catch(() => ({} as any)))?.id;

    if (!clinicId) {
      return {
        status: 400,
        jsonBody: { error: "Missing clinic id" }
      };
    }

    const pool = await getSqlPool();

    const result = await pool.request()
      .input("id", sql.NVarChar, clinicId)
      .query(`
        SELECT
          id,
          email,
          speciality,
          address,
          data_sharing_tokens,
          data_sharing,
          created_at
        FROM dbo.Clinics
        WHERE id = @id
      `);

    if (result.recordset.length === 0) {
      return {
        status: 404,
        jsonBody: { error: "Clinic not found" }
      };
    }

    return {
      status: 200,
      jsonBody: result.recordset[0]
    };

  } catch (err: any) {
    context.error("Get clinic failed", err);

    return {
      status: 500,
      jsonBody: {
        error: "Database query failed",
        detail: err.message
      }
    };
  }
}

app.http("get-clinic", {
  methods: ["GET"],
  authLevel: "anonymous",
  handler: getClinic
});
