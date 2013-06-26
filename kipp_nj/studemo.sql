--prepped 6/26
--removed most fields for initial import

SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 1800
SET VERIFY OFF
SPOOL 'psexports\studemo.txt';
-- Write student demographic column headers.
--
SELECT
		   '01 Student ID'
|| :TAB || '02 State Student ID'
|| :TAB || '03 Student Last Name'
|| :TAB || '04 Student First Name'
|| :TAB || '05 Student Middle Name'
|| :TAB || '06 Birth Date'
|| :TAB || '07 Gender'
|| :TAB || '08 RACE Code ID 1'
|| :TAB || '09 RACE Code ID 2'
|| :TAB || '10 RACE Code ID 3'
|| :TAB || '11 Is Hispanic'
|| :TAB || '12 Primary Language Code ID'
|| :TAB || '13 Correspondence Language Code ID'
|| :TAB || '14 Language Fluency'
|| :TAB || '15 Reclassification Date'
|| :TAB || '16 Primary Disability Code ID'
|| :TAB || '17 Migrant Ed Student ID'
|| :TAB || '18 Lep Date'
|| :TAB || '19 US Entry Date'
|| :TAB || '20 Date Entered School'
|| :TAB || '21 Date Entered District'
|| :TAB || '22 Parent Guardian Highest Education Level'
|| :TAB || '23 Residential Status'
|| :TAB || '24 Special Needs Status'
|| :TAB || '25 SST Date'
|| :TAB || '26 504 Accommodations'
|| :TAB || '27 504 Review Date'
|| :TAB || '28 Special Ed Exit Date'
|| :TAB || '29 Birth City'
|| :TAB || '30 Birth State'
|| :TAB || '31 Birth Country'
|| :TAB || '32 Lunch ID'
|| :TAB || '33 AcademicYear'
|| :TAB || '34 Student Name Suffix'
|| :TAB || '35 Student Last Name Alias'
|| :TAB || '36 Student First Name Alias'
|| :TAB || '37 Student Middle Name Alias'
|| :TAB || '38 Student Name Suffix Alias'
|| :TAB || '39 Titile 1 Service Received'
|| :TAB || '40 Student Name Suffix Alias'
|| :TAB || '41 District ID'
|| :TAB || '42 Site ID'
|| :TAB || '43 Resident LEA Code'
|| :TAB || '44 Birth Date Verification Method'
|| :TAB || '45 Homeless Dwelling Type'
|| :TAB || '46 Photo Release'
|| :TAB || '47 Military Recruitment'
|| :TAB || '48 Internet Use Release'
|| :TAB || '49 Expected Graduation Date'
|| :TAB || '50 Graduation Completion Status'
|| :TAB || '51 Graduation Service Learning Hours'
|| :TAB || '52 US Citizen Born Abroad'
|| :TAB || '53 Military Family'
|| :TAB || '54 Home Address Verification Date'
|| :TAB || '55 Special Ed Enter Date'
|| :TAB || '56 Secondary Disability Code ID'
|| :TAB || '57 State School Entry Date'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write student demographic data.
--
SELECT
             s.Student_Number
  || :TAB || ''
  || :TAB || s.Last_Name
  || :TAB || s.First_Name
  || :TAB || ''
  || :TAB || TO_CHAR( s.DOB, 'MM/dd/yyyy' )
  || :TAB || s.GENDER
  || :TAB || (SELECT MIN(r.RACECD) FROM STUDENTRACE r WHERE s.ID = r.STUDENTID)
  || :TAB || ''
  || :TAB || ''
  || :TAB || CASE ps_customfields.getStudentsCF (s.id,'NULL') WHEN 'Y' THEN 1 ELSE 0 END
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || CASE ps_customfields.getStudentsCF (s.id,'NULL') WHEN 'EO' THEN 1 WHEN 'TBD' THEN 5 WHEN 'EL' THEN 3 WHEN 'IFEP' THEN 2 WHEN 'RFEP' THEN 4 END
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ''
  || :TAB || ''
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || TO_CHAR( s.SCHOOLENTRYDATE, 'MM/dd/yyyy' )
  || :TAB || TO_CHAR( s.DISTRICTENTRYDATE, 'MM/dd/yyyy' )
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ''
  || :TAB || '&IE_ACADEMIC_YEAR'
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ps_customfields.getStudentsCF (s.id,'NULL')
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || S.ID
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''

--BEGIN additional data columns
--Acceptable fields:
--Students table.  Table alias name is 's'.  Custom fields can be pulled using: ps_customfields.getStudentsCF(s.id, 'FIELDNAME')
--END additional data columns
FROM
  (SELECT * FROM ps.students ORDER BY last_name, first_name) s
  WHERE s.entrydate >= '&IE_FIRST_DAY'
/
SPOOL OFF