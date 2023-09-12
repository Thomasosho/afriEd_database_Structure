DROP TABLE IF EXISTS users CASCADE;

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

INSERT INTO users
(fullName, department, employmentType, position, leave, training, attendance) 
VALUES
('John Doe', 'HR', 'Full-Time', 'HR Manager', 10, 'Onboarding', 'Present'),
('Jane Smith', 'Marketing', 'Part-Time', 'Marketing Coordinator', 5, 'Marketing Strategy', 'Present'),
('Mike Johnson', 'IT', 'Full-Time', 'Systems Administrator', 12, 'Cybersecurity', 'Absent'),
('Sarah Brown', 'Finance', 'Full-Time', 'Financial Analyst', 8, 'Financial Planning', 'Present'),
('David Lee', 'Sales', 'Part-Time', 'Sales Associate', 7, 'Sales Techniques', 'Present');

DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE "departments" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "description" varchar,
  "created_at" timestamp
);

INSERT INTO departments
("id", "title", "description", "created_at")
VALUES
(1, 'HR', 'Human Resources Department', '2023-09-12 10:00:00'),
(2, 'Marketing', 'Marketing Department', '2023-09-12 10:15:00'),
(3, 'IT', 'Information Technology Department', '2023-09-12 10:30:00'),
(4, 'Finance', 'Finance Department', '2023-09-12 10:45:00'),
(5, 'Sales', 'Sales Department', '2023-09-12 11:00:00');

DROP TABLE IF EXISTS positions CASCADE;

CREATE TABLE "positions" (
  "id" integer PRIMARY KEY,
  "department" integer,
  "position" varchar,
  "created_at" timestamp
);

INSERT INTO positions
("id", "department", "position", "created_at")
VALUES
(1, 1, 'HR Manager', '2023-09-12 13:00:00'),
(2, 2, 'Marketing Coordinator', '2023-09-12 13:15:00'),
(3, 3, 'Systems Administrator', '2023-09-12 13:30:00'),
(4, 4, 'Financial Analyst', '2023-09-12 13:45:00'),
(5, 5, 'Sales Associate', '2023-09-12 14:00:00');

DROP TABLE IF EXISTS employmentTypes CASCADE;

CREATE TABLE "employmentTypes" (
  "id" integer PRIMARY KEY,
  "type" varchar,
  "created_at" timestamp
);

INSERT INTO employmentTypes
("id", "type", "created_at")
VALUES
(1, 'Full-Time', '2023-09-12 15:00:00'),
(2, 'Part-Time', '2023-09-12 15:15:00'),
(3, 'Contract', '2023-09-12 15:30:00'),
(4, 'Temporary', '2023-09-12 15:45:00');

DROP TABLE IF EXISTS payrolls CASCADE;

CREATE TABLE "payrolls" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "salary" integer,
  "attendance" integer,
  "date" timestamp,
  "created_at" timestamp
);

INSERT INTO payrolls
("id", "user", "salary", "attendance", "date", "created_at")
VALUES
(1, 1, 60000, 20, '2023-09-01 00:00:00', '2023-09-12 16:00:00'),
(2, 2, 40000, 18, '2023-09-01 00:00:00', '2023-09-12 16:15:00'),
(3, 3, 70000, 16, '2023-09-01 00:00:00', '2023-09-12 16:30:00'),
(4, 4, 55000, 20, '2023-09-01 00:00:00', '2023-09-12 16:45:00'),
(5, 5, 45000, 19, '2023-09-01 00:00:00', '2023-09-12 17:00:00');

DROP TABLE IF EXISTS leaves CASCADE;

CREATE TABLE "leaves" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "department" integer,
  "position" integer,
  "created_at" timestamp
);

INSERT INTO leaves
("id", "user", "department", "position", "created_at")
VALUES
(1, 1, 1, 1, '2023-09-12 17:00:00'),
(2, 2, 2, 2, '2023-09-12 17:15:00'),
(3, 3, 3, 3, '2023-09-12 17:30:00'),
(4, 4, 4, 4, '2023-09-12 17:45:00'),
(5, 5, 5, 5, '2023-09-12 18:00:00');

DROP TABLE IF EXISTS trainings CASCADE;

CREATE TABLE "trainings" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "department" integer,
  "position" integer,
  "created_at" timestamp
);

INSERT INTO trainings
("id", "user", "department", "position", "created_at")
VALUES
(1, 1, 1, 1, '2023-09-12 18:00:00'),
(2, 2, 2, 2, '2023-09-12 18:15:00'),
(3, 3, 3, 3, '2023-09-12 18:30:00'),
(4, 4, 4, 4, '2023-09-12 18:45:00'),
(5, 5, 5, 5, '2023-09-12 19:00:00');

DROP TABLE IF EXISTS attendances CASCADE;

CREATE TABLE "attendances" (
  "id" integer PRIMARY KEY,
  "user" integer,
  "department" integer,
  "position" integer,
  "date" timestamp,
  "created_at" timestamp
);

INSERT INTO attendances
("id", "user", "department", "position", "date", "created_at")
VALUES
(1, 1, 1, 1, '2023-09-01 09:00:00', '2023-09-12 19:00:00'),
(2, 2, 2, 2, '2023-09-01 09:15:00', '2023-09-12 19:15:00'),
(3, 3, 3, 3, '2023-09-01 09:30:00', '2023-09-12 19:30:00'),
(4, 4, 4, 4, '2023-09-01 09:45:00', '2023-09-12 19:45:00'),
(5, 5, 5, 5, '2023-09-01 10:00:00', '2023-09-12 20:00:00');


ALTER TABLE "departments" ADD FOREIGN KEY ("id") REFERENCES "users" ("department");

ALTER TABLE "positions" ADD FOREIGN KEY ("id") REFERENCES "users" ("position");

ALTER TABLE "employmentTypes" ADD FOREIGN KEY ("id") REFERENCES "users" ("employmentType");

ALTER TABLE "leaves" ADD FOREIGN KEY ("user") REFERENCES "users" ("id");

ALTER TABLE "trainings" ADD FOREIGN KEY ("user") REFERENCES "users" ("id");

ALTER TABLE "attendances" ADD FOREIGN KEY ("user") REFERENCES "users" ("id");

ALTER TABLE "leaves" ADD FOREIGN KEY ("user") REFERENCES "users" ("leave");

ALTER TABLE "trainings" ADD FOREIGN KEY ("user") REFERENCES "users" ("training");

ALTER TABLE "attendances" ADD FOREIGN KEY ("user") REFERENCES "users" ("attendance");

ALTER TABLE "users" ADD FOREIGN KEY ("id") REFERENCES "payrolls" ("user");
