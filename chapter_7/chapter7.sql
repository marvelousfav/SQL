-- chapter 7

-- Listing 7-1: Declaring a single-column natural key as primary key

-- As a column constraint
CREATE TABLE natural_key_example (
    license_id varchar(10) CONSTRAINT license_key PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50)
);

-- Drop the table before trying again
DROP TABLE natural_key_example;

-- As a table constraint
CREATE TABLE natural_key_example (
    license_id varchar(10),
    first_name varchar(50),
    last_name varchar(50),
    CONSTRAINT license_key PRIMARY KEY (license_id)
);

-- Listing 7-2: Example of a primary key violation
INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Sam', 'Tracy');

-- Listing 7-3: Declaring a composite primary key as a natural key
CREATE TABLE natural_key_composite_example (
    student_id varchar(10),
    school_day date,
    present boolean,
    CONSTRAINT student_key PRIMARY KEY (student_id, school_day)
);

-- Listing 7-4: Example of a composite primary key violation

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2017/01/22', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2017/01/23', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2017/01/23', 'N');     -- when the date is the same you get an error