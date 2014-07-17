

<cfset articleid = 3> <!--- edit article 1 --->

<cfquery name="qarticle" datasource="acfd700-lab">
   select *
   from article
   where articleid = #articleid#
 </cfquery>
 
<cfquery name="qcategories" datasource="acfd700-lab">
	select category.categoryid,categoryname,1 as bChecked
	from category,articlecategory 
		where (category.categoryid = articlecategory.categoryid) 
	 and  articlecategory.articleid = #articleid#
	   and category.endtime is null
	
	UNION
	
	select categoryid, categoryname, 0 as bchecked
	from category
	where category.categoryid not in (
		select categoryid
		from articlecategory
		where articleid = #articleid#
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
<body>
<cfif isdefined("form.btnSubmit")>
  <cfdump var="#form#">
</cfif>
<cfset formwidth="600">

<!--- walkthrough 6: add onerror condition --->
<cfform  format="flash" width="#formwidth#" height="420" id="flashform" onerror="handleValidation(errors)">

	<!--- walkthrough 6 - actionscript in cfformitem (merrimack) --->
	<cfformitem type="script">
    var handleValidation = function (errors){
      
    if (errors['title'] != undefined) {
      tab1.selectedIndex = 0;
      _root.title.setFocus();
      return;
    }
      
    if (errors['fulltext'] != undefined) {
      tab1.selectedIndex=1;
      _root.fulltext.setFocus();
      return;
    }
}
  </cfformitem>
	
	
	<!--- end walkthrough 6 --->
	
  <cfinput type="hidden" 
		name="publishdatetime" 
		bind="{publishdate.text} {publishtimehour.value}:{publishminute.value} {publishampm.value}">
  <cfinput type="hidden" 
		name="expdatetime" 
		bind="{expdate.text} {exptimehour.value}:{exptimeminute.value} {exptimeampm.value}">
  <cfformgroup type="panel" label="Now Editing: {title.text}">
  <cfformgroup type="tabnavigator">
 
 
  <cfformgroup type="page" label="Name / Teaser" height="300" width="#formwidth#">
  <cfinput type="text" 
					name="title"  
					size="30" 
					maxlength="50" 
					title="Article Title"
					label="Article Title" 
					validateat="onSubmit"  required="yes"  message="You must enter a title for the article"
					value="#trim(qarticle.title)#">
					
  <cftextarea name="teaser" rows="5" cols="30" label="Description" required="no" value="#qarticle.teaser#" ></cftextarea>
  
  </cfformgroup>
  
  <cfformgroup type="page" label="Full Text" height="300" width="#formwidth#">
  <cftextarea name="fulltext" rows="15" cols="40" label="Full Text" 
					required="yes" message="You must enter article text"></cftextarea>
  </cfformgroup>
  
  <!--- walkthrough 4: Repeater - step 1 --->
  <cfformgroup type="page" label="Categorize" height="300" width="#formwidth#">
  <cfformgroup type="repeater" query="qcategories">
  <cfinput type="checkbox"
			 name="categoryid" 
			 label="{qcategories.currentItem.categoryname}" height="15"
			 value="{qcategories.currentItem.bChecked}">
  </cfformgroup>
    <cfinput type="hidden" name="lcheckboxids" value="#valuelist(qcategories.categoryid)#">
  </cfformgroup>
  <!--- end walkthrough 4: Repeater --->

  <cfformgroup type="page" label="Publishing Options" height="300" width="#formwidth#">
  <cfformgroup type="horizontal" label="Publish Date/Time:" >
  
  <cfinput type="datefield" name="publishdate"
						 width="150" 
						 tooltip="The article will become visible to the public after this date" 
						 startrange="#dateformat(dateadd('d',-1,now()),"mm/dd/yyyy")#"
						 value="#dateformat(qarticle.publishdate,"mm/dd/yyyy")#">
 
  <cfselect name="publishtimehour" width="50"  selected="#hour(qarticle.publishdate)#">
  <cfoutput>
  <cfloop from="1" to="12" index="i">
       <option value="#i#" 
	  		<cfif isdate(qarticle.publishdate) and (hour(qarticle.publishdate) is i or (hour(qarticle.publishdate) - 12 is i))>			selected
			</cfif>
	   >#i#</option>
  </cfloop>
  </cfoutput>
  </cfselect>
  
  <cfselect name="publishminute" width="50">
  <cfloop from="0" to="59" index="i">
    <cfoutput>
      <option value="#iif(i lt 10,"0 & i",DE(i))#" 
	  	<cfif  isdate(qarticle.publishdate) and (i is minute(qarticle.publishdate) or 0 & i is minute(qarticle.publishdate))>
			selected
		</cfif>
	   >#iif(i lt 10,"0 & i",DE(i))#</option>
    </cfoutput>
  </cfloop>
  </cfselect>
  
  <cfselect name="publishampm" width="50">
  <option value="AM" <cfif isdate(qarticle.publishdate) and hour(qarticle.publishdate) lt 12>selected</cfif>>AM</option>
  <option value="PM" <cfif isdate(qarticle.publishdate) and hour(qarticle.publishdate) ge 12>selected</cfif>>PM</option>
  </cfselect>
  </cfformgroup>
  
  <cfformgroup type="horizontal" label="Expiration Date/Time:" >
  <cfinput type="datefield" name="expdate"
						 width="150" 
						 tooltip="The article will be removed from the site after this date" 
						 startrange="#dateformat(dateadd('d',-1,now()),"mm/dd/yyyy")#">
  <cfselect name="exptimehour" width="50" >
  <cfoutput>
  <cfloop from="1" to="12" index="i">
       <option value="#i#" 
	  		<cfif isdate(qarticle.expdate) and (hour(qarticle.expdate) is i or (hour(qarticle.expdate) - 12 is i))>			selected
			</cfif>
	   >#i#</option>
  </cfloop>
  </cfoutput>
  </cfselect>
  <cfselect name="exptimeminute" width="50">
  <cfloop from="0" to="59" index="i">
    <cfoutput>
      <option value="#iif(i lt 10,"0 & i",DE(i))#" 
	  	<cfif  isdate(qarticle.expdate) and (i is minute(qarticle.expdate) or 0 & i is minute(qarticle.expdate))>
			selected
		</cfif>
	   >#iif(i lt 10,"0 & i",DE(i))#</option>
    </cfoutput>
  </cfloop>
  </cfselect>
  <cfselect name="exptimeampm" width="50">
  <option value="AM"  <cfif isdate(qarticle.expdate) and hour(qarticle.expdate) lt 12>selected</cfif>>AM</option>
  <option value="PM" <cfif isdate(qarticle.expdate) and hour(qarticle.expdate) ge 12>selected</cfif>>PM</option>
  </cfselect>
  </cfformgroup>
  
  </cfformgroup>
  </cfformgroup>
  <cfformgroup type="horizontal">
  <cfinput type="submit" name="btnSubmit" value="Save" id="btnSubmit" label="Save">
  <cfinput type="reset" name="btnReset" value="Reset" id="btnReset" label="Reset">
  </cfformgroup>
  </cfformgroup>
</cfform>
</body>
</html>





