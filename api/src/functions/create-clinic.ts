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

export async function createClinic(
  request: HttpRequest,
  context: InvocationContext
): Promise<HttpResponseInit> {
  try {
    const body = await request.json();

    const {
      id,
      email,
      speciality = null,
      address = null,
      data_sharing_tokens = null,
      data_sharing,
      created_at
    } = body;

    if (!id || !email || data_sharing === undefined || !created_at) {
      return {
        status: 400,
        jsonBody: { error: "Missing required fields" }
      };
    }

    const pool = await getSqlPool();

    await pool.request()
      .input("id", sql.NVarChar, id)
      .input("email", sql.NVarChar, email)
      .input("speciality", sql.NVarChar, speciality)
      .input("address", sql.NVarChar, address)
      .input("data_sharing_tokens", sql.Int, data_sharing_tokens)
      .input("data_sharing", sql.Bit, data_sharing)
      .input("created_at", sql.DateTime2, new Date(created_at))
      .query(`
        INSERT INTO dbo.Clinics (
          id,
          email,
          speciality,
          address,
          data_sharing_tokens,
          data_sharing,
          created_at
        )
        VALUES (
          @id,
          @email,
          @speciality,
          @address,
          @data_sharing_tokens,
          @data_sharing,
          @created_at
        )
      `);

    return {
      status: 201,
      jsonBody: {
        success: true,
        clinic_id: id
      }
    };

  } catch (err: any) {
    context.error("Create clinic failed", err);

    return {
      status: 500,
      jsonBody: {
        error: "Database insert failed",
        detail: err.message
      }
    };
  }
}

app.http("create-clinic", {
  methods: ["POST"],
  authLevel: "anonymous",
  handler: createClinic
});
