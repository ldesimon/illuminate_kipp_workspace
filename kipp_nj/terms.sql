--prepped 6/26
--no edits
--need to look into PS term id vs illuminate term id

SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 300
SPOOL 'psexports\terms.txt';
-- Write course column headers.
--
SELECT  DISTINCT
			'01 SiteID'
 || :TAB || '02 Term Name'
 || :TAB || '03 Term Number'
 || :TAB || '04 Term Start'
 || :TAB || '05 Term End'
 || :TAB || '06 Term Type'
 || :TAB || '07 Term Session'
 || :TAB || '08 Academic Year'
 || :TAB || '09 Unique Term ID'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write course data.
--
SELECT DISTINCT
			CASE WHEN t.SCHOOLID=0 THEN 9999999 ELSE t.SCHOOLID END
 || :TAB || CASE WHEN t.ABBREVIATION LIKE '%-%' THEN 'Y' ELSE t.ABBREVIATION END
 || :TAB || CASE WHEN t.ID LIKE '%0' THEN 1 WHEN t.ID LIKE '%1' THEN 1 WHEN t.ID LIKE '%2' THEN 2 WHEN t.ID LIKE '%3' THEN 3 WHEN t.ID LIKE '%4' THEN 4 WHEN t.ID LIKE '%5' THEN 5 WHEN t.ID LIKE '%6' THEN 6 WHEN t.ID LIKE '%7' THEN 7 WHEN t.ID LIKE '%8' THEN 8 WHEN t.ID LIKE '%9' THEN 9 ELSE t.ID END
 || :TAB || TO_CHAR( t.FIRSTDAY, 'MM/dd/yyyy' )
 || :TAB || TO_CHAR( t.LASTDAY, 'MM/dd/yyyy' )
 || :TAB || t.PORTION
 || :TAB || 1
 || :TAB || TO_CHAR(t.yearid + 1990)||'-'||TO_CHAR(t.yearid + 1991)
 || :TAB || t.DCID
--BEGIN additional data columns
--Acceptable fields:
--Terms table(t).  Custom terms fields:  ps_customfields.getTermsCF(c.id, 'FIELDNAME')
--END additional data columns
FROM (SELECT * FROM ps.terms ORDER BY SCHOOLID, ABBREVIATION) t
WHERE t.YEARID = &IE_YEAR_ID
/
SPOOL OFF
