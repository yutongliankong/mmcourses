<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<!--- Create original query and dump it --->
<h1>Queries</h1>
<cfquery name="qContacts" datasource="acfd700-lab">
	SELECT	lastname,firstname
	FROM		contact
	ORDER BY	lastname,firstname
</cfquery>
<cfdump var="#qContacts#" label="Original">
<br>

<!--- STEP 3: Make new query, change one item, and dump both structures --->



<!---
<cfdump var="#qContacts#" label="Original">
<cfdump var="#qNew#" label="New">
--->

<br>
<br>
<br>
<!--- Create original array and dump it --->
<h1>Arrays</h1>
<cfset aComp=ArrayNew(1)>
<cfset aComp[1]="George Boole">
<cfset aComp[2]="Alan Turing">
<cfset aComp[3]="Benoit Mandelbrot">
<cfdump var="#aComp#" label="Original">
<br>
<br>
<!--- STEP 7: Make new array, change one item, and dump both structures --->


<!---
<cfdump var="#aComp#" label="Original">
<cfdump var="#aNew#" label="New">
--->
<br>
<br>
<br>
<!--- Create original structure and dump it --->
<h1>Structures</h1>
<cfset stComp=StructNew()>
<cfset stComp.id="101">
<cfset stComp.fname="Ada">
<cfset stComp.lname="Lovelace">
<cfset stComp.age="22">
<cfset stComp.vegetarian="No">
<cfdump var="#stComp#" label="Original">
<br>
<br>
<!--- STEP 11: Make new structure, change one item, and dump both structures --->


<!--- <cfdump var="#stComp#" label="Original">
<cfdump var="#stNew#" label="New">
 --->
 
 <!--- Restore original structure --->
<cfset stComp.fname = "Ada">

<br>
<br>
<h1>Duplicate()</h1>
<br>
<br>
<!--- STEP 15: Duplicate a structure, change one item, and dump both structures --->


<!--- <cfdump var="#stComp#" label="Original">
<cfdump var="#stDup#" label="Duplicated"> --->


</body>
</html>
