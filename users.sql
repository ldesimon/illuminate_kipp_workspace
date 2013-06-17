SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 3000
SET VERIFY OFF
SPOOL 'psexports\users.txt';
-- Write teacher column headers.
--
SELECT DISTINCT
			 '01 User ID'
  || :TAB || '02 User Last Name'
  || :TAB || '03 User First Name'
  || :TAB || '04 User Middle Name'
  || :TAB || '05 Birth Date'
  || :TAB || '06 Gender'
  || :TAB || '07 Email Address'
  || :TAB || '08 Username'
  || :TAB || '09 Password'
  || :TAB || '10 State User or Employee ID'
  || :TAB || '11 Name suffix'
  || :TAB || '12 Former First Name'
  || :TAB || '13 Former Middle Name'
  || :TAB || '14 Former Last Name'
  || :TAB || '15 Primary Race'
  || :TAB || '16 User is Hispanic'
  || :TAB || '17 Address'
  || :TAB || '18 City'
  || :TAB || '19 State'
  || :TAB || '20 Zip'
  || :TAB || '21 Job Title'
  || :TAB || '22 Education Level'
  || :TAB || '23 Hire Date'
  || :TAB || '24 Exit Date'
  || :TAB || '25 Active'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write teacher data.
--
SELECT DISTINCT
			 t.ID
  || :TAB || t.Last_Name
  || :TAB || t.First_Name
  || :TAB || t.Middle_Name
  || :TAB || ps_customfields.getTeachersCF (t.id,'dob')
  || :TAB || upper(ps_customfields.getTeachersCF (t.id,'gender'))
  || :TAB || t.EMAIL_ADDR
  || :TAB || ''
  || :TAB || ''
  || :TAB || ps_customfields.getTeachersCF (t.id,'CA_SEID')
  || :TAB || ''
  || :TAB || ps_customfields.getTeachersCF (t.id,'CA_FormerFirstName')
  || :TAB || ps_customfields.getTeachersCF (t.id,'CA_FormerMiddleName')
  || :TAB || ps_customfields.getTeachersCF (t.id,'CA_FormerLastName')
  || :TAB || ''
  || :TAB || t.fedethnicity
  || :TAB || t.street
  || :TAB || t.city
  || :TAB || t.state
  || :TAB || t.zip
  || :TAB || ps_customfields.getTeachersCF (t.id,'CA_PositionStatus')
  || :TAB || ps_customfields.getTeachersCF (t.id,'CA_HighestDegree')
  || :TAB || ps_customfields.getTeachersCF (t.id,'CA_DateofHire')
  || :TAB || ''
  || :TAB || ''
--BEGIN additional data columns
--Acceptable fields:
--Teachers table(t). Custom teacher fields:  ps_customfields.getTeachersCF(t.id, 'FIELDNAME')
--END additional data columns
FROM
 (SELECT * FROM ps.teachers ORDER BY last_name, first_name) t
JOIN ps.cc ON t.id = cc.teacherid
/
SPOOL OFF