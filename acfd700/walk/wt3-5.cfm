<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Advanced Query Handling: Walkthrough 5</title>
</head>

<body>

<cfhttp url="http://localhost:8500/mmcourses/acfd700/walksolution/datastructures/4/contacts.txt"
	name="qcontacts"
	delimiter=","
	firstrowasheaders="yes"></cfhttp>

<cfquery name="qsort" dbtype="query">
	select *
	from qcontacts
	order by lastname,firstname
</cfquery>


<table border="1">

<!--- wt 3-5: insert code here --->

</table>


</body>
</html>
