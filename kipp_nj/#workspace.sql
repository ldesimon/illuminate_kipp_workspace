select * from teachers
;
--users

SELECT DISTINCT
 t.ID
,t.Last_Name
,t.First_Name
,NULL
,NULL
,NULL
,t.EMAIL_ADDR
,t.teacherloginid
,t.teacherloginpw
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL

--BEGIN additional data columns
--Acceptable fields:
--Teachers table(t). Custom teacher fields:  ps_customfields.getTeachersCF(t.id, 'FIELDNAME')
--END additional data columns
FROM
 (SELECT * FROM ps.teachers ORDER BY last_name, first_name) t
JOIN ps.CC ON t.id = CC.teacherID
WHERE t.status = 1 --active teachers only


;
SELECT
 s.Student_Number
,NULL
,s.Last_Name
,s.First_Name
,NULL
,TO_CHAR( s.DOB, 'MM/dd/yyyy' )
,vir.USER_DEFINED_TEXT
,NULL
,NULL
,TO_CHAR( vir.USER_DEFINED_DATE, 'MM/dd/yyyy' )
,TO_CHAR( vir.USER_DEFINED_DATE2, 'MM/dd/yyyy' )
--,'&IE_ACADEMIC_YEAR'

--BEGIN additional data columns
--Acceptable fields:
--Students table.  Table alias name is 's'.  Custom fields can be pulled using: ps_customfields.getStudentsCF(s.id, 'FIELDNAME')
--END additional data columns
FROM
  (SELECT * FROM ps.students ORDER BY last_name, first_name) s
  JOIN ps.virtualtablesdata2 vir ON vir.foreignKey = s.id
		WHERE
			vir.Related_To_Table = 'StudentProgram'


;

select distinct

 s.id
,s.SCHOOLID
,CASE WHEN t.ABBREVIATION LIKE '%-%' THEN 'Y' ELSE t.ABBREVIATION END
,s.COURSE_NUMBER
,s.TEACHER
,s.section_number
,TO_CHAR(t.yearid + 1990)||'-'||TO_CHAR(t.yearid + 1991)
,s.room
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL

--BEGIN additional data columns
--Acceptable fields:
--Terms table(t).  Custom section fields:  ps_customfields.getTermsCF(c.id, 'FIELDNAME')
--Section table(s).  Custom section fields:  ps_customfields.getSectionsCF(c.id, 'FIELDNAME')
--END additional data columns
FROM (SELECT * FROM ps.terms) t
INNER JOIN sections s ON (t.ID = s.TERMID and t.schoolid = s.schoolid)
WHERE t.yearid = 22

;

--contacts_mother

select
 s.Student_Number
,NULL   
,s.Last_Name
,s.First_Name
,NULL
,TO_CHAR( s.DOB, 'MM/dd/yyyy' )
,SUBSTR (s.mother, 1, INSTR(s.mother,' ', 1, 1) -1)
,SUBSTR (s.mother, (INSTR(s.mother,' ', 1)+1))
,s.Street
,s.Street
,s.City
,s.State
,s.Zip
, ps_customfields.getStudentsCF (s.id,'mother_cell')
,'M'
, ps_customfields.getStudentsCF (s.id,'mother_home_phone')
,'H'
,1
,1
,'Mother'
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL


FROM
  (SELECT * FROM ps.students ORDER BY last_name, first_name) s
  WHERE s.entrydate >= '01-JUL-12'




;


--enrollment


select
 s.Student_Number
,ps_customfields.getStudentsCF(s.id, 'SID')
,s.Last_Name
,s.First_Name
,NULL
,TO_CHAR( s.DOB, 'MM/dd/yyyy' )
,e.SCHOOLID
,TO_CHAR( e.ENTRYDATE, 'MM/dd/yyyy' )
,TO_CHAR( e.EXITDATE, 'MM/dd/yyyy' )
,CASE e.GRADE_LEVEL WHEN -2 THEN 15 WHEN -1 THEN 15 WHEN 0 THEN 1 WHEN 1 THEN 2 WHEN 2 THEN 3 WHEN 3 THEN 4 WHEN 4 THEN 5 WHEN 5 THEN 6 WHEN 6 THEN 7 WHEN 7 THEN 8 WHEN 8 THEN 9 WHEN 9 THEN 10 WHEN 10 THEN 11 WHEN 11 THEN 12 WHEN 12 THEN 13 WHEN 99 THEN 14 END
,TO_CHAR(e.yearid + 1990)||'-'||TO_CHAR(e.yearid + 1991)
,NULL
,NULL
,e.exitcode
,NULL

FROM
(SELECT * FROM ps.students ORDER BY lastfirst) s
  JOIN ps.ps_enrollment_all e ON e.studentid = s.id
  WHERE e.yearid = 22
  
