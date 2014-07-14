
<cfquery name="qdata" datasource="acfd700-lab">
	select *
	from menutype
</cfquery>

<!--- lab 4 starts here --->
<cfset lcolumns = qdata.columnlist>

<cfset aResult = arraynew(1)>
<cfset thiscolumn = "">

<cfloop query="qdata">
	<cfset stRecord = structnew()>
	<cfloop list="#variables.lcolumns#" index="thiscolumn">
		<cfset stRecord[thiscolumn] = qdata[thiscolumn][qdata.currentrow]>
	</cfloop>
	<cfset arrayAppend(aResult,stRecord)>
</cfloop>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Lab 4</title>
</head>

<body>


<cfdump var="#aresult#">


</body>
</html>
