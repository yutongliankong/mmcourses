<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>


<!--- walkthrough 1 --->
<cfif isdefined("form.btnSubmit")>
	<cfdump var="#form#">
</cfif>

<cfform format="Flash" name="theform">

	<cfinput type="text" name="title" size="30" maxlength="50" tooltip="Enter Article Title Here"
		label="Article Title"
		validateAt="onSubmit"
		required="Yes" message="You must supply an article title">
		
	<cftextarea name="teaser" rows="5" cols="30" label="Teaser / Description" required="No" />
	
	<cfinput type="submit" name="btnSubmit"  value="Save">
	<cfinput type="reset" name="btnReset" 	    value="Reset">
</cfform>

<cfdump var="#variables.theform#">

<!--- end walkthrough 1 --->

</body>
</html>
