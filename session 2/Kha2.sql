CREATE DATABASE UniversityDB;

CREATE SCHEMA university;

set search_path to university;

CREATE TABLE if not exists university.Students (
                                     student_id SERIAL PRIMARY KEY,
                                     first_name VARCHAR(50) NOT NULL,
                                     last_name VARCHAR(50) NOT NULL,
                                     birth_date DATE,
                                     email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE if not exists university.Courses (
                                    course_id SERIAL PRIMARY KEY,
                                    course_name VARCHAR(100) NOT NULL,
                                    credits INTEGER
);

CREATE TABLE if not exists university.Enrollments (
                                        enrollment_id SERIAL PRIMARY KEY,
                                        student_id  INTEGER REFERENCES university.Students(student_id),
                                        course_id INTEGER REFERENCES university.Courses(course_id),
                                        enroll_date DATE
);