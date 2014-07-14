<!--- 

Lab 10: XML Forms

 --->


<cfparam name="url.articleid" default="0">
<cfparam name="form.articleid" default="#url.articleid#">


<cfif isdefined("form.title")>

	<cfparam name="form.categoryid" default="0">

	<cfif form.publishdate is not "">
		<cfset form.publishdate = trim(form.publishdate)  &  " " & form.publishtimehour & ":" & form.publishminute & " " & form.publishampm>
	</cfif>
	
	<cfif form.expdate is not "">
		<cfset form.expdate = trim(form.expdate) &  " " & form.exptimehour & ":" & form.exptimeminute & " " & form.exptimeampm>
	</cfif>

	<cfif form.articleid is 0>
		<cfset form.articleid = application.cfc.article.recordInsert(title = form.title, 
			 teaser = form.teaser, 
			 teaserimage = form.teaserimage,
			 fulltext = form.fulltext,
			 larticlecategoryids = form.categoryid, 
			 publishdate = form.publishdate,
			 expdate = form.expdate,
			 updateuser = 'sdrucker')>
	<cfelse>
		<cfset application.cfc.article.update(
			 articleid = form.articleid,
			 title = form.title, 
			 teaser = form.teaser, 
			 teaserimage = form.teaserimage,
			 fulltext = form.fulltext,
			 larticlecategoryids = form.categoryid, 
			 publishdate = form.publishdate,
			 expdate = form.expdate,
			 updateuser = 'sdrucker')>
	</cfif>

	<cfset position = 1>
	
	<cfif isdefined("form.before")>
		<cfset position = application.cfc.article.PagePositionGet(pageid = form.pageid, articleid = form.before) - 1>
	</cfif>
	
	<cfif isdefined("form.after")>
		<cfset position = application.cfc.article.PagePositionGet(pageid = form.pageid, articleid = form.after)>
	</cfif>
	
	<cfif isdefined("form.pageid")> <!--- bind article to page --->
		<cfset application.cfc.article.pageBind (articleid = form.articleid, pageid = form.pageid, sortorder = variables.position)>
	</cfif>
	
	<script language="javascript">
		window.opener.location.href = window.opener.location.href;
	</script>
	
</cfif>



<cfquery name="qarticle" datasource="acfd700-lab">
   select *
   from article
   where articleid = <cfqueryparam value="#form.articleid#" cfsqltype="cf_sql_integer">
 </cfquery>
 
 <cfif qarticle.recordcount is 0>
 	<cfscript>
		queryaddrow(qarticle,1);
		querysetcell(qarticle,"publishdate",now(),1);
	</cfscript>
 </cfif>
 
<cfquery name="qcategories" datasource="acfd700-lab">
	select category.categoryid,categoryname,1 as bChecked
	from category, articlecategory 
	where (category.categoryid = articlecategory.categoryid) 
	and articlecategory.articleid = <cfqueryparam value="#form.articleid#" cfsqltype="cf_sql_integer">
	   and category.endtime is null
	
	UNION
	
	select categoryid, categoryname, 0 as bchecked
	from category
	where category.categoryid not in (
		select categoryid
		from articlecategory
		where articleid = <cfqueryparam value="#form.articleid#" cfsqltype="cf_sql_integer">
	)
	and endtime is null

  	order by categoryname
	
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Edit Content</title>
</head>
<body leftmargin="0" topmargin="0">

<cfset formwidth="600">

