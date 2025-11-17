SELECT e.id, e.first_name, e.last_name
FROM Employee e
LEFT JOIN Team t ON e.team_id = t.id
WHERE e.team_id IS NULL;

SELECT e.id, e.first_name, e.last_name
FROM Employee e
LEFT JOIN Leave l ON e.id = l.emp_id
WHERE l.emp_id IS NULL;

SELECT l.id AS leave_id,
       e.id AS employee_id,
       l.start_date,
       l.end_date,
       e.first_name || ' ' || e.last_name AS employee_name,
       t.name AS team_name
FROM Leave l
JOIN Employee e ON l.emp_id = e.id
LEFT JOIN Team t ON e.team_id = t.id;


SELECT contract_type,
       COUNT(*) AS total_employees
FROM Employee
GROUP BY contract_type;


SELECT COUNT(*) AS employees_on_leave_today
FROM Leave l
WHERE CURRENT_DATE BETWEEN l.start_date AND l.end_date;


SELECT e.id,
       e.first_name,
       e.last_name,
       t.name AS team_name,
       CASE
           WHEN CURRENT_DATE BETWEEN l.start_date AND l.end_date
           THEN 'En congé'
           ELSE 'Présent'
       END AS status_today
FROM Employee e
LEFT JOIN Team t ON e.team_id = t.id
LEFT JOIN Leave l
    ON e.id = l.emp_id
    AND CURRENT_DATE BETWEEN l.start_date AND l.end_date;
