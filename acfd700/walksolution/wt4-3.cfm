<cfif isdefined("form.btnSubmit")>
	<cfdump var="#form#">
	
	<cfparam name="form.deletor" default="0">

	<cftransaction>
	
		<cfquery name="qdel" datasource="acfd700-lab">
			update category
			set endtime = #now()#
			where categoryid in  (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#form.deletor#">)
		</cfquery>
	
		<cfloop from="1" to="#form.rc#" index="i">
			
			<!--- step 4 : evaluate variables --->
			<cfset categoryname = form["categoryname#i#"]>
		
			<!--- step 5 --->
			<cfset categoryid = evaluate("form.categoryid#i#")>
		
			<cfif  trim(variables.categoryname is not "") and listfind(form.deletor,variables.categoryid) is 0>
				<cfif variables.categoryid is "">
					<cfquery datasource="acfd700-lab">
						insert into category (categoryname)
						values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.categoryname#">)
					</cfquery>
				<cfelse>
					<cfquery datasource="acfd700-lab">
						update category
						set categoryname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.categoryname#">
						where categoryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.categoryid#">
					</cfquery>
				</cfif>
			</cfif>
		</cfloop>
	</cftransaction>
</cfif>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Dynamically Evaluating Variables</title>
</head>

<body>

<cfquery name="qcategory" datasource="acfd700-lab">
	select categoryid, categoryname
	from category
	where endtime is null
</cfquery>

<!--- step 7: add empty rows for new records using queryaddrow()--->
<cfset queryaddrow(qcategory,5)>

<h1>Edit Content Categories</h1>
<cfform>
	<cfinput type="hidden" name="rc" value="#qcategory.recordcount#" />
	<table>
		<tr>
		<th>Category Name</th>
		<th>Delete</th>
		</tr>
		<cfoutput query="qcategory">
			<tr>
				<td>
					<cfinput type="hidden" name="categoryid#qcategory.currentrow#" value="#qcategory.categoryid#" />
					<cfinput type="text" name="categoryname#qcategory.currentrow#" value="#qcategory.categoryname#" />
				</td>
				<td>
					<cfif qcategory.categoryid is not "">
					<cfinput type="checkbox" name="deletor" value="#qcategory.categoryid#" />		
					</cfif>
				</td>	
				</tr>	
		</cfoutput>
	</table>		
	<cfinput type="submit" value="Save"  name="btnSubmit"/>
</cfform>


</body>
</html>
