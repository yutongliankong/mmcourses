
<cfset thedate = "08/14/2005">

<cfif not isdefined("application.cfc.reservation")>
			<cfset application.cfc.reservation = createObject("component","mmcourses.acfd700.solution.components.reservation").init("acfd700-lab")>
			<cfset application.cfc.contact = createObject("component","mmcourses.acfd700.solution.components.contact").init("acfd700-lab")>
</cfif>

<cfif isdefined("form.btnSubmit")>
	<cfdump var="#form#">
	<!--- 	save code goes here  --->

</cfif>

<cfset qreservations = application.cfc.reservation.Reservations_getByDate(thedate)>

<cfdump var="#qreservations#">


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
			 required="yes" validateat="onblur" bind="{rgrid.dataProvider[rgrid.selectedIndex]['Firstname']}"
			 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'Firstname',firstname.text)">
	</cfformgroup>
	
	<cfinput type="text" name="email" validate="email" size="30" maxlength="50" label="Email"  
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['email']}"
			 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'email',email.text)">
		
	<cfinput type="text" name="address1"  size="30" maxlength="50" label="Address 1"
	 bind="{rgrid.dataProvider[rgrid.selectedIndex]['address1']}"
	 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'address1',address1.text)">
	
	<cfinput type="text" name="address2"  size="30" maxlength="50" label="Address 2"
		 bind="{rgrid.dataProvider[rgrid.selectedIndex]['address2']}"
		 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'address2',address2.text)">
	
	<cfformgroup type="horizontal" label="City,State,Zip">
		<cfinput type="text" name="city" size="20" maxlength="50"
			 bind="{rgrid.dataProvider[rgrid.selectedIndex]['city']}"
			 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'city',city.text)">
	
		<cfinput type="text" name="state" size="4" maxlength="2" 
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['state']}"
			 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'state',state.text)">
		
		<cfinput type="text" name="zipcode" size="10" maxlength="10" mask="99999-9999" 
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['zipcode']}"
			 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'zipcode',zipcode.text)">
	</cfformgroup>
</cfformgroup>

<!--- cfgrid goes here --->



</cfformgroup>

<cfinput type="submit" name="btnSubmit" value="Submit Changes">
</cfform>

</body>
</html>
