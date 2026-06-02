USE hr ;

-- overall attrition rate
SELECT ROUND(
			SUM(CASE 
					WHEN Attrition='Yes'
                    THEN 1
                    ELSE 0
				END) * 100 / COUNT(*),2) AS attrition_rate
FROM hr_data ;



-- department wise attrition percentage
SELECT Department,
COUNT(*) AS total_employees,
ROUND(SUM(CASE
		WHEN Attrition='Yes'
		THEN 1
		ELSE 0
	END) * 100 / COUNT(*),2) AS attrition_percentage
FROM hr_data
GROUP BY Department
ORDER BY attrition_percentage DESC;



-- top 5 job roles with highest attrition
SELECT JobRole,
COUNT(*) AS attrition_count
FROM hr_data
GROUP BY JobRole
ORDER BY attrition_count DESC
LIMIT 5 ;


-- gender-wise attrition analysis
SELECT Gender,
COUNT(*) AS employees,
ROUND(
	SUM(
		CASE 
			WHEN Attrition='Yes'
            THEN 1
            ELSE 0
		END) * 100 / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY Gender;



-- attrition by age group 
SELECT 
CASE
	WHEN Age < 25 THEN 'under 25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
END AS age_group,
COUNT(*) AS employees
FROM hr_data
GROUP BY age_group
ORDER BY age_group ;
    
    

-- department-wise average salary ranking
SELECT 
Department,
ROUND(AVG(MonthlyIncome),2) AS avg_salary,
RANK() OVER(
ORDER BY AVG(MonthlyIncome) DESC) AS salary_rank
FROM hr_data
GROUP BY Department ;



-- top 10 highest salaries
SELECT Department,
EmployeeNumber,
JobRole,
MonthlyIncome,
DENSE_RANK() OVER(
ORDER BY MonthlyIncome DESC) AS salary_rank
FROM hr_data
ORDER BY MonthlyIncome DESC
LIMIT 10;


-- salary quartile
SELECT  EmployeeNumber, MonthlyIncome,
NTILE(4) OVER(
ORDER BY MonthlyIncome) AS salary_quartile
FROM hr_data ;



-- running average
SELECT EmployeeNumber, MonthlyIncome,
ROUND(
		AVG(MonthlyIncome)
		OVER(
			ORDER BY EmployeeNumber),2)
            AS running_avg_salary
FROM hr_data ;



-- employees earning above department average
SELECT * 
FROM hr_data h
WHERE MonthlyIncome > (
						SELECT AVG(MonthlyIncome)
                        FROM hr_data
                        WHERE Department = H.Department
                        );


                        
-- employees at risk of leaving
SELECT Department,
EmployeeNumber,
JobRole,
JobSatisfaction,
MonthlyIncome,
OverTime,
WorkLifeBalance
FROM hr_data
WHERE OverTime = 'Yes' 
AND JobSatisfaction <= 2
AND WorkLifeBalance <= 2 ;


-- avg experience by job role
SELECT JobRole,
ROUND(
		AVG(TotalWorkingYears),2) AS avg_exp
FROM hr_data
GROUP BY JobRole
ORDER BY avg_exp DESC;



-- promotion delay 
SELECT JobRole,
ROUND(
		AVG(YearsSinceLastPromotion),2) AS avg_promo_gap
FROM hr_data
GROUP BY JobRole
ORDER BY avg_promo_gap DESC;
