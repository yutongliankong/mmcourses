
<cfquery name="qcategories" datasource="acfd700-lab">
	select categoryid,categoryname
	from category
	where endtime is null
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

<cfform  format="flash" width="#formwidth#" height="410" id="flashform">

<!--- walkthrough 3: Databinding --->
<cfinput type="hidden" 
	name="publishdatetime" 
	bind="{publishdate.text} {publishtimehour.value}:{publishminute.value} {publishampm.value}">

<cfinput type="hidden" 
	name="expdatetime" 
	bind="{expdate.text} {exptimehour.value}:{exptimeminute.value} {exptimeampm.value}">

<cfformgroup type="panel" label="Now Editing: {title.text}">

<!--- end walkthrough 3: Databinding --->
	
	<cfformgroup type="tabnavigator">
	
		<cfformgroup type="page" label="Name / Teaser" height="300" width="#formwidth#">		
			<cfinput type="text" 
					name="title"  
					size="30" 
					maxlength="50" 
					title="Dish Name"
					label="Dish Name" 
					validateat="onSubmit"  required="yes"  message="You must enter the name of the dish">
					
			<cftextarea name="teaser" rows="5" cols="30" label="Description" required="no" ></cftextarea>
		</cfformgroup>

		<cfformgroup type="page" label="Full Text" height="300" width="#formwidth#">
				<cftextarea name="fulltext" rows="15" cols="40" label="Full Text" required="yes" message="You must enter article text"></cftextarea>
		</cfformgroup>
	
	<!--- wt 9-4: Checkboxes --->
	
	
		
	<cfformgroup type="page" label="Publishing Options" height="300" width="#formwidth#">
			<cfformgroup type="horizontal" label="Publish Date/Time:" >
			
				<cfinput type="datefield" name="publishdate"
						 width="150" 
						 tooltip="The article will become visible to the public after this date" 
						 startrange="#dateformat(dateadd('d',-1,now()),"mm/dd/yyyy")#">
				
				<cfselect name="publishtimehour" width="50" >
					<cfloop from="1" to="12" index="i">
						<cfoutput>
							<option value="#i#">#i#</option>
						</cfoutput>
					</cfloop>
				</cfselect>
					
				<cfselect name="publishminute" width="50">
					<cfloop from="0" to="59" index="i">
						<cfoutput>
							<option value="#iif(i lt 10,"0 & i",DE(i))#">#iif(i lt 10,"0 & i",DE(i))#</option>
						</cfoutput>
					</cfloop>
				</cfselect>

				<cfselect name="publishampm" width="50">
						<option value="AM">AM</option>
						<option value="AM">PM</option>
				</cfselect>
				
			</cfformgroup>
			
			<cfformgroup type="horizontal" label="Expiration Date/Time:" >
			
				<cfinput type="datefield" name="expdate"
						 width="150" 
						 tooltip="The article will be removed from the site after this date" 
						 startrange="#dateformat(dateadd('d',-1,now()),"mm/dd/yyyy")#">
				
				<cfselect name="exptimehour" width="50" >
					<cfloop from="1" to="12" index="i">
						<cfoutput>
							<option value="#i#">#i#</option>
						</cfoutput>
					</cfloop>
				</cfselect>
					
				<cfselect name="exptimeminute" width="50">
					<cfloop from="0" to="59" index="i">
						<cfoutput>
							<option value="#iif(i lt 10,"0 & i",DE(i))#">#iif(i lt 10,"0 & i",DE(i))#</option>
						</cfoutput>
					</cfloop>
				</cfselect>

				<cfselect name="exptimeampm" width="50">
						<option value="AM">AM</option>
						<option value="AM">PM</option>
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
