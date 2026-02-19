-- ===========================================
-- Project: Employee Salary Audit Automation
-- Technology: Oracle SQL / PL-SQL
-- Concepts Used: Tables, Procedure, Trigger
-- ===========================================

-- 1) Create Employee Table
CREATE TABLE emp_details (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER
);

-- 2) Create Salary Audit Table
CREATE TABLE salary_audit (
    emp_id NUMBER,
    old_salary NUMBER,
    new_salary NUMBER,
    updated_date DATE
);

-- 3) Insert Sample Data
INSERT INTO emp_details VALUES (101, 'Venkat', 45000);
INSERT INTO emp_details VALUES (102, 'Arjun', 50000);
INSERT INTO emp_details VALUES (103, 'Kiran', 30000);

COMMIT;

-- 4) Create Trigger for Salary Audit Logging
CREATE OR REPLACE TRIGGER trg_salary_audit
BEFORE UPDATE OF salary ON emp_details
FOR EACH ROW
BEGIN
    INSERT INTO salary_audit(emp_id, old_salary, new_salary, updated_date)
    VALUES (:OLD.emp_id, :OLD.salary, :NEW.salary, SYSDATE);
END;
/

-- 5) Create Procedure to Update Salary
CREATE OR REPLACE PROCEDURE update_salary (
    p_emp_id IN NUMBER,
    p_new_salary IN NUMBER
)
IS
BEGIN
    UPDATE emp_details
    SET salary = p_new_salary
    WHERE emp_id = p_emp_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Salary Updated Successfully');
END;
/

-- 6) Execute Procedure (Test)
BEGIN
    update_salary(101, 55000);
END;
/

-- 7) Verify Results
SELECT * FROM emp_details;
SELECT * FROM salary_audit;
