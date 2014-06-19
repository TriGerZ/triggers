-- For each insert in ENROLLMENT
-- Check columns with a NOT NULL constraints must be correctly filled
CREATE OR REPLACE TRIGGER enrollment_bi
BEFORE INSERT ON enrollment
FOR EACH ROW

BEGIN

	-- Check integrity
	IF :NEW.student_id IS NULL THEN
		RAISE_APPLICATION_ERROR(-20000, 'student_id IS NULL');
	END IF;
	SELECT student_id INTO v_student_id FROM student WHERE student_id = :NEW.student_id;
	IF :NEW.section_id IS NULL THEN
		RAISE_APPLICATION_ERROR(-20001, 'section_id IS NULL');
	END IF;
	IF :NEW.enroll_date IS NULL THEN
		RAISE_APPLICATION_ERROR(-20002, 'enroll_date IS NULL');
	END IF;

	-- Insert audit data
	:NEW.CREATED_BY := USER;
	:NEW.CREATED_DATE := SYSDATE;
	:NEW.MODIFIED_BY := USER;
	:NEW.MODIFIED_DATE := SYSDATE;

END;