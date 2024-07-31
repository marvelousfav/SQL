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

