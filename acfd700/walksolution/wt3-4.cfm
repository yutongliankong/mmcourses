<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Walkthrough 3-4: Delimited File Uploading and Processing</title>
</head>

<body>

<cfif not isdefined("form.btnSubmit")>
	<!--- step 3: Modify cfform --->
	<cfform enctype="multipart/form-data">
		Select file to upload: 
		<!--- step 4: add cfinput tag for file uploading --->
		<cfinput type="file" name="datafile">
		<br />
		<br />
		<cfinput type="submit" name="btnSubmit" value="Upload File">
	</cfform>
<cfelse>

	<!--- write the file to disk --->
	<cffile action="UPLOAD" filefield="datafile" destination="#expandpath('.')#" nameconflict="makeunique">
	
	<!--- read the file back into memory --->
	<cffile action="read" file="#file.serverdirectory#\#file.serverfile#" variable="datafile">
		
	<!--- process file into a <cfquery> object --->
	<cfset lcolumns = "firstname,lastname,email,zipcode,cellphone">
	<cfset qcontacts=querynew(variables.lColumns,"varchar,varchar,varchar,integer,varchar")>
	<cfloop list="#datafile#" delimiters="#chr(10)#" index="thisrow">
		<cfset column = 0>	
		<cfset queryaddRow(qcontacts,1)>
		<cfset nRow = qContacts.recordcount>		
		<cfloop list="#variables.thisrow#" delimiters="," index="thiscell">
			<cfset column = column + 1>
			<cfset columnName = listgetat(lColumns,column)>
			<cfset querysetcell(qContacts,variables.columnName,thisCell,nRow)>
		</cfloop>
	</cfloop>
	<!--- end text file processing --->
	
	<!--- step 6: Write <cfquery> to sort qContacts --->
	<cfquery name="qsort" dbtype="query">
		select *
		from qcontacts
		order by lastname,firstname
	</cfquery>
	
	<cfdump var="#qsort#" label="Sorted Data">
	<cfdump var="#qContacts#" label="Original Data">
	
</cfif>


</body>
</html>
