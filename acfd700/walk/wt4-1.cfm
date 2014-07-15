<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Walkthrough 4-1</title>
</head>

<body> 

<cfquery name="qmenutype" datasource="acfd700-lab">
	select menutype
	from menutype
</cfquery>

<!--- step 2: Turn query into array --->
<cfset aMenuTypes = arrayNew(1)>


<!--- step 3: Loop over query --->
<cfloop query="qmenutype">
	<cfset aMenuTypes[qmenutype.currentrow] = qmenutype.menutype>
</cfloop>
<cfdump var="#aMenuTypes#" label="Population of array with cfloop">

<!--- step 8: Add to array through arrayappend() --->

<cfset arrayAppend(aMenuTypes, "Desert")>
<cfdump var="#aMenuTypes#">
<!--- step 12: Create variable to hold array length --->
<cfset alen = arrayLen(aMenuTypes)>

<!--- step 13: Loop through array and output --->
<cfoutput>
	<cfloop index="i" from="1" to="#alen#" >
		#i#: #aMenuTypes[i]#<br/>
	</cfloop>
</cfoutput>

<!--- step 17: sort array --->

<cfset arraySort(aMenuTypes,"textnocase", "desc")>
<cfdump var="#aMenuTypes#">


</body>
</html>
