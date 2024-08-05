-- chapter 9

-- Listing 9-1: Importing the FSIS Meat, Poultry, and Egg Inspection Directory
-- https://catalog.data.gov/dataset/meat-poultry-and-egg-inspection-directory-by-establishment-name

CREATE TABLE meat_poultry_egg_inspect (
    est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
    company varchar(100),
    street varchar(100),
    city varchar(30),
    st varchar(2),
    zip varchar(5),
    phone varchar(14),
    grant_date date,
    activities text,
    dbas text
);

COPY meat_poultry_egg_inspect
FROM 'C:\bootcamp.docs\5_SQL\my_work\chapter_9\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

CREATE INDEX company_idx ON meat_poultry_egg_inspect (company);

-- Count the rows imported:
SELECT count(*) FROM meat_poultry_egg_inspect;

-- Listing 9-2: Finding multiple companies at the same address
SELECT company,
       street,
       city,
       st,
       count(*) AS address_count
FROM meat_poultry_egg_inspect
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

-- Listing 9-3: Grouping and counting states
SELECT st, 
       count(*) AS st_count
FROM meat_poultry_egg_inspect
GROUP BY st
ORDER BY st;

-- Listing 9-4: Using IS NULL to find missing values in the st column
SELECT est_number,
       company,
       city,
       st,
       zip
FROM meat_poultry_egg_inspect
WHERE st IS NULL;

-- Listing 9-5: Using GROUP BY and count() to find inconsistent company names

SELECT company,
       count(*) AS company_count
FROM meat_poultry_egg_inspect
GROUP BY company
ORDER BY company ASC;

-- Listing 9-6: Using length() and count() to test the zip column

SELECT length(zip),
       count(*) AS length_count
FROM meat_poultry_egg_inspect
GROUP BY length(zip)
ORDER BY length(zip) ASC;

-- Listing 9-7: Filtering with length() to find short zip values

SELECT st,
       count(*) AS st_count
FROM meat_poultry_egg_inspect
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;

-- Listing 9-8: Backing up a table

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT * FROM meat_poultry_egg_inspect;

-- Check number of records:
SELECT 
    (SELECT count(*) FROM meat_poultry_egg_inspect) AS original,
    (SELECT count(*) FROM meat_poultry_egg_inspect_backup) AS backup;

-- Listing 9-9: Creating and filling the st_copy column with ALTER TABLE and UPDATE

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN st_copy varchar(2);

UPDATE meat_poultry_egg_inspect
SET st_copy = st;

-- Listing 9-10: Checking values in the st and st_copy columns

SELECT st,
       st_copy
FROM meat_poultry_egg_inspect
ORDER BY st;

-- Listing 9-11: Updating the st column for three establishments

UPDATE meat_poultry_egg_inspect
SET st = 'MN'
WHERE est_number = 'V18677A';

UPDATE meat_poultry_egg_inspect
SET st = 'AL'
WHERE est_number = 'M45319+P45319';

UPDATE meat_poultry_egg_inspect
SET st = 'WI'
WHERE est_number = 'M263A+P263A+V263A';