CREATE USER [kinetic-api] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [kinetic-api];
ALTER ROLE db_datawriter ADD MEMBER [kinetic-api];
GRANT VIEW DEFINITION TO [kinetic-api];