<cfform  format="xml" width="#formwidth#" skin="basiccss">

  <cfinput type="hidden" name="articleid" value="#form.articleid#">
  <cfinput type="hidden" name="teaserimage" value="">
  	
  <cfif isdefined("url.pageid")>
  	<cfinput type="hidden" name="pageid" value="#url.pageid#">
  </cfif>	
  
  <cfif isdefined("url.before")>
  	<cfinput type="hidden" name="before" value="#url.before#">
  </cfif>
  
  <cfif isdefined("url.after")>
  	<cfinput type="hidden" name="after" value="#url.after#">
  </cfif>
	
  <cfformgroup type="wizard" width="500" height="300">
	  <cfformgroup type="wizardstep" label="Name / Teaser" height="300" width="#formwidth#">
		  <cfinput type="text" 
							name="title"  
							id="title"
							size="50" 
							maxlength="50" 
							label="Article Name" 
							validateat="onSubmit"  required="yes"  message="You must enter the name of the article"
							value="#qarticle.title#"
							style="font-family: Arial; font-size: 12px; width:500px;">
							
		  <cftextarea name="teaser" 
		  	rows="5" cols="30"
			label="Description"
			required="no" 
			value="#trim(qarticle.teaser)#"
			style="width:500px; height:200px; font-family: Arial; font-size: 12px;"></cftextarea>
	  </cfformgroup>
	  
	  <cfformgroup type="wizardstep" label="Full Text" height="300" width="#formwidth#">
		 <cftextarea name="fulltext" width="500" height="260" rows="15" cols="40" label="Full Text" 
					required="no" message="You must enter article text" editor="fckeditor"><cfoutput>#jsStringFormat(qarticle.fulltext)#</cfoutput></cftextarea></cfformgroup>
	  
	
	  <cfformgroup type="wizardstep" label="Categorize" height="300" width="#formwidth#">
		<!---
		<cfoutput query="qcategories">
			<cfinput type="checkbox"
					 name="categoryid" 
					 label="#qcategories.categoryname#" height="15"
					 value="#qcategories.categoryid#" checked="#qcategories.bchecked#">
		  </cfoutput>
		  --->
		  <cfformgroup type="dualselectlist">
		  	<cfselect name="avail" size="5" multiple="yes" label="Available:">
			   <cfoutput query="qcategories">
				 <cfif not qcategories.bchecked>
				   <option value="#qcategories.categoryid#">
						#qcategories.categoryname#
				   </option>
				</cfif>
				</cfoutput>
			</cfselect>
			
			<cfselect name="categoryid" size="5" multiple="yes" label="Selected:">
			   <cfoutput query="qcategories">
				 <cfif qcategories.bchecked>
				   <option value="#qcategories.categoryid#" selected>
						#qcategories.categoryname#
				   </option>
				</cfif>
				</cfoutput>
			</cfselect>
		  </cfformgroup>
	  </cfformgroup>


  <cfformgroup type="wizardstep" label="Publishing Options" height="300" width="#formwidth#">
	  <cfformgroup type="horizontal" label="Publish Date/Time:" >
	  <cfinput type="datefield" name="publishdate"
							 width="150" 
							 tooltip="The article will become visible to the public after this date" 
							 startrange="#dateformat(dateadd('d',-1,now()),"mm/dd/yyyy")#" 
							 value="#dateformat(qarticle.publishdate,"mm/dd/yyyy")#">
	  
	  <cfselect name="publishtimehour" width="50" >
	  <cfloop from="1" to="12" index="i">
		<cfoutput>
		  <option value="#i#" <cfif  i is hour(qarticle.publishdate) or i is (hour(qarticle.publishdate) - 12)>selected</cfif>>#i#</option>
		</cfoutput>
	  </cfloop>
	  </cfselect>
	  <cfselect name="publishminute" width="50">
	  <cfloop from="0" to="59" index="i">
		<cfoutput>
		  <option value="#iif(i lt 10,"0 & i",DE(i))#" <cfif i is minute(qarticle.publishdate)>selected</cfif>>#iif(i lt 10,"0 & i",DE(i))#</option>
		</cfoutput>
	  </cfloop>
	  </cfselect>
	  <cfselect name="publishampm" width="50">
	  <option value="AM" <cfif hour(qarticle.publishdate) lt 12>selected</cfif>>AM</option>
	  <option value="PM" <cfif hour(qarticle.publishdate) ge 12>selected</cfif>>PM</option>
	  </cfselect>
	  </cfformgroup>
  
	  <cfformgroup type="horizontal" label="Expiration Date/Time:" >
	  <cfinput type="datefield" name="expdate"
							 width="150" 
							 tooltip="The article will be removed from the site after this date" 
							 startrange="#dateformat(dateadd('d',-1,now()),"mm/dd/yyyy")#" value="#dateformat(qarticle.expdate,"mm/dd/yyyy")#">
	  <cfselect name="exptimehour" width="50" >
	  <cfloop from="1" to="12" index="i">
		<cfoutput>
		  <option value="#i#" <cfif qarticle.expdate is not "" AND ( i is hour(qarticle.expdate) or i is (hour(qarticle.expdate) - 12))>selected</cfif>>#i#</option>
		</cfoutput>
	  </cfloop>
	  </cfselect>
	  <cfselect name="exptimeminute" width="50">
	  <cfloop from="0" to="59" index="i">
		<cfoutput>
		  <option value="#iif(i lt 10,"0 & i",DE(i))#" <cfif qarticle.expdate is not "" AND i is minute(qarticle.expdate)>selected</cfif>>#iif(i lt 10,"0 & i",DE(i))#</option>
		</cfoutput>
	  </cfloop>
	  </cfselect>
	  <cfselect name="exptimeampm" width="50">
	  <option value="AM" <cfif  qarticle.expdate is not "" AND hour(qarticle.expdate) lt 12>selected</cfif>>AM</option>
	  <option value="PM" <cfif qarticle.expdate is not "" AND hour(qarticle.expdate) ge 12>selected</cfif>>PM</option>
	  </cfselect>
	  </cfformgroup>
  
  </cfformgroup>
 </cfformgroup>

</cfform>


</body>
</html>
