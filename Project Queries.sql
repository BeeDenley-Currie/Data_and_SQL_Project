CREATE DATABASE BERC
USE BERC
CREATE TABLE Species (
species_id INT NOT NULL PRIMARY KEY,
scientific_name VARCHAR(50) NOT NULL,
common_name VARCHAR(50), 
taxon VARCHAR(15) NOT NULL
);

CREATE TABLE Location (
Location_id INT NOT NULL PRIMARY KEY,
Loc_name VARCHAR(50) NOT NULL,
Loc_area VARCHAR(50) NOT NULL, 
Habitat_type VARCHAR(15) NOT NULL
);

CREATE TABLE Recorder (
Recorder_id INT NOT NULL PRIMARY KEY,
Rec_first_name VARCHAR(50),
Rec_last_name VARCHAR(50), 
Rec_email VARCHAR(50) NOT NULL,
Rec_group VARCHAR(50) 
);

CREATE TABLE Observation (
Observation_id INT NOT NULL PRIMARY KEY,
Obs_date DATE NOT NULL,
Spec_id INT NOT NULL,
Obs_number INT,
Loc_id INT NOT NULL,
Rec_id INT,
FOREIGN KEY (Spec_id) REFERENCES Species(Species_id),
FOREIGN KEY (Loc_id) REFERENCES Location(Location_id),
FOREIGN KEY (Rec_id) REFERENCES Recorder(Recorder_id)
);

CREATE TABLE Billing (
Billing_id INT NOT NULL PRIMARY KEY,
Billing_line1 VARCHAR(50) NOT NULL,
Billing_line2 VARCHAR(50) NOT NULL, 
Billing_town VARCHAR(50) NOT NULL,
Billing_county VARCHAR(50) NOT NULL, 
Billing_postcode VARCHAR(8) NOT NULL,
Billing_method VARCHAR(50) NOT NULL
);

CREATE TABLE Customer (
Customer_id INT NOT NULL PRIMARY KEY,
Cust_first_name VARCHAR(50),
Cust_last_area VARCHAR(50), 
Cust_email VARCHAR(50) NOT NULL,
Bill_id INT NOT NULL,
FOREIGN KEY (Bill_id) REFERENCES Billing(Billing_id)
);

CREATE TABLE Orders (
Order_id INT NOT NULL PRIMARY KEY,
Order_date DATE NOT NULL,
Order_Area VARCHAR(50) NOT NULL,
Cust_id INT NOT NULL,
FOREIGN KEY (Cust_id) REFERENCES Customer(Customer_id)
);

--------------------------------------------------------------------------------------------
/* CHUNKY VIEW AS A RECORD OVERVIEW */
CREATE OR REPLACE VIEW Obs_overview AS
    SELECT 
        obs.Observation_id AS ID,
        obs.Obs_date AS date,
        spec.scientific_name AS Scientific_Name,
        spec.common_name AS Common_Name,
        spec.taxon AS Taxon,
        obs.Obs_number AS Number_Seen,
        loc.loc_name AS Location,
        loc.Loc_area AS Area,
        rec.rec_first_name AS Recorder_First_Name,
        rec.rec_last_name AS Recorder_Last_Name
    FROM
        Observation obs
            INNER JOIN
        Species spec ON obs.Spec_id = spec.Species_id
            INNER JOIN
        Location loc ON obs.loc_id = loc.location_id
            INNER JOIN
        Recorder rec ON obs.rec_id = rec.recorder_id;

-- example use of view to arrange results
SELECT * FROM Obs_overview
WHERE Taxon= 'Mammal' -- this can of course be changed/removed to see all taxa/view a different one
ORDER BY Date DESC;

/* CHUNKY VIEW AS AN ORDER OVERVIEW */
CREATE OR REPLACE VIEW Ord_overview
AS
	SELECT ord.Order_id, ord.Order_date AS date, Ord.Order_Area AS Order_Area, Cust.Cust_First_Name AS First_Name, Cust.Cust_Last_Name AS Last_Name, Cust.Cust_email AS email, Bill.Billing_method AS Billing_Method
    FROM Orders ord
    INNER JOIN Customer cust
    ON ord.Cust_Id = cust.Customer_id
    INNER JOIN Billing bill
    ON cust.Bill_id = Bill.Billing_id
    ORDER BY date DESC;
    
