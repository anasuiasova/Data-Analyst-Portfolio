USE master
GO

IF EXISTS (SELECT * FROM sysdatabases WHERE NAME='ClinicData')
		DROP DATABASE ClinicData
GO

CREATE DATABASE ClinicData
GO

/* I developed a prototype database for a small medical clinic offering healthcare services 
to medical tourists visiting Israel, as well as private consultations for both 
- international patients and Israeli residents. */

USE ClinicData
GO
    
/* Stores personal and contact information about patients who receive medical services at the clinic.
Each patient can have multiple visits over time. */

CREATE TABLE Patients
(PatientID INT IDENTITY (1,1),
NationalID NVARCHAR (20) NULL,
FirstName NVARCHAR (60) NOT NULL,
LastName NVARCHAR (60) NOT NULL, 
Country VARCHAR (30) NULL,
BirthDate DATE NULL,
Sex VARCHAR(1) NULL,
Phone NVARCHAR (20) NULL,
Email NVARCHAR (100) NULL,
CreatedAt DATE NOT NULL DEFAULT GETDATE (),
CONSTRAINT cln_patid_pk PRIMARY KEY (PatientID),
CONSTRAINT cln_email_unique UNIQUE (Email),
CONSTRAINT cln_email_ck CHECK (Email LIKE '%@%.%'));
GO

INSERT INTO Patients (NationalID,FirstName,LastName,Country,BirthDate,Sex,Phone,Email,CreatedAt)
VALUES ('FM56745163','Loren','Brazhnik','USA','11/03/1978','F','+1354672873','lorbrazh@gmail.com','04/05/2022'),
       ('7453104524','Ekaterina','Lubovsky','Russia','04/01/1983','F','+79169524827','katenlub@gmail.com','03/07/2022'),
       ('C06257315','Emilia','Kachiani','Italia','08/07/1965','F','+39716524864','kachemil@gmail.com','10/05/2022'),
       ('7452739173','Ivan','Stepanenko','Russia','01/03/1984','M','+79854264712','stepa84@gmail.com','07/05/2022'),
       ('K00514368','Aleksandr','Lanin','Cyprus','03/07/1956','M','+35773142586','alexlan@gmail.com','07/05/2022'),
       ('774236595','Victor','Gorin','Russia','07/24/1974','M','+79036378193','victor1974@gmail.com','07/06/2022'),
       ('GG746354','Bogdan','Polezhuk','Ukraine','03/06/2007','M','+3804162473','annapol@gmail.com','03/08/2022'),
       ('P35267AA','Mathew','Levi','Canada','06/10/1995','M','+13398472034','mathew95@gmail.com','10/18/2022'),
       (NULL,'Lucio','Armando','Mexico',NULL,'M','+5263791826','armandothebest@gmail.com','12/12/2022'),
       ('P35538AA','Cody','Zinger','Canada','06/24/1981','M','+13367597087','zingxod@gmail.com','12/31/2022'),
       ('773649506','Vladimir','Mirniy','Ukraine','03/20/1969','M',NULL,'mirvlad@gmail.com','01/11/2023'),
       ('CK7263846','Dalia','Goldshtein','Switzerland','04/15/1985','F','+416527498745','dalgold85@gmail.com','02/01/2023'),
       ('775325468','Yakov','Itzhakov','Russia','03/13/1965','M','+79154867324','yakitz@gmail.com','03/22/2023'),
       ('ZK7643DD','Ahmodjon','Ahmabaev','Aizerbaijan','11/06/2009','M','+7965283764','ahma@gmail.com','06/29/2023'),
       (NULL,'Daniel','Abraham','Israel','05/13/1993','F','+972536254865','danipadani@gmail.com','07/17/2023'),
       ('342657192','Beni','Abramov','Israel','01/07/1974','M','+972537461824','abeni@gmail.com','08/06/2023'),
       ('638294635','Fiona','Galagher','USA',NULL,'F','+18374562994','fionag@gmail.com','10/23/2023'),
       ('640485104','Lip','Galagher','USA','05/23/2007','M','+18506372811','lipg@gmail.com','10/23/2023'),
       ('640726391','Ian','Galagher','USA','11/14/2008','M','+1625983473','iang@gmail.com','10/23/2023'),
       ('775382345','Ludmia','Staselovich',NULL,'05/26/1970','F','+79036485635','ludochka704@gmail.com','12/28/2023'),
       ('CK4857630','Ruslan','Plezhchik','Poland','12/06/1987','M','+38041624467','plezhrusik@gmail.com','01/19/2024'),
       ('639284756','Mandy','Milkovich','USA','08/04/2005','F','+1746363923','milkmandyk@gmail.com','02/05/2024'),
       ('IT8461404','Alessandro','Matzioni','Italia','04/15/1959','M','+39475273845','alessmatz@gmail.com','03/30/2024'),
       ('342657814','Noga','Geller','Israel','01/28/1990','F','+972546371826','gellernoga@gmail.com','03/30/2024'),
       (NULL,'David','Shnider','Israel','04/16/1991','M','+972527648326','davidshn@gmail.com','05/11/2024'),
       ('GG0651728','Inna','Gutman','Ukraine','09/15/1989','F','+38075297543','gutinna@gmail.com','06/19/2024'),
       ('CK4847839','Nikola','Gutnik','Poland','07/23/1975','M',NULL,'nikolahello@gmail.com','08/09/2024'),
       ('745627194','Victoria','Cherno','Russia','03/12/1995','F','+79163546185','chervika@gmail.com','10/02/2024'),
       ('342657829','Moshe','Diretzki','Israel','04/16/1987','M','+972534256923','moshmosh@gmail.com','11/19/2024'),
       ('P374626AA','Anabell','Dollev','Canada','09/17/1995','F','+16549461482','anabell95@gmail.com','12/01/2024'),
       ('342675849','Lucy','Cohen','Israel','05/24/1971','F','+972527535511','cohen0524@gmail.com','02/12/2025'),
       ('752835674','Anastasiia','Kuzmina','Russia','11/24/1997','F','+79853421528','nastusha11@gmail.com','03/01/2025'),
       ('BR6758842','Konstantin','Luzovenko','Belarusia','04/30/1964','M','+345627854194','luzkon@gmail.com','05/24/2025'),
       ('BR5327965','Marina','Luzovenko','Belarusia','03/21/1966','F','+346328645876','marishaluzov@gmail.com','05/24/2025'),
       ('752437386','Elizaveta','Ivanova','Russia','04/21/1985','F','+79156273645','alizavetka85@gmail.com','07/03/2025'),
       ('342865468','Jovi','Magen','Israel','09/26/1989','M','+972527628415','jojomag@gmail.com','09/19/2025'),
       ('201456372','Ester','Levinshtein','Israel','03/08/1959','F','+972527455412','esterlesht@gmail.com','10/12/2025'),
       ('BR7464926','Oksana','Bolotova','Belarusia',NULL,'F','+385284639662','boloksana@gmail.com',DEFAULT),
       ('753629470','Maya','Trushina','Russia','05/11/2001','F','+79174263955','trush2001@gmail.com',DEFAULT),
       (NULL,'Amanda','Vaknin','Israel',NULL,'F','+972534263177','amanda97@gmail.com',DEFAULT);
