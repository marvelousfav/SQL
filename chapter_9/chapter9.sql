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