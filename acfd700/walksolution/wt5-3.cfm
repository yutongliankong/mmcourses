

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Walkthrough 5-3</title>
</head>

<body>

<!--- start walkthrough here --->

<cfobject component="mmcourses.acfd700.lab.components.specials"
	name="cfcSpecials">

<cfset cfcSpecials = cfcSpecials.init(dsn="acfd700-lab")>

<cfdump var="#cfcSpecials.dailySpecials_get()#">
	

</body>
</html>