GO

/* Represents clinic locations where medical services are provided.
Stores address and contact details used to identify where a visit takes place. */

CREATE TABLE Clinics
(ClinicID INT IDENTITY (1,1),
ClinicName NVARCHAR(100) NOT NULL,
City NVARCHAR(80) NULL,
Address NVARCHAR(150) NULL,
Phone NVARCHAR(20) NULL,
IsActive NVARCHAR(15) NOT NULL DEFAULT 'Yes',
CONSTRAINT clID_clinics_pk PRIMARY KEY (ClinicID))
GO

INSERT INTO Clinics (ClinicName,City,Address,Phone,IsActive)
VALUES ('Ichilov - Tel Aviv Sourasky Medical Center','Tel-Aviv Yaffo','Weitzmann Street 8',NULL,DEFAULT),
('Assuta Ramat Ahayal','Tel-Aviv Yaffo','HaBarzel Street 20',NULL,DEFAULT),
('Ramat Aviv Medical Center','Tel-Aviv Yaffo','Einshtein Street 40','+036401222',DEFAULT),
('Herzliya Medical Center','Herzliya','Hahoshlim Street 8','+099592999',DEFAULT),
('Assuta Ashdod','Ashdod','Ha-Refua Street 7',NULL,DEFAULT),
('Assia Medical','Tel-Aviv Yaffo','HaBrzel Street 11','+0747050130',DEFAULT),
('JMedical','Tel-Aviv Yaffo','Weizmann Street 14','+0364011245',DEFAULT),
('GastroMed','Tel-Aviv Yaffo','Weizmann Street 14',NULL,'Not Active'),
('Tel Aviv Medical Center','Tel-Aviv Yaffo','Kaufmann Street 6','+0732324866',DEFAULT),
('TopClinicIchilov','Tel-Aviv Yaffo','Weizmann Street 14','+032647328',DEFAULT),
('Mercaz LeShavatz','Tel-Aviv Yaffo','Weizmann Street 14',NULL,DEFAULT);
GO

