import sql from "mssql";
import { DefaultAzureCredential } from "@azure/identity";

const credential = new DefaultAzureCredential();

async function getPool() {
  const token = await credential.getToken("https://database.windows.net/.default");

  return sql.connect({
    server: process.env.SQL_SERVER!,          // "myserver.database.windows.net"
    database: process.env.SQL_DATABASE!,      // "kineticdb"
    options: { encrypt: true },
    authentication: {
      type: "azure-active-directory-access-token",
      options: { token: token!.token }
    }
  });
}
