DROP TABLE IF EXISTS InternalStudents;

CREATE TABLE InternalStudents (
internalStudentId INT NOT NULL AUTO_INCREMENT,
departmentId INT NOT NULL,
studentId INT NOT NULL,
year INT NOT NULL,
numberOfMonths INT,
PRIMARY KEY (internalStudentId),
FOREIGN KEY (departmentId) REFERENCES Departments (departmentId),
FOREIGN KEY (studentId) REFERENCES Students (studentId),
UNIQUE (studentId, YEAR),
CONSTRAINT invalidNumberOfMonths CHECK (numberOfMonths >= 3 AND numberOfMonths <= 9)
);


DELIMITER //
CREATE OR REPLACE PROCEDURE 
	pInsertInterns()
BEGIN
	INSERT INTO InternalStudents (studentId, departmentId, year, numberOfMonths) VALUES
		(1, 1, 2019, 3),
		(1, 1, 2020, 6),
		(2, 1, 2019, null);
END //
DELIMITER ;

CALL pInsertInterns();


DELIMITER //
CREATE OR REPLACE TRIGGER tCorrectDuration
	BEFORE UPDATE ON internalstudents
	FOR EACH ROW
	BEGIN
		DECLARE internalstudent ROW TYPE OF internalstudents;
		IF (NEW.numberOfMonths > 9) THEN
			SET NEW.numberOfMonths = 8;
			-- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA DURACIÓN NO PUEDE SER MÁS DE 9 MESES';
		END IF;
	END//
DELIMITER ;


DELIMITER //
CREATE OR REPLACE PROCEDURE 
	pUpdateInterns(s INT, d INT)
BEGIN
	UPDATE internalstudents
	SET numberOfMonths = d WHERE studentId = s;
END //
DELIMITER ;

CALL pUpdateInterns(1, 13);


DELIMITER //
CREATE OR REPLACE PROCEDURE 
	pDeleteInterns(s INT)
BEGIN
	DELETE FROM internalstudents WHERE studentId = s;
END //
DELIMITER ;

CALL pDeleteInterns(2);	







CREATE OR REPLACE VIEW Ejercicio6 AS

SELECT professors.firstName professorName, groups.name groupName, teachingloads.credits FROM professors NATURAL JOIN groups NATURAL JOIN teachingloads;


CREATE OR REPLACE VIEW Ejercicio6_ AS

SELECT professors.firstName professorName, groups.name groupName, teachingloads.credits
	FROM professors
	JOIN teachingloads ON (teachingloads.professorId = professors.professorId)
	JOIN groups ON (groups.groupId = teachingloads.groupId);
	
	
	
CREATE OR REPLACE VIEW Ejercicio7 AS

SELECT AVG(value) notaMediaGrupo2 FROM grades WHERE groupId = 2;



CREATE OR REPLACE VIEW Ejercicio8 AS

SELECT studentId, MAX(value) maxGrade FROM grades GROUP BY studentId ORDER BY maxGrade DESC;



CREATE OR REPLACE VIEW Ejercicio9 AS

SELECT professors.firstName, professors.surname, COUNT(teachingloads.professorId) numberOfGroups 
	FROM professors NATURAL JOIN teachingloads 
	GROUP BY professors.professorId
	ORDER BY numberOfGroups DESC;
	
	
CREATE OR REPLACE VIEW Ejercicio9_ AS

SELECT professors.firstName, professors.surname, COUNT(teachingloads.professorId) numberOfGroups 
	FROM professors 
		JOIN teachingloads ON (professors.professorId = teachingloads.professorId)
	GROUP BY professors.professorId
	ORDER BY numberOfGroups DESC;






SELECT * FROM Ejercicio9_;


















ORDER BY studentId DESC
LIMIT 5
OFFSET 5
COUNT()
AVG()
MAX()
MIN()
SUM()
GROUP BY 

DELIMITER //
CREATE OR REPLACE PROCEDURE procedimiento(s INT)
	BEGIN
		DECLARE id INT;
		SET id = ...;
		DELETE FROM
		UPDATE internalstudents SET 
		INSERT INTO internalstudents VALUES (	)
	END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE FUNCTION funcion(s INT) RETURNS DOUBLE
	BEGIN
		DECLARE avgStudentGrade DOUBLE;
		SET avgStudentGrade = (SELECT AVG(VALUE) FROM grades WHERE grades.studentId = s);
		RETURN avgStudentGrade;
	END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE TRIGGER tCorrectDuration
	BEFORE UPDATE ON internalstudents
	FOR EACH ROW
	BEGIN
		DECLARE internalstudent ROW TYPE OF internalstudents;
		IF (NEW.numberOfMonths > 9) THEN
			SET NEW.numberOfMonths = 8;
			-- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA DURACIÓN NO PUEDE SER MÁS DE 9 MESES';
		END IF;
	END//
DELIMITER ;