/* Contains data about clinic employees, such as call center agents, administrators, and billing staff.
Employees are responsible for creating visits, processing payments, and managing operations. */

CREATE TABLE Employees
(EmployeeID INT IDENTITY (1,1),
FirstName NVARCHAR (60) NOT NULL,
LastName NVARCHAR (60) NOT NULL, 
ReportsTo INT NULL,
Department VARCHAR (30) NULL,
BirthDate DATE NULL,
HireDate DATE NULL,
Phone NVARCHAR (20) NULL,
Email NVARCHAR (100) NULL,
CONSTRAINT emp_empid_pk PRIMARY KEY (EmployeeID),
CONSTRAINT emp_email_unique UNIQUE (Email),
CONSTRAINT emp_email_ck CHECK (Email LIKE '%@%.%'),
CONSTRAINT emp_rep_chk CHECK (ReportsTo IS NULL OR ReportsTo <> EmployeeID));
GO

INSERT INTO Employees (FirstName,LastName,ReportsTo,Department,BirthDate,HireDate,Phone,Email)
VALUES ('Michael','Popov',NULL,'CEO','07/25/1966','04/01/2010','+972536712834','popovm@clinic.com'),
('Evgenii','Ganevich',NULL,'CEO','04/11/1973','07/15/2013','+972525791273','ganevichbenim@clinic.com'),
('Michael','Israelov',7,'Attendants','03/21/1972','09/23/2015','+972521657432','micham@clinic.com'),
('Alexey','Bakushin',1,'Medical Advisers','03/09/1980','02/16/2017','+972527859372','bakush@clinic.com'),
('Evgenii','Deltsov',2,'Management','05/20/1983','05/13/2017','+972534756269','deltevg@clinic.com'),
('Anton','Lotnikov',7,'Attendants','06/21/1992','04/30/2023','+972526384195','antoni@clinic.com'),
('Anastasiia','Svisov',2,'Management','02/09/1995','06/03/2023','+972525438245','svisov@clinic.com'),
('Anna','Trushina',7,'Attendants','06/05/1967','04/12/2017','+972526749123','annatrush@clinic.com'),
('Oksana','Ganevich',7,'Coordinators','10/17/1968','11/15/2025','+972536254816','oksgan@clinic.com'),
('Elena','Khineva',1,'Call Center','09/10/1970','01/27/2017','+972524639210','khinelena@clinic.com'),
('Ekaterina','Nazarova',1,'Call Center','08/14/1978','01/27/2017','+972523782956','nazekat@clinic.com'),
('Natalia','Kramer',1,'Call Center','01/10/1979','01/27/2017','+972526572925','kramer@clinic.com'),
('Lana','Tsevaeva',1,'Call Center','05/12/1968','01/27/2017','+972524527145','tsevaeva@clinic.com');
GO

/* Stores information about external doctors who provide medical services but are not clinic employees.
Doctors are assigned to patient visits and may perform specific medical procedures. */

CREATE TABLE Doctors
(DoctorID INT IDENTITY (1,1),
FirstName NVARCHAR (60) NOT NULL,
LastName NVARCHAR (60) NOT NULL,
Speciality NVARCHAR (80) NULL,
Phone NVARCHAR (20) NULL,
Email NVARCHAR (100) NULL,
ClinicID INT NULL,
Address NVARCHAR (100) NULL,
CONSTRAINT doc_empid_pk PRIMARY KEY (DoctorID),
CONSTRAINT doc_email_unique UNIQUE (Email),
CONSTRAINT doc_email_ck CHECK (Email LIKE '%@%.%'),
CONSTRAINT doc_clinic_fk FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID))
GO

