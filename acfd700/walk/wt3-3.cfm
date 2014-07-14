<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Advanced Query Handling: Walkthrough 3</title>
</head>

<body>

<cfset contactid = 1>
<cfset date = "08/14/2005 6:30 pm">
<cfset newdate = "08/15/2005 6:30 pm">
<cfset numberinparty = 5>
<cfset barrived = 0>
<cfset updateuser = "Anonymous">

<!--- update process --->

			<cfquery datasource="acfd700-lab">
				delete 
				from reservation
				where contactid = <cfqueryparam cfsqltype="cf_sql_integer" value="#contactid#">
				and reservationdatetime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#date#">		
			</cfquery>	
		
			<cfquery datasource="acfd700-lab">
				insert into reservations (contactid, reservationdatetime,numberinparty,barrived,updateuser)
				values (
					<cfqueryparam cfsqltype="cf_sql_integer" value="#contactid#">,
					<cfqueryparam cfsqltype="cf_sql_date" value="#newdate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#numberinparty#">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#barrived#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#updateuser#">				
				)	
			</cfquery>


</body>
</html>
