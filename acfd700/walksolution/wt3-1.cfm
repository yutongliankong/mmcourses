<cfparam name="url.articleid" default="3">
<cfparam name="form.categoryid" default="0">

<cfif isdefined("form.articleid")>
	<cfparam name="form.categoryid" default="">
	<cftransaction>
		<cfquery datasource="acfd700-lab">
			update article
			set title = <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
				 fulltext =  <cfqueryparam value="#form.fulltext#" cfsqltype="CF_SQL_clob">
			where articleid = <cfqueryparam value="#form.articleid#"  cfsqltype="cf_sql_varchar">
		</cfquery>
		
		<!--- Step 9 Goes Here --->
		<cfquery datasource="acfd700-lab">
			delete 
			from articlecategory
			where articleid = <cfqueryparam value="#form.articleid#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		<!--- End Step 9 --->
		
		<!--- Step 11 Goes Here --->
		<!---
		<cfloop list="#form.categoryid#" index="i">
			<cfquery datasource="acfd700-lab">
				insert into articlecategory (articleid,categoryid)
				values (<cfqueryparam value="#form.articleid#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#variables.i#" cfsqltype="cf_sql_integer">) 
			</cfquery>
		</cfloop>
		--->
		<cfquery datasource="acfd700-lab">
			insert into articlecategory (articleid,categoryid)
			select <cfqueryparam value="#form.articleid#" cfsqltype="cf_sql_integer"> as articleid, categoryid
			from category
			where categoryid in (<cfqueryparam value="#form.categoryid#" cfsqltype="CF_SQL_INTEGER" list="Yes">)
		</cfquery>

		
		<!--- End Step 11 --->
		
	</cftransaction>
</cfif>


<cfquery name="article" datasource="acfd700-lab">
	select articleid, title, fulltext
	from article
	where articleid = #url.articleid#
</cfquery>

<cfquery name="qcategories" datasource="acfd700-lab">
	select categoryid,categoryname
	from category
	order by categoryname
</cfquery>


<cfquery name="qarticlecategories" datasource="acfd700-lab">
	select categoryid
	from articlecategory
	where articleid = #url.articleid#
</cfquery>	

<!--- Step 4 Goes Here--->
<cfset lArticleCategories = valuelist(qarticlecategories.categoryid)>
<!--- end step 4 --->



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Walkthrough 3-1: Lists</title>
</head>

<body>

<cfform>

<cfinput type="hidden" name="articleid" value="#article.articleid#">

<table>
	<tr valign="top"><td>	
			<table>
			<tr>
				<td>Title:</td>
				<td><cfinput type="text" name="title" size="30" maxlength="50" value="#article.title#"></td>
			</tr>
			<tr>
				<td colspan="2"><cftextarea name="fulltext" rows="7" cols="40"><cfoutput>#article.fulltext#</cfoutput></cftextarea></td>
			</tr>
		</table>
	</td>
	<td rowspan="2">
		<fieldset style="height:140px; width:200px"><legend>Category</legend>
			
			<cfoutput query="qcategories">
				<input type="checkbox" 
				name="categoryid" 
				value="#qcategories.categoryid#"<!--- Step 5 Goes Here ---> <cfif listfind(variables.lArticleCategories,qcategories.categoryid) gt 0>checked</cfif><!--- end step 5 --->  />
				#qcategories.categoryname#<br />
			</cfoutput>
			
		</fieldset>
	</td>
	</tr>
</table>
	<input type="submit" value="Save"  name="btnSave" />

</cfform>

</body>
</html>
