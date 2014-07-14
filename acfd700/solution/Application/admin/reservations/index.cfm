
<cfset thedate = "2005-08-14 00:00:00">

<cfset qreservations = application.cfc.reservation.Reservations_getByDate(thedate)>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Reservations</title>
</head>
<body>
<cfif isdefined("form.btnSubmit")>
	<cfset loopcount = arraylen(rgrid.rowstatus.action)>
	<cfloop from="1" to="#loopcount#" index="i">
		<cfif rgrid.rowstatus.action[i] is "U">
			<cfset application.cfc.reservation.ReservationUpdate (
							contactid = form.rgrid.original.contactid[i], 
							date = form.RGRID.ORIGINAL.RESERVATIONDATETIME[i], 
							newreservationtime = '#thedate# #rgrid.reservationdatetime[i]#',
							numberinparty = form.rgrid.numberinparty[i],
							barrived  = form.rgrid.barrived[i])>
		<cfelseif rgrid.rowstatus.action[i] is "D">
				<cfset application.cfc.reservation.ReservationDelete (
							contactid = form.rgrid.original.contactid[i], 
							date = form.RGRID.ORIGINAL.RESERVATIONDATETIME[i])>	
		</cfif>
	</cfloop>
  <cfdump var="#form#">
</cfif>
<cfset formwidth="600">


<cfform  format="flash" width="#formwidth#" height="450" id="flashform">

<cfformgroup type="panel" label="Reservations on #thedate# ">


<cfformgroup type="vbox" label="Reservation Information">

	<cfformgroup type="horizontal" label="Name">
		<cfinput type="text" name="lastname" id="lastname" size="20" maxlength="50" 
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['Lastname']}" required="yes" validateat="onblur"
			onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'Lastname',lastname.text)">
			
		<cfinput type="text" 	name="firstname" 	size="20" maxlength="50"
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['Firstname']}" required="yes" validateat="onblur"
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
			onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'city',city.text)"
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['city']}" >
		<cfinput type="text" name="state" size="4" maxlength="2"
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['state']}" 
			onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'state',state.text)">
		<cfinput type="text" name="zipcode" size="10" maxlength="10" mask="99999-9999"
			onChange="rgrid.dataProvider.editField(rgrid.selectedIndex,'zipcode',zipcode.text)"
			bind="{rgrid.dataProvider[rgrid.selectedIndex]['zipcode']}" >
	</cfformgroup>
</cfformgroup>


<cfgrid query="qreservations" name="rgrid"  rowheaders="no"  delete="yes"  deletebutton="Delete Reservation" selectmode="Edit">
	<cfgridcolumn name="barrived" header="A?" type="boolean" width="30" >
	<cfgridcolumn name="reservationdatetime" header="Time" mask="L:NN A" width="70"> 
	
	<cfgridcolumn name="lastname" header="Last Name" select="no" >
	<cfgridcolumn name="firstname" header="First Name" select="no">
	<cfgridcolumn name="email" header="Email" select="no">
	<cfgridcolumn name="address1" header="Address" select="no">
	
	<cfgridcolumn name="numberinparty" header="##" dataalign="right" width="20" type="numeric" >
	<cfgridcolumn name="contactid"  display="no">
	<cfgridcolumn name="address2" display="no">
	<cfgridcolumn name="city" display="no">
	<cfgridcolumn name="state" display="no">
	<cfgridcolumn name="zipcode" display="no">
	
</cfgrid>

</cfformgroup>

<cfformgroup type="horizontal"  style="horizontalAlign:right;">
	<cfinput type="submit" name="btnSubmit" value="Submit Changes">
</cfformgroup>
</cfform>

</body>
</html>
