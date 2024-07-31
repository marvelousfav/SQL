-- chapter5 

-- Listing 5-1: Basic addition, subtraction and multiplication with SQL

SELECT 2 + 2;    -- addition
SELECT 9 - 1;    -- subtraction
SELECT 3 * 4;    -- multiplication

-- Listing 5-2: Integer and decimal division with SQL

SELECT 11 / 6;   -- integer division
SELECT 11 % 6;   -- modulo division
SELECT 11.0 / 6; -- decimal division
SELECT CAST(11 AS numeric(3,1)) / 6;

-- Listing 5-3: Exponents, roots and factorials with SQL

SELECT 3 ^ 4;    -- exponentiation
SELECT |/ 10;    -- square root (operator)
SELECT sqrt(10); -- square root (function)
SELECT ||/ 10;   -- cube root
SELECT factorial (4);      -- factorial

-- Order of operations

SELECT 7 + 8 * 9; 	-- answer: 79
SELECT (7 + 8) * 9;	-- answer: 135

SELECT 3 ^ 3 - 1;   -- answer: 26
SELECT 3 ^ (3 - 1); -- answer: 9

-- Listing 5-4: Selecting Census population columns by race with aliases

SELECT geo_name,
       state_us_abbreviation AS "st",
       p0010001 AS "Total Population",
       p0010003 AS "White Alone",
       p0010004 AS "Black or African American Alone",
       p0010005 AS "Am Indian/Alaska Native Alone",
       p0010006 AS "Asian Alone",
       p0010007 AS "Native Hawaiian and Other Pacific Islander Alone",
       p0010008 AS "Some Other Race Alone",
       p0010009 AS "Two or More Races"
FROM us_counties_2010;

-- Listing 5-5: Adding two columns in us_counties_2010

SELECT geo_name,
       state_us_abbreviation AS "st",
       p0010003 AS "White Alone",
       p0010004 AS "Black Alone",
       p0010003 + p0010004 AS "Total White and Black"
FROM us_counties_2010;

-- Listing 5-6: Checking Census data totals

SELECT geo_name,
       state_us_abbreviation AS "st",
       p0010001 AS "Total",
       p0010003 + p0010004 + p0010005 + p0010006 + p0010007
           + p0010008 + p0010009 AS "All Races",
       (p0010003 + p0010004 + p0010005 + p0010006 + p0010007
           + p0010008 + p0010009) - p0010001 AS "Difference"
FROM us_counties_2010
ORDER BY "Difference" DESC;

-- Listing 5-7: Calculating the percent of the population that is 
-- Asian by county (percent of the whole)

SELECT geo_name,
       state_us_abbreviation AS "st",
       (CAST(p0010006 AS numeric(8,1)) / p0010001) * 100 AS "pct_asian"
FROM us_counties_2010
ORDER BY "pct_asian" DESC;

-- Listing 5-8: Calculating percent change

CREATE TABLE percent_change (
    department varchar(20),
    spend_2014 numeric(10,2),
    spend_2017 numeric(10,2)
);

INSERT INTO percent_change
VALUES
    ('Building', 250000, 289000),
    ('Assessor', 178556, 179500),
    ('Library', 87777, 90001),
    ('Clerk', 451980, 650000),
    ('Police', 250000, 223000),
    ('Recreation', 199000, 195000);

SELECT department,
       spend_2014,
       spend_2017,
       round( (spend_2017 - spend_2014) /
                    spend_2014 * 100, 1 ) AS "pct_change"
FROM percent_change;

