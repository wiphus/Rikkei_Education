CREATE DATABASE ElearningDB;

CREATE SCHEMA elearning;

set search_path to elearning;

CREATE TABLE Students (
                                    student_id SERIAL PRIMARY KEY,
                                    first_name VARCHAR(50) NOT NULL,
                                    last_name VARCHAR(50) NOT NULL,
                                    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Instructors (
                                       instructor_id SERIAL PRIMARY KEY,
                                       first_name VARCHAR(50) NOT NULL,
                                       last_name VARCHAR(50) NOT NULL,
                                       email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Courses (
                                   course_id SERIAL PRIMARY KEY,
                                   course_name VARCHAR(100) NOT NULL,
                                   instructor_id INTEGER REFERENCES Instructors(instructor_id)
);

CREATE TABLE Enrollments (
                                       enrollment_id SERIAL PRIMARY KEY,
                                       student_id INTEGER REFERENCES Students(student_id),
                                       course_id INTEGER REFERENCES Courses(course_id),
                                       enroll_date DATE NOT NULL,
                                       UNIQUE (student_id, course_id)
);

CREATE TABLE Assignments (
                                       assignment_id SERIAL PRIMARY KEY,
                                       course_id INTEGER REFERENCES Courses(course_id),
                                       title VARCHAR(100) NOT NULL,
                                       due_date DATE NOT NULL
);

CREATE TABLE Submissions (
                                       submission_id SERIAL PRIMARY KEY,
                                       assignment_id INTEGER REFERENCES Assignments(assignment_id),
                                       student_id INTEGER REFERENCES Students(student_id),
                                       submission_date DATE NOT NULL,
                                       grade NUMERIC(5, 2) CHECK (grade >= 0 AND grade <= 100),
                                       UNIQUE (assignment_id, student_id)
);