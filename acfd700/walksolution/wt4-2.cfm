
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
<cfset stAdmins = structnew()>

<!--- create entry for yourself --->
<cfset stAdmins["mboles"] = structnew()>
<cfset stAdmins["mboles"].firstname = "Matt">
<cfset stAdmins["mboles"].lastname = "Boles">
<cfset stAdmins["mboles"].contactid = "100">
<cfset stAdmins["mboles"].administratorRole = "Administrator">

<!--- step 5: populate from query --->
<cfloop query="qAdmins">
	<cfset stAdmins[qAdmins.username] = structnew()>
	<cfset stAdmins[qAdmins.username].firstname = qAdmins.firstname>
	<cfset stAdmins[qAdmins.username].lastname = qAdmins.lastname>
	<cfset stAdmins[qadmins.username].contactid = qAdmins.contactid>
	<cfset stAdmins[qadmins.username].administratorRole = qAdmins.administratorRole>
</cfloop>
<!--- end step 5 --->

<!--- output structure --->
<cfdump var="#stAdmins#" label="Populated from Query">

<!--- step 9: use structkeyexists --->
<cfif structkeyexists(stAdmins,"administrator")>
	Administrator account is still valid!
<cfelse>
	Administrator account is not valid!
</cfif>
<!--- end step 9 --->

<!--- step 14: use structdelete() --->
<cfset structDelete(stAdmins,"sdrucker")>
<!--- end step 14 --->

<!--- output structure --->
<cfdump var="#stAdmins#" label="After structdelete()" >

</body>
</html>
