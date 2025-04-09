INSERT INTO COMPANIES (COMPANY_ID, COMPANY_NAME) VALUES (1, 'Hyundai');
INSERT INTO COMPANIES (COMPANY_ID, COMPANY_NAME) VALUES (2, 'Tesla');
INSERT INTO COMPANIES (COMPANY_ID, COMPANY_NAME) VALUES (3, 'Toyota');

INSERT INTO CAR_INFORS (CAR_NAME, YEAR, CAR_INFOR_ID, COMPANY_ID) VALUES 
('Hyundai Sonata', 2020, 1, 1),
('Tesla Model S', 2021, 2, 2),
('Toyota Camry', 2019, 3, 3),
('Kia Optima', 2018, 4, 1),
('Tesla Model X', 2021, 5, 2),
('Toyota Corolla', 2018, 6, 3),
('Hyundai Elantra', 2019, 7, 1),
('Kia Sorento', 2020, 8, 1),
('Tesla Model 3', 2021, 9, 2),
('Toyota Prius', 2017, 10, 3),
('Hyundai Tucson', 2021, 11, 1),
('Kia Sportage', 2019, 12, 1),
('Tesla Model Y', 2021, 13, 2),
('Toyota RAV4', 2020, 14, 3),
('Hyundai Santa Fe', 2018, 15, 1),
('Kia Telluride', 2021, 16, 1),
('Tesla Roadster', 2022, 17, 2),
('Toyota Highlander', 2019, 18, 3),
('Hyundai Kona', 2020, 19, 1),
('Kia Forte', 2018, 20, 1);

INSERT INTO factorys (FACTORY_ID, FACTORY_NAME, LOCATION, COMPANY_ID) VALUES (1, 'Hyundai Ulsan Plant', 'Ulsan', 1);
INSERT INTO factorys (FACTORY_ID, FACTORY_NAME, LOCATION, COMPANY_ID) VALUES (2, 'Tesla Fremont Factory', 'California', 2);
INSERT INTO factorys (FACTORY_ID, FACTORY_NAME, LOCATION, COMPANY_ID) VALUES (3, 'Toyota Kentucky Plant', 'Kentucky', 3);
