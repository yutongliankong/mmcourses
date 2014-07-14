
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Edit Article Content</title>
</head>

<body>

<cfif isdefined("form.btnSubmit")>
	<cfdump var="#form#">
</cfif>


<!--- walkthrough 2 --->
<cfset formwidth="600">

<cfform  format="flash" width="#formwidth#" height="400" id="flashform">

		<!--- page 1 content --->
		<cfinput type="text" 
				name="title"  
				size="30" 
				maxlength="50" 
				title="Article Title"
				label="Article Title" 
				validateat="onSubmit"  required="yes"  message="You must enter a title for the article">
				
		<cftextarea name="teaser" rows="5" cols="30" label="Description" required="no" ></cftextarea>
		<!--- end page 1 content --->

		<!--- page 2 content --->
		<cftextarea name="fulltext" rows="15" cols="40" label="Full Text" required="yes" message="You must enter article text"></cftextarea>
		<!--- end page 2 content --->


		<!--- page 3 content --->
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
		
	<!--- end page 3 content --->			

	<cfformgroup type="horizontal">		
		<cfinput type="submit" name="btnSubmit" value="Save" id="btnSubmit" label="Save">
		<cfinput type="reset" name="btnReset" value="Reset" id="btnReset" label="Reset">
	</cfformgroup>
	
</cfform>

<!--- end walkthrough 2 --->

</body>
</html>
