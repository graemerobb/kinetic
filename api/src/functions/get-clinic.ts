import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import sql from "mssql";

async function getSqlPool() {
  const connectionString = process.env.MSSQL_CONNECTION_STRING;
  if (!connectionString) throw new Error("Missing MSSQL_CONNECTION_STRING");

  return sql.connect(connectionString);
}


export async function getClinic(
  request: HttpRequest,
  context: InvocationContext
): Promise<HttpResponseInit> {
  try {
    type ClinicRequestBody = {
        id?: string;
    };

    const body = (await request.json().catch(() => null)) as ClinicRequestBody | null;

    const clinicId =
        request.query.get("id") ??
        body?.id;
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
