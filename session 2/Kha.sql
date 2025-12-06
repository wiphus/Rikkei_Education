CREATE DATABASE LibraryDB;

CREATE SCHEMA library;

set search_path to library;

CREATE TABLE library.Books (
                               book_id SERIAL PRIMARY KEY,
                               title VARCHAR(100) NOT NULL,
                               author VARCHAR(50) NOT NULL,
                               published_year INTEGER,
                               price NUMERIC(10, 2)
);
