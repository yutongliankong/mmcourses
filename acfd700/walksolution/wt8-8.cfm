
<cfset thedate = "08/14/2005">

<!--- cache CFC's if unit is executed out of order --->
<cfif not isdefined("application.cfc.reservation")>
		<cfset application.cfc.reservation = createObject("component","mmcourses.acfd700.solution.components.reservation").init(application.datasource)>
		<cfset application.cfc.contact = createObject("component","mmcourses.acfd700.solution.components.contact").init(application.datasource)>
</cfif>


<cfif isdefined("form.btnSubmit")>
	<!---
	<cfdump var="#form#">
	--->
	
	<cfset loopcount = arraylen(rgrid.rowstatus.action)>
	
	<cfloop from="1" to="#loopcount#" index="i">
	<!--- 	save code goes here  --->
	<cfswitch expression="#rgrid.rowstatus.action[i]#">
	  <cfcase value="U">
		
			<cfset application.cfc.reservation.ReservationUpdate (
				contactid = rgrid.original.contactid[i],
				date = rgrid.original.reservationdatetime[i],
				newreservationtime = rgrid.reservationdatetime[i],
				numberinparty = rgrid.numberinparty[i],
				barrived = rgrid.barrived[i],
				updateuser = " ")
			>
		
	  </cfcase>
	  
	  <cfcase value="I">
	   <!--- insert new row --->
	   
	   	<cfset application.cfc.reservation.ReservationInsert (
				email = rgrid.email[i],
				date = rgrid.reservationdatetime[i],
				numberinparty = rgrid.numberinparty[i],
				barrived = rgrid.barrived[i],
				firstname = rgrid.firstname[i],
				lastname = rgrid.lastname[i],
				address1=rgrid.address1[i],
				address2=rgrid.address2[i],
				city = rgrid.city[i],
				state = rgrid.state[i],
				zipcode = rgrid.zipcode[i],
				updateuser = " ")
			>
	   
	  </cfcase>
	  
	  <cfcase value="D">
		 <cfset application.cfc.reservation.ReservationDelete(
		 			contactid = rgrid.original.contactid[i], 
					date=parsedatetime("#variables.thedate# #rgrid.original.reservationdatetime[i]#"))>
	  </cfcase>
	</cfswitch>
	</cfloop>
</cfif>

<cfset qreservations = application.cfc.reservation.Reservations_getByDate(thedate)>

<!---
<cfdump var="#qreservations#">
--->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Reservations</title>
</head>
<body>

<cfset formwidth="600">


<cfform  format="flash" width="#formwidth#" height="450" id="flashform" skin="haloblue">

<cfformgroup type="panel" label="Reservations on #thedate# ">
<cfformitem type="spacer" height="5" />

<cfformgroup type="vbox" label="Reservation Information">

	<cfformgroup type="horizontal" label="Name" style="verticalGap: 0;">
		<cfinput type="text" name="lastname" id="lastname" size="20" maxlength="50" 
			 required="yes" validateat="onblur"
			 bind="{rgrid.dataProvider[rgrid.selectedIndex]['Lastname']}"
			 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'Lastname',lastname.text)">
			
		<cfinput type="text" 	name="firstname" 	size="20" maxlength="50"
			 required="yes" validateat="onblur" bind="{rgrid.dataProvider[rgrid.selectedIndex]['Firstname']}"
			 onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'Firstname',firstname.text)">
	</cfformgroup>
	
	<cfinput type="text" name="email" validate="email" size="30" maxlength="50" label="Email"  
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['email']}"
			validateat="onblur"
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

<cfgrid query="qreservations" name="rgrid" rowheaders="no" delete="Yes" deletebutton="Delete Reservation"
		selectmode = "Edit" insert="yes" insertbutton="New Reservation">
		
		<cfgridcolumn name="barrived" header="A?" type="boolean" width="30">
		<cfgridcolumn name="reservationdatetime" header="time" width="150" mask="mm/dd/yyyy L:NN A" >
		<cfgridcolumn name="lastname" header="Last Name" select="no">
		<cfgridcolumn name="firstname" header="First Name" select="no">
		<cfgridcolumn name="email" header="Email" select="No">
		<cfgridcolumn name="address1" header="Address 1" select="no">
		<cfgridcolumn name="numberinparty" header="##" dataalign="right" width="20" type="numeric">

		<cfgridcolumn name="contactid"  display="no">
		<cfgridcolumn name="address2" display="no">
		<cfgridcolumn name="city" display="no">
		<cfgridcolumn name="state" display="no">
		<cfgridcolumn name="zipcode" display="no">
		
		
</cfgrid>

</cfformgroup>

<cfformgroup type="horizontal" style="horizontalAlign:right;">
<cfinput type="submit" name="btnSubmit" value="Submit Changes" >
</cfformgroup>

</cfform>

</body>
</html>
