<cfparam name="url.articleid" default="3">
<cfparam name="form.categoryid" default="0">

<cfif isdefined("form.articleid")>
	<cfparam name="form.categoryid" default="">
	<cftransaction>
		<cfquery datasource="acfd700-lab">
			update article
			set title = <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
				 fulltext =  <cfqueryparam value="#form.fulltext#" cfsqltype="cf_sql_clob">
			where articleid = <cfqueryparam value="#form.articleid#"  cfsqltype="cf_sql_integer">
		</cfquery>
		

		<!--- Step 9 Goes Here --->
		<cfquery datasource="acfd700-lab">
			DELETE 
			FROM articlecategory
			WHERE articleid = <cfqueryparam value="#Form.articleid#" cfsqltype="cf_sql_integer">
		</cfquery>


		

		
		<!--- End Step 9 --->
		
		<!--- Step 11 Goes Here --->

		<!--- the comment must be wraped by three dashes, otherwise it will be process too--->
		<!--- <cfloop list="#Form.categoryid#" index="i">
			<cfquery datasource="acfd700-lab">
				INSERT INTO articlecategory (articleid, categoryid)
				VALUES (
					<cfqueryparam value="#Form.articleid#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#variables.i#" cfsqltype="cf_sql_integer">
				)
			</cfquery>
		</cfloop> --->

	<cfquery datasource="acfd700-lab">
		INSERT INTO articlecategory (articleid, categoryid)
		SELECT <cfqueryparam value="#Form.articleid#" cfsqltype="cf_sql_integer"> as articleid, categoryid
		FROM category
		WHERE categoryid in (
			<cfqueryparam value="#Form.categoryid#" cfsqltype="cf_sql_integer" list="yes">
		)
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
<cfset larticlecategories = valueList(qarticlecategories.categoryid) >
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
				value="#qcategories.categoryid#"<!--- Step 5 Goes Here ---> <!--- end step 5 ---> 
					<cfif listFind(variables.larticlecategories, qcategories.categoryid) GT 0>
						checked
					</cfif>
				 />
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
