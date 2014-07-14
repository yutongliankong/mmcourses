
<cfset thedate = "08/14/2005">

<cfif not isdefined("application.cfc.reservation")>
			<cfset application.cfc.reservation = createObject("component","mmcourses.acfd700.solution.components.reservation").init("acfd700-lab")>
</cfif>

<cfset qreservations = application.cfc.reservation.Reservations_getByDate(thedate)>

<cfdump var="#qreservations#">

<cfif isdefined("form.btnSubmit")>
	<cfdump var="#form#">
	<!--- 	save code goes here  --->

</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Reservations</title>
</head>
<body>

<cfset formwidth="600">


<cfform  format="flash" width="#formwidth#" height="450" id="flashform">

<cfformgroup type="panel" label="Reservations on #thedate# ">


<cfformgroup type="vbox" label="Reservation Information">

	<cfformgroup type="horizontal" label="Name">
		<cfinput type="text" name="lastname" id="lastname" size="20" maxlength="50" 
			 required="yes" validateat="onblur">
			
		<cfinput type="text" 	name="firstname" 	size="20" maxlength="50"
			 required="yes" validateat="onblur">
	</cfformgroup>
	
	<cfinput type="text" name="email" validate="email" size="30" maxlength="50" label="Email">
		
	<cfinput type="text" name="address1"  size="30" maxlength="50" label="Address 1">
	
	<cfinput type="text" name="address2"  size="30" maxlength="50" label="Address 2">
	
	<cfformgroup type="horizontal" label="City,State,Zip">
		<cfinput type="text" name="city" size="20" maxlength="50">
		<cfinput type="text" name="state" size="4" maxlength="2">
		<cfinput type="text" name="zipcode" size="10" maxlength="10" mask="99999-9999" >
	</cfformgroup>
</cfformgroup>

<!--- cfgrid goes here --->

</cfformgroup>

<cfformgroup type="horizontal">
	<cfinput type="submit" name="btnSubmit" value="Submit Changes" >
</cfformgroup>

</cfform>

</body>
</html>
