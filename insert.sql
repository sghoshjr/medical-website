-- PIN Address
INSERT INTO `medicine`.`pin_address` (`PIN`, `Area`, `City`, `State`, `Country`) VALUES ('394270', 'Hazira', 'Surat', 'Gujarat', 'India');
INSERT INTO `medicine`.`pin_address` (`PIN`, `Area`, `City`, `State`, `Country`) VALUES ('700745', 'Patia', 'Bhubaneswar', 'Odisha', 'India');
INSERT INTO `medicine`.`pin_address` (`PIN`, `Area`, `City`, `State`, `Country`) VALUES ('450405', 'Simrol', 'Indore', 'Madhya Pradesh', 'India');
INSERT INTO `medicine`.`pin_address` (`PIN`, `Area`, `City`, `State`, `Country`) VALUES ('700100', 'Green Avenue', 'Kolkata', 'West Bengal', 'India');
INSERT INTO `medicine`.`pin_address` (`PIN`, `Area`, `City`, `State`, `Country`) VALUES ('100100', 'New Found', 'DreamCity', 'North', 'Inda');



-- Company
INSERT INTO `medicine`.`company` (`Name`, `PIN`) VALUES ('Phzfer', '700100');
INSERT INTO `medicine`.`company` (`Name`, `PIN`) VALUES ('Ranbaxy', '450405');
INSERT INTO `medicine`.`company` (`Name`, `PIN`) VALUES ('Mankind', '100100');
INSERT INTO `medicine`.`company` (`Name`, `PIN`) VALUES ('GlaxoSmithKline', '394270');
INSERT INTO `medicine`.`company` (`Name`, `PIN`) VALUES ('Novartis', '700745');
INSERT INTO `medicine`.`company` (`C_ID`, `Name`, `PIN`) VALUES ('6', 'Alkem', '700745');


-- Medicine

INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Crocin', '1 Tablet per 4-6 hrs. Max 3 Times a Day', '60.00');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Crocin - Fast Relief', '1 Tablet per 4-6 hrs. Max 3 Times a Day', '70.00');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Otrivin', '1-2 Drops per Nostril', '60.50');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Nasivion', '1-2 Drops per Nostril', '50.50');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('PAN-D', '1 Capsule per Day before Food.', '90.00');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Rantac', '1 Tablet before Food. Max twice daily.', '75.83');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Fluticon-FT', '2 Sprays per Nostril twice a day', '120.33');
INSERT INTO `medicine`.`medicine` (`M_ID`, `Name`, `Dosage`, `Price`) VALUES ('8', 'Volini', 'Spray a thin layer over affected region', '95');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Volini - Cream', 'Apply a thin layer over affected region', '100.50');
INSERT INTO `medicine`.`medicine` (`Name`, `Dosage`, `Price`) VALUES ('Ketosol-2%', 'Wash Affected Area with solution twice a day.', '150');


-- Medicine Type
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('1', 'Tablet');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('2', 'Tablet');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('3', 'Spray');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('4', 'Spray');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('5', 'Capsule');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('6', 'Tablet');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('7', 'Spray');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('8', 'Spray');
INSERT INTO `medicine`.`med_type` (`M_ID`, `type`) VALUES ('9', 'Cream/gel');

-- Components
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('1', 'Paracetamol');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('2', 'Oxymetazoline');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('3', 'Pantaprazole');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('4', 'Domperidone');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('5', 'Rantidine');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('6', 'Fluticasone Furoate');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('7', 'Methyl Salicylate');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('8', 'Menthol');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('9', 'Ketokonazole');
INSERT INTO `medicine`.`components` (`C_ID`, `cname`) VALUES ('10', 'Sodium Benzoate');


-- Contraindications
INSERT INTO `medicine`.`contraindication` (`C_ID1`, `C_ID2`) VALUES ('6', '9');

-- Compositions
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('1', '1');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('2', '1');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('3', '2');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('4', '2');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('5', '3');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('5', '4');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('6', '5');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('7', '6');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('8', '7');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('8', '8');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('9', '7');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('9', '8');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('10', '9');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('3', '10');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('4', '10');
INSERT INTO `medicine`.`composition` (`M_ID`, `C_ID`) VALUES ('7', '10');


-- Symtomps
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Fever');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Pain Relief');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Liver Damage');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Nasal Constriction');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Dizziness');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Blurred Vision');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Gastroenteritis');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Acidity');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Heartburn');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Nausea');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Vomiting');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Dry Mouth');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Nasal Rhinitis');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Pollen Allergy');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Increased Ketokonazole Concentration');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Increased Adrenaline bioavailability');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('BackPain');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Sprain');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Muscle Pain');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Dermatitis');
INSERT INTO `medicine`.`symptoms` (`sname`) VALUES ('Versicolor');


