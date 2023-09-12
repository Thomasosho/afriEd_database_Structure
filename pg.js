import postgres from "postgres";
import dotenv from "dotenv";

dotenv.config();

const sql = postgres(process.env.DATABASE_URL, { ssl: "require" });

async function getPostgresVersion() {
  const result = await sql`select version()`;
  console.log(result);
}
  // SQL query to create the "employees" table
const createTableQuery = `
CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "fullName" varchar,
  "department" integer,
  "employmentType" integer,
  "position" integer,
  "leave" integer,
  "training" integer,
  "attendance" integer,
  "created_at" timestamp
);

CREATE TABLE "departments" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "description" varchar,
  "created_at" timestamp
);

CREATE TABLE "positions" (
  "id" integer PRIMARY KEY,
  "department" integer,
  "position" varchar,
  "created_at" timestamp
);

CREATE TABLE "employmentTypes" (
  "id" integer PRIMARY KEY,
  "type" varchar,
  "created_at" timestamp
);

CREATE TABLE "payrolls" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "salary" integer,
  "attendance" integer,
  "date" timestamp,
  "created_at" timestamp
);

CREATE TABLE "leaves" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "department" integer,
  "position" integer,
  "created_at" timestamp
);

CREATE TABLE "trainings" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "department" integer,
  "position" integer,
  "created_at" timestamp
);

CREATE TABLE "attendances" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "department" integer,
  "position" integer,
  "date" timestamp,
  "created_at" timestamp
);
`;

// Function to create the "employees" table
async function createEmployeesTable() {
try {
  const client = await pool.connect();
  await client.query(createTableQuery);
  console.log('Table "employees" created successfully.');
  client.release();
} catch (error) {
  console.error('Error creating "employees" table:', error);
} finally {
  // Release the database connection
  pool.end();
}
}

// Call the function to create the "employees" table
createEmployeesTable();
export default sql;