INSERT INTO Doctors (FirstName,LastName,Speciality,Phone,Email,ClinicID,Address)
VALUES ('Irina','Letanski','Oncologist','+972524839134','letirina@gmail.com',1,'Weizmann 6 Tel-Aviv Yaffo'),
('Ronen','Kan','Ortoped','+972532164254','kanroni@gmail.com',1,'Weizmann 9 Tel-Aviv Yaffo'),
('Ravid','Deby','Oncologist','+972525427568','ravid70@gmail.com',1,'Weizmann 9 Tel-Aviv Yaffo'),
('Alexander','Galochnikov','Gastroenterolog','+972528759435','alexgaloch@gmail.com',2,'HaBarzel 20 Tel-Aviv Yaffo'),
('Ada','Fagan','Onco-surgeon','+972536128564','fagan@gmail.com',2,'HaBarzel 20 Tel-Aviv Yaffo'),
('Adnan','Amid','Plastic Surgeon','+972524376523','adnan@gmail.com',3,'Einshtein 40 Tel-Aviv Yaffo'),
('Tatiana','Bekker','Endocrinologist','+972537284754','tanusha@gmail.com',7,'Weizmann 14 Tel-Aviv Yaffo'),
('Yael','Ben-Sivan','Neurologist','+972528235267','ybens@gmail.com',7,'Weizmann 14 Tel-Aviv Yaffo'),
('Nir','Shvartz','Gastroenterolog','+972538569417','shnir@gmail.com',8,'Weizmann 14 Tel-Aviv Yaffo'),
('Daniel','Kiviti','Allergist','+9725263985361','kivdan@gmail.com',10,'Weizmann 14 Tel-Aviv Yaffo'),
('Asaf','Levi','Neurologist','+97252825439','alevi@gmail.com',11,'Weizmann 14 Tel-Aviv Yaffo'),
('Dror','Levit','Pediatric Oncologist','+972537242164','levdror@gmail.com',1,'Weizmann 6 Tel-Aviv Yaffo'),
('Miri','Tzaale','Dermatologist','+972526528569','tzaale@gmail.com',3,'Einshtein 40 Tel-Aviv Yaffo'),
('Dor','Grinberg','Surgeon','+972537264893','grindor@gmail.com',1,'Weizmann 14 Tel-Aviv Yaffo'),
('Muhhamad','Suad','Physioterapist','+972527462175','mahsu@gmail.com',11,'Weizmann 14 Tel-Aviv Yaffo');
GO

/* A reference table that contains the list of all medical procedures offered by the clinic
 and descriptive information about each procedure. */

CREATE TABLE ProcedureCatalog
(ProcedureID INT IDENTITY (1,1),
ProcedureName NVARCHAR(80) NOT NULL,
Category NVARCHAR(40) NOT NULL,
CONSTRAINT pro_proid_pk PRIMARY KEY (ProcedureID));
GO

INSERT INTO ProcedureCatalog (ProcedureName,Category)
VALUES 
('Basic Blood Count','Laboratory Procedures'),
('BRCA Blood Test','Laboratory Procedures'),
('PET-CT','MRI/CT'),
('MRI','MRI/CT'),
('A Day in an Oncology Hospital Unit','Clinical Procedures'),
('Chest X-ray','Clinical Procedures'),
('ECG (Electrocardiogram)','Clinical Procedures'),
('Tatiana Bekker','Medical Consultations'),
('Dror Levit','Medical Consultations'),
('Irina Letanski','Medical Consultations'),
('Miri Tzaale','Medical Consultations'),
('PTD Test','Clinical Procedures'),
('PET-CT PSMA','MRI/CT'),
('NGS Molecul Test','Laboratory Procedures'),
('Herniated Disc Surgery','Surgeries'),
('Intervertebral Disc MRI Review','Medical Reviews'),
('Medical Reviews','Medical Reviews'),
('Biopsy of a Lymph Node','Clinical Procedures'),
('Bilateral Breast Mastectomy','Surgeries'),
('IVF','Clinical Procedures'),
('Elbow Joint MRI','MRI/CT'),
('Vitamin B12 Blood Test','Laboratory Procedures'),
('Hospitalization in the Oncology Department (per 1 night)','Clinical Procedures'),
('Carotid Doppler Ultrasound','Dopplers/Ultasounds'),
('4Kscore Test','Laboratory Procedures'),
('Mammography Review','Medical Reviews'),
('Preparation of Histology Slides and Blocks','Laboratory Procedures'),
('Cardiac Pacemaker Programming','Clinical Procedures'),
('Gene Mutation Analysis(PIK3CA,NTRK)','Laboratory Procedures'),
('Leg Vein Doppler Ultrasound','Dopplers/Ultasounds'),
('MRI of the Foot','MRI/CT'),
('Lower Extremity CT Angiography','MRI/CT'),
('Bacterial Culture of Bone Tissue','Laboratory Procedures'),
('Surgical Excision of a Mole','Surgeries'),
('Immunophenotyping of Lymphocytes','Laboratory Procedures'),
('Hair Analysis for Heavy Metals','Laboratory Procedures'),
('Dor Grinberg','Medical Consultations'),
('Abdominal Ultrasound','Dopplers/Ultasounds');
GO

