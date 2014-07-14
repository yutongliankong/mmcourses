
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


<!--- create entry for yourself --->


<!--- step 5: populate from query --->





<!--- end step 5 --->

<!--- output structure --->
<cfdump var="#stAdmins#" label="Populated from Query">

<!--- step 9: use structkeyexists --->






<!--- end step 9 --->

<!--- step 14: use structdelete() --->

<!--- end step 14 --->

<!--- output structure --->
<cfdump var="#stAdmins#" label="After structdelete()" >

</body>
</html>
