--prepped 6/26
--no edits to stored grades fields

SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 3000
SPOOL 'psexports\transcripts.txt';
-- Write course column headers.
--
SELECT  DISTINCT
		   '01 Student ID'
|| :TAB || '02 State Student ID'
|| :TAB || '03 Student Last Name'
|| :TAB || '04 Student First Name'
|| :TAB || '05 Student Middle Name'
|| :TAB || '06 Date of Birth'
|| :TAB || '07 Course ID'
|| :TAB || '08 Course Short Name'
|| :TAB || '09 Academic Year'
|| :TAB || '10 Site ID'
|| :TAB || '11 Site Name'
|| :TAB || '12 Term Name'
|| :TAB || '13 Student Grade Level ID'
|| :TAB || '14 Final Mark'
|| :TAB || '15 Units Attempted'
|| :TAB || '16 Units Earned'
|| :TAB || '17 Work Habits'
|| :TAB || '18 Citizenship'
|| :TAB || '19 Session Type'
|| :TAB || '20 Unique Term ID'
|| :TAB || '21 Quarter Number'
|| :TAB || '22 Units Repeat Grade'
|| :TAB || '23 Transfer District Name'
|| :TAB || '24 Transfer Site Name'
|| :TAB || '25 Transfer Course ID'
|| :TAB || '26 Transfer Course Name'
|| :TAB || '27 Unique Term ID'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write course data.
--
SELECT DISTINCT
             s.Student_Number
  || :TAB || ''
  || :TAB || s.Last_Name
  || :TAB || s.First_Name
  || :TAB || ''
  || :TAB || TO_CHAR( s.DOB, 'MM/dd/yyyy' )
  || :TAB || trn.course_number
  || :TAB || trn.course_name
  || :TAB || trn.course_name
  || :TAB || TO_CHAR(trm.yearid + 1990)||'-'||TO_CHAR(trm.yearid + 1991)
  || :TAB || trn.schoolid
  || :TAB || trn.schoolname
  || :TAB || trn.storecode
  || :TAB || CASE trn.grade_level WHEN -2 THEN 15 WHEN -1 THEN 15 WHEN 0 THEN 1 WHEN 1 THEN 2 WHEN 2 THEN 3 WHEN 3 THEN 4 WHEN 4 THEN 5 WHEN 5 THEN 6 WHEN 6 THEN 7 WHEN 7 THEN 8 WHEN 8 THEN 9 WHEN 9 THEN 10 WHEN 10 THEN 11 WHEN 11 THEN 12 WHEN 12 THEN 13 WHEN 99 THEN 14 END
  || :TAB || trn.grade
  || :TAB || trn.PotentialCrHrs
  || :TAB || trn.EarnedCrHrs
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || trn.storecode
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
--BEGIN additional data columns
--Acceptable fields:
--Terms table(t).  Custom section fields:  ps_customfields.getTermsCF(c.id, 'FIELDNAME')
--Section table(s).  Custom section fields:  ps_customfields.getSectionsCF(c.id, 'FIELDNAME')
--END additional data columns
FROM
(SELECT * FROM ps.students ORDER BY last_name, first_name) s
  JOIN ps.storedgrades trn ON trn.studentid = s.id
  JOIN ps.terms trm ON trm.id = trn.termid
/
SPOOL OFF