// import express from "express";
// import sql from "./db.js";
// import cors from "cors";

// const app = express();
// const PORT = 3000;

// app.use(
//   cors({
//     origin: ["http://localhost:5173"],
//   })
// );

// app.get("/api/employee", async (req, res) => {
//     const employee = await sql`SELECT * FROM employee`
//     console.log(employee)
//     if (employee) {
//         res.status(200).send(employee)
//     } else {
//         res.status(404).send("Error here!")
//     }
// });

// Function to show employee payroll information
async function show_employee_payroll(employee_id, period_start, period_end) {
  try {
    // Retrieve employee information and payroll data
    const employeeQuery = `
      SELECT u."id", u."fullName", e."type", p."position", pr."salary"
      FROM "users" u
      JOIN "employmentTypes" e ON u."employmentType" = e."id"
      JOIN "positions" p ON u."position" = p."id"
      LEFT JOIN "payrolls" pr ON u."id" = pr."user"
      WHERE u."id" = $1;
    `;

    const { rows: employeeData } = await pool.query(employeeQuery, [employee_id]);

    // Calculate total salary within the specified period
    const payrollQuery = `
      SELECT SUM("salary") AS "totalSalary"
      FROM "payrolls"
      WHERE "user" = $1
      AND "date" BETWEEN $2 AND $3;
    `;

    const { rows: payrollData } = await pool.query(payrollQuery, [employee_id, period_start, period_end]);

    // Display employee information and total salary
    if (employeeData.length > 0) {
      const employee = employeeData[0];
      const totalSalary = payrollData[0].totalSalary || 0;

      console.log('Employee Information:');
      console.log(`Name: ${employee.fullName}`);
      console.log(`Employment Type: ${employee.type}`);
      console.log(`Position: ${employee.position}`);
      console.log(`Total Salary (Period ${period_start} to ${period_end}): $${totalSalary}`);
    } else {
      console.log('Employee not found.');
    }
  } catch (error) {
    console.error('Error:', error);
  } finally {
    // Release the database connection
    await pool.end();
  }
}

// Example usage:
show_employee_payroll(1, '2023-09-01', '2023-09-30');