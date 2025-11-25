-- Library Fine Processing System
SET SERVEROUTPUT ON;

DECLARE
    -- 1. Define a RECORD type
    TYPE fine_record IS RECORD (
        member_id   NUMBER,
        book_id     NUMBER,
        overdue_days NUMBER,
        fine_amount NUMBER
    );

    -- 2. Define a COLLECTION (Nested Table of records)
    TYPE fine_table IS TABLE OF fine_record;

    -- 3. Create a collection variable
    fines fine_table := fine_table();

    -- Temporary record for building data
    temp_rec fine_record;

    -- Fine rate per day
    fine_rate CONSTANT NUMBER := 100;

BEGIN
    ------------------------------------------------------
    -- Load records
    ------------------------------------------------------
    temp_rec.member_id := 1;
    temp_rec.book_id := 101;
    temp_rec.overdue_days := 5;
    fines.EXTEND;
    fines(1) := temp_rec;

    temp_rec.member_id := 2;
    temp_rec.book_id := 205;
    temp_rec.overdue_days := -3;  -- Invalid data → will be skipped
    fines.EXTEND;
    fines(2) := temp_rec;

    temp_rec.member_id := 3;
    temp_rec.book_id := 310;
    temp_rec.overdue_days := 2;
    fines.EXTEND;
    fines(3) := temp_rec;

    ------------------------------------------------------
    -- Process fines
    ------------------------------------------------------
    FOR i IN 1 .. fines.COUNT LOOP
        
        IF fines(i).overdue_days < 0 THEN
            GOTO skip_invalid;
        END IF;

        fines(i).fine_amount := fines(i).overdue_days * fine_rate;
        
        DBMS_OUTPUT.PUT_LINE(
            'Member ' || fines(i).member_id ||
            ' - Book ' || fines(i).book_id ||
            ' - Fine: ' || fines(i).fine_amount || ' RWF'
        );

        CONTINUE;

        <<skip_invalid>>
        DBMS_OUTPUT.PUT_LINE(
            'Skipping invalid record at index ' || i
        );

    END LOOP;

END;
/
