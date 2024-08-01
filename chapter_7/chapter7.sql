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