-- Side Effects
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('1', '3');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('2', '3');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('3', '5');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('3', '6');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('4', '5');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('4', '6');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('5', '12');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('7', '15');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('7', '16');
INSERT INTO `medicine`.`side_effects` (`M_ID`, `S_ID`) VALUES ('10', '15');

-- Treats
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('1', '1');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('1', '2');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('2', '1');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('2', '2');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('3', '4');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('4', '4');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('5', '7');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('5', '8');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('5', '9');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('5', '10');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('5', '11');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('6', '8');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('6', '9');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('7', '13');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('7', '14');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('8', '17');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('8', '18');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('8', '19');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('9', '17');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('9', '18');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('9', '19');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('10', '20');
INSERT INTO `medicine`.`treats` (`M_ID`, `S_ID`) VALUES ('10', '21');

UPDATE `medicine`.`medicine` SET `Info`='Crocin is an Analgesic and Antipyretic Agent that causes relieves pain. It has also shown to reduce fever by blocking pathways to brain that regulates temperature.' WHERE `M_ID`='1';
UPDATE `medicine`.`medicine` SET `Info`='Crocin is an Analgesic and Antipyretic Agent that causes relieves pain. It has also shown to reduce fever by blocking pathways to brain that regulates temperature.' WHERE `M_ID`='2';
UPDATE `medicine`.`medicine` SET `Info`='Otrivin works by constricting the blood vessels and reducing the mucus lining inside the nasal pathway allowing for more airflow.' WHERE `M_ID`='3';
UPDATE `medicine`.`medicine` SET `Info`='Nasivion works by constricting the blood vessels and reducing the mucus lining inside the nasal pathway allowing for more airflow.' WHERE `M_ID`='4';
UPDATE `medicine`.`medicine` SET `Info`='PAN-D is a proton pump inhibitor that blocks the secretion of gastric juices relieving the symptoms. Domperidone is also known for reducing vomiting fits.' WHERE `M_ID`='5';
UPDATE `medicine`.`medicine` SET `Info`='Rantac is a anti-histamine that blocks the secretion of excess gastric juices relieving symptoms.' WHERE `M_ID`='6';
UPDATE `medicine`.`medicine` SET `Info`='Fluticon-FT [LSD]  is a topical Steroid that reduces inflamation of inner lining of nasal passage. ' WHERE `M_ID`='7';
UPDATE `medicine`.`medicine` SET `Info`='Volini causes the muscles to relax thus relieving muscle pains.' WHERE `M_ID`='8';
UPDATE `medicine`.`medicine` SET `Info`='Volini causes the muscles to relax thus relieving muscle pains.' WHERE `M_ID`='9';
UPDATE `medicine`.`medicine` SET `Info`='Ketoconazole is used by treating various skin disease like dermatitis and versicolor.' WHERE `M_ID`='10';






-- -----------------------------------------
-- --
-- -- SQL Query used
-- --
-- -----------------------------------------

-- 1

SELECT m.M_ID as `#ID`, m.Name as `Medicine`, c.Name as `Company`, m.Price 

	FROM medicine m, company c, manufacturer mf 

	WHERE
		
        m.M_ID = mf.M_ID AND
        mf.C_ID = c.C_ID WHERE m.Name LIKE '%keyword%' ORDER BY m.M_ID LIMIT 25;
        
        
        
-- 

SELECT C_ID, Name, c.PIN, p.Area, p.City, p.State, p.Country FROM company c, pin_address p WHERE
	
    c.PIN = p.PIN AND
    Name LIKE '%keyword%'
    ORDER BY C_ID
    LIMIT 25;
	
    
--

SELECT * FROM components;

-- 


SELECT cname FROM components WHERE components.C_ID = 
     (SELECT C_ID2 AS `cnamereq` FROM medicine m, composition cmp, components c, 		contraindication cin

			WHERE m.M_ID = 7 AND m.M_ID = cmp.M_ID AND cmp.C_ID = c.C_ID AND 				c.C_ID = cin.C_ID1)
            
UNION

SELECT cname FROM components WHERE components.C_ID = 
     (SELECT C_ID1 AS `cnamereq` FROM medicine m, composition cmp, components c, 		contraindication cin

			WHERE m.M_ID = 7 AND m.M_ID = cmp.M_ID AND cmp.C_ID = c.C_ID AND 				c.C_ID = cin.C_ID2)
    
    

