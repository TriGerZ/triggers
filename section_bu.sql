CREATE OR REPLACE TRIGGER section_bu
BEFORE UPDATE ON section
FOR EACH ROW
BEGIN
	IF :NEW.section_id IS NULL THEN
		RAISE_APPLICATION_ERROR(-20000, 'section_id must be NOT NULL');
	END IF;
	IF :NEW.course_no IS NULL THEN
		RAISE_APPLICATION_ERROR(-20001, 'course_no must be NOT NULL');
	END IF;
	IF :NEW.section_no IS NULL THEN
		RAISE_APPLICATION_ERROR(-20002, 'section_no must be NOT NULL');
	END IF;
	IF :NEW.instructor_id IS NULL THEN
		RAISE_APPLICATION_ERROR(-20002, 'instructor_id must be NOT NULL');
	END IF;
	EXCEPTION
  	WHEN DUP_VAL_ON_INDEX THEN
	    -- log values here
	    DBMS_OUTPUT.PUT_LINE('Duplicate value on an index');
	    DBMS_OUTPUT.PUT_LINE('Duplicate value: '||:NEW.section_id);
END;