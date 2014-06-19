CREATE OR REPLACE TRIGGER section_bu
BEFORE UPDATE ON section
FOR EACH ROW
BEGIN
	IF :NEW.section_id IS NULL OR :NEW.course_no IS NULL 
	OR :NEW.section_no IS NULL OR :NEW.instructor_id IS NULL THEN
		RAISE_APPLICATION_ERROR(-20000, 'NOT NULL constraint violated');
	END IF;
	EXCEPTION
  	WHEN DUP_VAL_ON_INDEX THEN
	    -- log values here
	    DBMS_OUTPUT.PUT_LINE('Duplicate value on an index');
	    DBMS_OUTPUT.PUT_LINE('Duplicate value: '||:NEW.section_id);
END;