/* Stores historical pricing information for medical procedures.
Used to track price changes over time independently from visits. */

CREATE TABLE PriceList
(PriceID INT IDENTITY (1,1),
ProcedureID INT NOT NULL,
ClinicID INT NOT NULL,
DoctorID INT NULL,
PriceAmount DECIMAL (10,2) NOT NULL,
Currency CHAR(3) NOT NULL DEFAULT 'ILS',
CONSTRAINT pr_prid_pk PRIMARY KEY (PriceID),
CONSTRAINT pr_pr_ck CHECK (PriceAmount > 0),
CONSTRAINT pr_procedure_fk FOREIGN KEY (ProcedureID) REFERENCES ProcedureCatalog(ProcedureID),
CONSTRAINT pr_clinic_fk FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID),
CONSTRAINT pr_doctor_fk FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID));
GO

INSERT INTO PriceList(ProcedureID,ClinicID,DoctorID,PriceAmount,Currency)
VALUES (1,1,NULL,390,'USD'),
(2,1,NULL,1865,'USD'),
(3,2,NULL,1680,'USD'),
(4,2,NULL,1462,'USD'),
(5,1,NULL,1280,'USD'),
(6,1,NULL,596,'USD'),
(7,1,NULL,695,'USD'),
(8,7,7,895,'USD'),
(9,1,12,1300,'USD'),
(10,10,1,644,'USD'),
(11,10,13,694,'USD'),
(12,1,NULL,1970,'USD'),
(13,2,NULL,2045,'USD'),
(14,1,NULL,4800,'USD'),
(15,1,2,28750,'USD'),
(16,1,NULL,696,'USD'),
(17,3,NULL,796,'USD'),
(18,2,NULL,3550,'USD'),
(19,2,5,26352,'USD'),
(20,2,NULL,10457,'USD'),
(21,1,NULL,1587,'USD'),
(22,1,NULL,190,'USD'),
(23,1,NULL,2480,'USD'),
(24,11,8,690,'USD'),
(25,1,NULL,1785,'USD'),
(26,2,5,796,'USD'),
(27,1,NULL,180,'USD'),
(28,9,NULL,694,'USD'),
(29,1,NULL,3472,'USD'),
(30,11,NULL,596,'USD'),
(31,2,NULL,1587,'USD'),
(32,2,NULL,1964,'USD'),
(33,1,NULL,4900,'USD'),
(34,3,6,2500,'USD'),
(35,1,NULL,2430,'USD'),
(36,1,NULL,450,'USD'),
(37,10,14,796,'USD'),
(38,6,NULL,596,'USD');
GO

/* Represents a patient’s visit or appointment at the clinic.
Each visit links a patient, a clinic, a doctor, and the employee who created the appointment. */

CREATE TABLE Visits
(VisitID INT IDENTITY (1,1),
PatientID INT NOT NULL,
ClinicID INT NOT NULL,
DoctorID INT NULL,
CreatedByEmployee INT NOT NULL,
VisitDate DATE NOT NULL DEFAULT GETDATE(),
Notes NVARCHAR (200) NULL,
CONSTRAINT vis_visid_pk PRIMARY KEY (VisitID),
CONSTRAINT vis_pat_fk FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
CONSTRAINT vis_clinic_fk FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID),
CONSTRAINT vis_doctor_fk FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
CONSTRAINT vis_emp_fk FOREIGN KEY (CreatedByEmployee) REFERENCES Employees(EmployeeID));
GO