-- example query    
SELECT * FROM Ord_overview;

--------------------------------------------------------------------------------------------
/*SUBQUERY - finding a species in the database we don't have any observations for*/
SELECT 
    scientific_name, common_name, taxon
FROM
    species
WHERE
    species_id NOT IN (SELECT DISTINCT
            spec_id
        FROM
            observation)
ORDER BY taxon;

/* Liked this feature, decided to recreate it as a STORED FUNCTION to show years since last sighting OR that it's never been recorded */
DELIMITER // 
CREATE FUNCTION yrs_since(Last_Seen DATE) RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
DECLARE Since VARCHAR(20);
DECLARE now DATE;
	IF Last_Seen IS NULL THEN
    SET Since = 'Not Seen';
    RETURN Since;
    ELSE SELECT current_date() into now;
 RETURN year(now)-year(Last_Seen);
 END IF;
 END //
 DELIMITER ;
 
-- Example query
SELECT 
    MAX(obs.obs_date) AS Last_seen,
    YRS_SINCE(MAX(obs.obs_date)) AS 'Yrs since last sighting',
    spec.scientific_name,
    spec.common_name
FROM
    species spec
        LEFT JOIN
    observation obs ON spec.species_id = obs.spec_id
GROUP BY spec.species_id
ORDER BY Last_Seen;

--------------------------------------------------------------------------------------------
/* STORED PROCEDURE with SUBQUERY! Getting a report for the location requested in each order */
DELIMITER //
CREATE PROCEDURE GetOrderForReport(IN Order_Number INT)
BEGIN
	DECLARE search_loc VARCHAR(50);
		SET search_loc = (
							SELECT 
                            Order_Area
                            FROM
                            Orders
                            WHERE
                            Order_ID = Order_Number);
	SELECT * FROM Obs_Overview ob
    WHERE search_loc = ob.area
    ORDER BY date
    ;
END //
DELIMITER ; 

-- example query - add your order # i.e. 1:
CALL GetOrderForReport(21);

--------------------------------------------------------------------------------------------
/* MY TRIGGER AND A RELATED STORED PROCEDURE - I've set up the trigger so that when the sproc is called the scientific and common names added will be in the right format,
 to ensure best practice for DML - */
DELIMITER //
CREATE TRIGGER species_validation
BEFORE INSERT
ON species
FOR EACH ROW
BEGIN
	SET NEW.scientific_name = CONCAT(UPPER(SUBSTRING(NEW.scientific_name ,1,1)), LOWER(SUBSTRING(NEW.scientific_name FROM 2))),
		NEW.common_name = CONCAT(UPPER(SUBSTRING(NEW.common_name ,1,1)), LOWER(SUBSTRING(NEW.common_name FROM 2)));
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddSpecies(IN Species_ID INT, IN Scientific_name VARCHAR(50), IN common_name VARCHAR(50), taxon VARCHAR(15))
BEGIN
	INSERT INTO species
    (species_id, scientific_name, common_name, taxon)
    VALUES
    (species_id, scientific_name, common_name, taxon)
    ;
END //
DELIMITER ; 

-- example query for showing how trigger and sproc manage the data insert
CALL AddSpecies(51, 'TEST SPECIES', 'TEST', 'TEST');
Select * from Species;

--------------------------------------------------------------------------------------------
/* MY GROUP BY AND HAVING QUERY - looking at our 'top scorers' of record submitters, for a given taxon */
SELECT 
    Rec.Recorder_ID,
    Rec.Rec_first_name,
    Rec.Rec_last_name,
    Rec.Rec_group,
    SUM(Obs.Obs_number) AS Number_Seen
FROM
    Observation Obs
        LEFT JOIN
    Recorder Rec ON Rec.Recorder_id = Obs.Rec_ID
        LEFT JOIN
    Species spec ON spec.species_id = Obs.spec_ID
WHERE
    spec.taxon = 'Mammal'
GROUP BY Rec.Recorder_ID
HAVING Number_Seen >= 5
ORDER BY Number_Seen DESC;