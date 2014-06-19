CREATE OR REPLACE TRIGGER section_aiou
AFTER INSERT OR UPDATE ON section
DECLARE
	course_number NUMBER;
BEGIN
	-- the instructor must have at most 9 courses
	SELECT count(instructor_id) INTO course_number FROM section WHERE instructor_id = :NEW.instructor_id;
	IF course_number >= 10 THEN
		RAISE_APPLICATION_ERROR(-20000, 'too many courses given to the instructor: '||:NEW.instructor_id);
	END IF;
END;