INSERT INTO Visits (PatientID, ClinicID, DoctorID, CreatedByEmployee, VisitDate, Notes)
VALUES (11,1,1,11,'02/15/2025','The first consultation'),
(8,1,NULL,10,'02/27/2025','The procedure'),
(19,2,4,12,'03/12/2025','The procedure'),
(27,10,14,10,'03/21/2025','The first consultation'),
(17,2,5,13,'03/21/2025','The surgery'),
(14,1,12,10,'04/09/2025','The third consultation'),
(33,10,15,11,'04/11/2025','The procedure'),
(9,1,1,12,'04/22/2025','Online consultation'),
(16,7,7,13,'04/29/2025','The second consultation'),
(31,2,NULL,13,'05/01/2025','The procedure'),
(37,8,9,12,'05/18/2025','The first consultation'),
(37,2,NULL,13,'05/19/2025','The procedure'),
(23,4,2,11,'05/27/2025','The surgery'),
(25,11,8,10,'06/11/2025',NULL),
(35,3,6,12,'06/20/2025','The surgery'),
(12,5,NULL,11,'06/30/2025','The procedure'),
(22,11,11,10,'07/04/2025','The second consultation'),
(19,2,4,12,'07/17/2025','The consultation after procedure'),
(34,1,14,11,'08/09/2025','The first consultation'),
(36,10,13,12,'08/11/2025','The first consultation'),
(17,9,NULL,13,'08/24/2025','The procedure'),
(8,1,NULL,10,'09/03/2025','The consultation after procedure'),
(21,10,3,12,'09/28/2025','The first consultation'),
(28,10,10,12,'10/06/2025','The first consultation'),
(34,1,14,11,'10/18/2025','The surgery'),
(35,10,9,13,'10/25/2025','The first consultation'),
(23,6,15,11,'11/13/2025','The physio'),
(40,1,1,7,'11/13/2025','Online consultation'),
(35,2,9,13,'11/26/2025','The procedure'),
(36,10,13,12,'12/16/2025','The second consultation'),
(39,10,2,10,'12/29/2025','The second consultation'),
(29,1,3,12,'12/29/2025','The first consultation');
GO

/* Stores detailed information about medical procedures performed during a specific visit.
It records the actual price charged to the patient at the time of the visit, including discounts. */

CREATE TABLE VisitProcedures
(VisitProcedureID INT IDENTITY (1,1),
VisitID INT NOT NULL,
ProcedureID INT NOT NULL,
Quanity INT NOT NULL DEFAULT 1,
PriceID INT NULL,
UnitPriceAtVisit DECIMAL (10,2) NOT NULL,
Discount DECIMAL (5,2) NOT NULL DEFAULT 0,
CONSTRAINT vispro_vispro_pk PRIMARY KEY (VisitProcedureID),
CONSTRAINT vispro_visid_fk FOREIGN KEY (VisitID) REFERENCES Visits(VisitID),
CONSTRAINT vispro_procat_fk FOREIGN KEY (ProcedureID) REFERENCES ProcedureCatalog(ProcedureID),
CONSTRAINT vispro_price_fk FOREIGN KEY (PriceID) REFERENCES PriceList(PriceID));
GO

INSERT INTO VisitProcedures (VisitID,ProcedureID,Quanity,PriceID,UnitPriceAtVisit,Discount)
VALUES (1,10,1,10,644,0),
(2,3,1,3,1648,0),
(3,38,1,38,596,0),
(4,37,1,37,796,0),
(5,19,1,19,23716.8,10),
(6,9,1,9,1300,0),
(7,30,2,30,596,0),
(8,10,1,10,644,0),
(9,8,1,8,895,0),
(10,32,1,32,1964,0),
(11,37,1,37,796,0),
(12,1,1,1,390,0),
(13,15,1,15,28750,0),
(14,7,1,7,695,0),
(15,34,1,34,2375,5),
(16,21,1,21,1587,0),
(17,37,1,NULL,500,0),
(18,10,1,10,644,0),
(19,37,1,37,796,0),
(20,11,1,11,694,0),
(21,16,1,16,696,0),
(22,10,1,10,644,0),
(23,5,1,5,1280,0),
(24,36,1,36,450,0),
(25,15,1,15,28750,0),
(26,14,1,14,4800,0),
(27,1,1,NULL,134,0),
(28,10,1,10,644,0),
(29,18,1,18,3550,0),
(30,11,1,11,694,0),
(31,16,1,16,696,0),
(32,5,1,5,1280,0);
GO