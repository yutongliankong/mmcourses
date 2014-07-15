
<cfquery name="qAdmins" datasource="acfd700-lab">
	select contact.contactid, contact.firstname, contact.lastname, administrator.username, administrator.administratorrole
	from Contact,Administrator
	where Contact.contactid = Administrator.contactid
	order by contact.contactid
</cfquery>


<!--- Walkthrough 4-2 starts here --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Walkthrough 4-2</title>
</head>

<body>

<cfdump var="#qadmins#" label="Original Query Data">

<!--- step 2: create new structure --->
<cfset stAdmins = structNew()>

<!--- create entry for yourself --->
<cfset stAdmins["zRonghuan"] = structNew()>
<cfset stAdmins["zRonghuan"].firstName = "Rpnghuan">
<cfset stAdmins["zRonghuan"].lastname = "Zhao">
<cfset stAdmins["zRonghuan"].contactid = "100">
<cfset stAdmins["zRonghuan"].administratorRole = "Administrator">

<!--- step 5: populate from query --->
<cfloop query="qAdmins">
	<cfset stAdmins[qAdmins.username] = structNew()>
	<cfset stAdmins[qAdmins.username].firstname = qAdmins.firstname>
	<cfset stAdmins[qAdmins.username].lastname = qAdmins.lastname>
	<cfset stAdmins[qAdmins.username].contactid = qAdmins.contactid>
	<cfset stAdmins[qAdmins.username].administratorRole = qAdmins.administratorRole>
</cfloop>




<!--- end step 5 --->

<!--- output structure --->
<cfdump var="#stAdmins#" label="Populated from Query">

<!--- step 9: use structkeyexists --->
<cfif structKeyExists(stAdmins, "Administrator")>
	<cfoutput>Administrator account is valid</cfoutput>
<cfelse>
	<cfoutput>Administrator account is not valid</cfoutput>
</cfif>





<!--- end step 9 --->

<!--- step 14: use structdelete() --->
<cfset structDelete(stAdmins, "Administrator")>
<!--- end step 14 --->

<!--- output structure --->
<cfdump var="#stAdmins#" label="After structdelete()" >

</body>
</html>
