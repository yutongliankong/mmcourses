<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Walkthrough 5-1</title>
</head>

<body>

<!--- walkthrough 5-1 starts here --->
<cfinvoke 
 component="mmcourses.acfd700.lab.components.specials"
 method="dailySpecials_Get"
 returnvariable="qSpecials">
	<cfinvokeargument name="datasource" value="acfd700-lab"/>
</cfinvoke>


<cfdump var="#qSpecials#">

</body>
</html>