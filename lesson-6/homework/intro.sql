Question: Explain at least two ways to find distinct values based on two columns.

Input table (InputTbl):

| col1 | col2 |
|------|------|
| a    | b    |
| a    | b    |
| b    | a    |
| c    | d    |
| c    | d    |
| m    | n    |
| n    | m    |

Result should be like this:

| col1 | col2 |
|------|------|
| a    | b    |
| c    | d    |
| m    | n    |

   CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
 INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

first way
SELECT DISTINCT
  LEAST(col1, col2) AS col1,
  GREATEST(col1, col2) AS col2
FROM stranger;
second way
SELECT DISTINCT col1, col2
FROM stranger;

Puzzle 2: Removing Rows with All Zeroes

Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
Table Schema:

CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

		SELECT * FROM zero
WHERE A + B + C + D <> 0


Puzzle 3: Find those with odd ids

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
	   select * from one
	   where id % 2 = 0
