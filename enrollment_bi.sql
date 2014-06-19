-- For each insert in ENROLLMENT
-- Check columns with a NOT NULL constraints must be correctly filled
CREATE OR REPLACE TRIGGER enrollment_bi
BEFORE INSERT ON enrollment
FOR EACH ROW

v_student_id ENROLLMENT.STUDENT_ID%TYPE;
v_section_id ENROLLMENT.STUDENT_ID%TYPE;

BEGIN

	-- Check integrity
	IF :NEW.student_id IS NULL OR :NEW.section_id IS NULL 
	OR :NEW.enroll_date IS NULL THEN
		RAISE_APPLICATION_ERROR(-20000, 'NOT NULL constraint violated');
	END IF;
	
	SELECT COUNT student_id INTO v_student_id FROM STUDENT WHERE student_id = :NEW.student_id;
	SELECT COUNT section_id INTO v_section_id FROM SECTION WHERE section_id = :NEW.section_id;

	IF v_student_id = 0 OR v_section_id = 0 THEN
		RAISE_APPLICATION_ERROR(-20001, 'FK undefined');
	END IF;

	-- Insert audit data
	:NEW.CREATED_BY := USER;
	:NEW.CREATED_DATE := SYSDATE;
	:NEW.MODIFIED_BY := USER;
	:NEW.MODIFIED_DATE := SYSDATE;

END;