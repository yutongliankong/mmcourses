<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Walkthrough 4-4: Complex Data Structures</title>
</head>

<body>

<cfquery name="qdata" datasource="acfd700-lab">
	select dishid,dishname,dishdescription
	from dish
	order by dishname
</cfquery>

<!--- step 2 --->
<cfset aresult = arraynew(1)>

<!--- step 3 --->
<cfset rc = qdata.recordcount>

<!--- step 4 --->
<cfset lcolumns = qdata.columnlist>

<!--- step 5 (outer loop) --->
<cfloop from="1" to="#rc#" index="i">
	<cfset stData = structnew()>			
	<!--- step 7 (inner loop) --->
	<cfloop list="#variables.lcolumns#" index="thiscolumn">
		<cfset stData[variables.thiscolumn] = qdata[variables.thiscolumn][i]>
	</cfloop>
			<!--- step 9 : arrayappend --->
	<cfset arrayAppend(aresult,stData)>		
</cfloop>

<cfdump var="#aresult#">

</body>
</html>
