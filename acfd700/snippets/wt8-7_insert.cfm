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