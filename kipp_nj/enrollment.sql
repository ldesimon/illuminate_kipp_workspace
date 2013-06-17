SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 1800
SET VERIFY OFF
SPOOL 'psexports\enrollment.txt';
-- Write student enrollment column headers.
--
SELECT
		     '01 Student ID'
  || :TAB || '02 State Student ID'
  || :TAB || '03 Student Last Name'
  || :TAB || '04 Student First Name'
  || :TAB || '05 Middle Name'
  || :TAB || '06 Birth Date'
  || :TAB || '07 Site ID'
  || :TAB || '08 Enrollment Start'
  || :TAB || '09 Enrollment End'
  || :TAB || '10 Student Grade Level ID'
  || :TAB || '11 Academic Year'
  || :TAB || '12 Is Primary ADA'
  || :TAB || '13 Attendance Category'
  || :TAB || '14 Enrollment Exit Code'
  || :TAB || '15 Session Type'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write student enrollment data.
--
SELECT
             s.Student_Number
  || :TAB || s.STATE_STUDENTNUMBER
  || :TAB || s.Last_Name
  || :TAB || s.First_Name
  || :TAB || s.Middle_Name
  || :TAB || TO_CHAR( s.DOB, 'MM/dd/yyyy' )
  || :TAB || e.SCHOOLID
  || :TAB || TO_CHAR( e.ENTRYDATE, 'MM/dd/yyyy' )
  || :TAB || TO_CHAR( e.EXITDATE, 'MM/dd/yyyy' )
  || :TAB || CASE e.GRADE_LEVEL WHEN -2 THEN 15 WHEN -1 THEN 15 WHEN 0 THEN 1 WHEN 1 THEN 2 WHEN 2 THEN 3 WHEN 3 THEN 4 WHEN 4 THEN 5 WHEN 5 THEN 6 WHEN 6 THEN 7 WHEN 7 THEN 8 WHEN 8 THEN 9 WHEN 9 THEN 10 WHEN 10 THEN 11 WHEN 11 THEN 12 WHEN 12 THEN 13 WHEN 99 THEN 14 END
  || :TAB || TO_CHAR(e.yearid + 1990)||'-'||TO_CHAR(e.yearid + 1991)
  || :TAB || ''
  || :TAB || ''
  || :TAB || e.exitcode
  || :TAB || ''
--BEGIN additional data columns
--Acceptable fields:
--Students table.  Table alias name is 's'.  Custom fields can be pulled using: ps_customfields.getStudentsCF(s.id, 'FIELDNAME')
--END additional data columns
FROM
(SELECT * FROM ps.students ORDER BY lastfirst) s
  JOIN ps.ps_enrollment_all e ON e.studentid = s.id
WHERE e.yearid = &IE_YEAR_ID
/
SPOOL OFF