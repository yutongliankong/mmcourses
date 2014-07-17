<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Walkthrough 8-1: Create a Simple Flash Form</title>
</head>

<body>


<!--- walkthrough 1 --->
<cfif structKeyExists(form,"btnSubmit")>
	<cfdump var="#form#">
</cfif>
<cfform name="theform" format="flash">
	<cfinput type="text" name="title" size="30" maxlength="50" tooltip="Enter Article Title Here" label="Article Title" validateat="onsubmit" required="true" message="You must supply an article title">
	<cftextarea name="teaser" rows="5" cols="30" label="Teaser / Description" required="No">
	</cftextarea>
	<cfinput type="submit" name="btnsubmit" value="Save">
	<cfinput type="reset" name="btnreset" value="Reset" label="Reset">
</cfform>
<cfdump var="#variables.theform#">
<!--- end walkthrough 1 --->

</body>
</html>
