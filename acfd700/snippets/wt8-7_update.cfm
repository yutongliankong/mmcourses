<cfset application.cfc.reservation.ReservationUpdate (
	contactid = rgrid.original.contactid[i],
	date = rgrid.original.reservationdatetime[i],
	newreservationtime = rgrid.reservationdatetime[i],
	numberinparty = rgrid.numberinparty[i],
	barrived = rgrid.barrived[i],
	updateuser = " ")
>