
<cfscript>
	qtemplates = application.cfc.template.get();
	qdirectories = application.cfc.directory.get();
	qcategories = application.cfc.category.get();
</cfscript>

<cfif isdefined("form.btnSave")>
	<cfset theurl = application.cfc.page.pagecreate(filename = form.filename, templateid = form.templateid, directoryid = form.directoryid, pagetitle = form.pagetitle, keywords = form.keywords, description = form.description, bIncludeInSiteMap = form.bIncludeInSitemap, releasedate = form.releasedate, updateuser = "sdrucker")>
	
	<cfoutput>

	<script language="javascript">
		window.opener.location.href = '#left(application.basehref,len(application.basehref)-1)##theurl#?edit=1';
		window.close();
	</script>
	</cfoutput>
	<cfabort>
	
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Lab 8-1: Create New Page</title>
</head>
<body>


<!--- lab 8 starts here --->
<cfform format="Flash" width="500" height="400" onSubmit="return validateGrid()">
	
	<cfformitem type="script">
		var validateGrid = function (){
		   if (isNaN(_root.templategrid.selectedIndex)) {
			  alert("You must select a template!","Warning");	
			  return false;
			} else {
			  return true;
			}
		}
	</cfformitem>
	
	
	<cfformgroup type="accordion">
		<cfformgroup type="page" label="Page information" height="200">
			<cfinput type="text" 
					 name="filename" 
					 required="yes" 
					 label="File Name"
					 message="You must enter a filename. It may not contain any special characters"
					 validateat="onblur,onsubmit"
					 maxlength="50">
			
			<cfinput type="text" 
					 name="pagetitle" 
					 required="yes" 
					 label="Title"
					 message="You must enter a page title."
					 validateat="onblur,onsubmit"
					 maxlength="50">
			
			<cfselect 	query="qdirectories"
						name="directoryid"
						display="url"
						value="directoryid"
						label="Select Directory"></cfselect>
			
			<cfselect 	query="qcategories"
						value="categoryid"
						name="categoryid"
						label="Select Category"
						display="categoryname"></cfselect>		 
		</cfformgroup>
		
		<cfformgroup type="page" label="Select Template" height="200">
			<cfgrid
					query="qtemplates"
					selectmode="single"
					rowheight="52"
					width="460"
					height="150"
					name="templategrid"
					rowheaders="no"
					colheaders="no"
					gridlines="no">
					
				<cfgridcolumn name="templateid" display="no">
				<cfgridcolumn name="templatethumbnail" type="image" width="80">
				<cfgridcolumn name="fulldescription">
			
			</cfgrid>
	
			<cfinput type="hidden" name="templateid"
					bind="{templategrid.dataProvider[templategrid.selectedIndex]['templateid']}">
		
		</cfformgroup>
	
		<cfformgroup label="Meta Information" type="page" height="200">
			<cftextarea name="keywords" rows="5" cols="30" label="Page Keywords"></cftextarea>
		
			<cftextarea name="description" rows="5" cols="30" label="Page Description"></cftextarea>
		</cfformgroup>
	
	 <cfformgroup type="page" label="Publish Options" height="200">	
		<cfformgroup type="horizontal" label="Release Date">
		<cfinput type="datefield" required="yes" name="releasedateselector" value="#dateformat(now(),"mm/dd/yyyy")#" width="100">
		
		<cfselect name="releasedatehour" width="40" >
			<cfloop from="1" to="12" index="i">
				<cfoutput>
					<option value="#i#"  <cfif i is hour(now()) or (hour(now()) - 12 is i)>selected</cfif>>#i#</option>
				</cfoutput>
			</cfloop>
		</cfselect>
			
		<cfselect name="releasedateminute" width="40">
			<cfloop from="0" to="59" index="i">
				<cfoutput>
					<option value="#iif(i lt 10,"0 & i",DE(i))#" <cfif i is minute(now())>selected</cfif>>#iif(i lt 10,"0 & i",DE(i))#</option>
				</cfoutput>
			</cfloop>
		</cfselect>

		<cfselect name="releasedateampm" width="45">
				<option value="AM" <cfif hour(now()) lt 12>selected</cfif>>AM</option>
				<option value="PM" <cfif hour(now()) ge 12>selected</cfif>>PM</option>
		</cfselect>
		</cfformgroup>
		
		<cfinput type="hidden" name="releasedate" bind="{releasedateselector.text} {releasedatehour.value}:{releasedateminute.value} {releasedateampm.value}">
		
		<cfinput type="checkbox" name="bIncludeInSitemap" label="Include in site map?">
		
	  </cfformgroup>	
	</cfformgroup>
	
	<cfformgroup type="horizontal">
		<cfinput type="submit" name="btnSave" value="Save">
		<cfinput type="reset" name="btnReset" value="Reset">
	</cfformgroup>
	
</cfform>	


</body>
</html>
