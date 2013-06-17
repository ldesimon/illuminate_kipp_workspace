SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 1800
SET VERIFY OFF
SPOOL 'psexports\programs.txt';
-- Write student enrollment column headers.
--
SELECT
		   '01 Student ID'
|| :TAB || '02 State Student ID'
|| :TAB || '03 Student Last Name'
|| :TAB || '04 Student First Name'
|| :TAB || '05 Student Middle Name'
|| :TAB || '06 Birth Date'
|| :TAB || '07 Program ID'
|| :TAB || '08 Eligibility Start Date'
|| :TAB || '09 Eligibility End Date'
|| :TAB || '10 Program Start Date'
|| :TAB || '11 Program End Date'
|| :TAB || '12 Academic Year'
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
  || :TAB || vir.USER_DEFINED_TEXT
  || :TAB || ''
  || :TAB || ''
  || :TAB || TO_CHAR( vir.USER_DEFINED_DATE, 'MM/dd/yyyy' )
  || :TAB || TO_CHAR( vir.USER_DEFINED_DATE2, 'MM/dd/yyyy' )
  || :TAB || '&IE_ACADEMIC_YEAR'
--BEGIN additional data columns
--Acceptable fields:
--Students table.  Table alias name is 's'.  Custom fields can be pulled using: ps_customfields.getStudentsCF(s.id, 'FIELDNAME')
--END additional data columns
FROM
  (SELECT * FROM ps.students ORDER BY last_name, first_name) s
  JOIN ps.virtualtablesdata2 vir ON vir.foreignKey = s.id
		WHERE
			vir.Related_To_Table = 'StudentProgram'
/
SPOOL OFF