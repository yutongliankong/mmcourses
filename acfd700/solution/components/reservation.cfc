<cfcomponent extends="contact">

	<cffunction name="init" access="public" returntype="reservation" output="false">
		<cfargument name="dsn"  type="string" required="yes" hint="datasource">
		
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
		
		<cfreturn this>
	</cffunction>

	<cffunction name="Reservations_getByDate" access="public" 
					returntype="query" hint="Returns contact info for a specific date" output="false">
		<cfargument name="date"  type="date" required="yes" hint="Reservation Date">
		
		<cfset var qgetreservations = "">
		
		<cfset arguments.date = createodbcdate(arguments.date)>
		
		<cfquery name="qgetreservations" datasource="#instance.datasource#">
			select contact.*, 
					  reservation.numberinparty,
					  reservation.barrived,
					  format(reservation.reservationdatetime,'mm/dd/yyyy hh:mm AMPM') as ReservationDateTime
			from contact inner join reservation
				on contact.contactid = reservation.contactid
			where 
				reservation.reservationdatetime >=  <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.date#">
				and reservation.reservationdatetime < #createodbcdate(dateformat(dateadd('d',1,arguments.date),"yyyy-mm-dd hh:mm:ss"))#
				and reservation.endtime is null
				and contact.endtime is null
			order by reservation.reservationdatetime
		</cfquery>
		
		<cfreturn qgetreservations>
	</cffunction>
	

	<cffunction name="ReservationDelete" access="public" returntype="void" hint="Delete Reservation" output="false">
			<cfargument name="contactid" type="numeric" required="yes" hint="Contact PK">
			<cfargument name="date" type="date" required="yes" hint="Reservation Date" >

			<cfquery datasource="#instance.datasource#">
				delete 
				from reservation
				where contactid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contactid#">
				and reservationdatetime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.date#">
			</cfquery>	
			
	</cffunction>
	
	<cffunction name="ReservationInsert" access="public" returntype="void" hint="Insert Reservation" output="false">
		<cfargument name="email" type="string" required="yes">
		<cfargument name="date" type="date" required="yes" hint="Reservation date/time">
		<cfargument name="numberinparty" type="numeric" required="yes">
		<cfargument name="barrived" type="boolean" required="no" default="false">
		<cfargument name="firstname" type="string" required="No">
		<cfargument name="lastname" type="string" required="No">
		<cfargument name="address1" type="string" required="no">
		<cfargument name="address2" type="String" required="no">
		<cfargument name="city" type="string" required="no">
		<cfargument name="state" type="String" required="No">
		<cfargument name="zipcode" type="string" required="No">
		<cfargument name="updateuser" type="string" required="no">
		
		<cfset var qcontact =  application.cfc.contact.getByEmail(arguments.email)>
		<cfset var contactid = "">
		<cfset var stContact = structnew()>
		
		<cfif qcontact.recordcount is 0> <!--- new contact --->
			<cfset contactid = application.cfc.contact.recordInsert(contact = arguments, updateuser = arguments.updateuser)>
		<cfelse>
			<cfset contactid = qcontact.contactid>
		</cfif>
		
		<cfset reservationSave (contactid = contactid, reservationtime = arguments.date,  numberinparty = arguments.numberinparty, barrived = arguments.barrived, updateuser = arguments.updateuser)>
		
	</cffunction>
	
	
	<cffunction name="reservationSave" access="private" output="false" returntype="void">
		<cfargument name="contactid" type="numeric" required="yes" hint="Contact PK">
		<cfargument name="reservationtime" type="date" required="yes">
		<cfargument name="numberinparty" type="numeric" required="yes">
		<cfargument name="barrived" type="boolean" required="yes">
		<cfargument name="updateuser" type="string" required="no" default="">

		<cfquery datasource="#instance.datasource#">
				insert into reservation (contactid, reservationdatetime,numberinparty,barrived,updateuser)
				values ( #arguments.contactid#,
							<cfqueryparam value="#arguments.reservationtime#" cfsqltype="CF_SQL_timestamp">,
							#numberinparty#,
							<cfqueryparam value="#arguments.barrived#" cfsqltype="CF_SQL_BIT">,
							'#arguments.updateuser#')	
		</cfquery>
	
	</cffunction>
	
	
	<cffunction name="ReservationUpdate" access="public" returntype="void" hint="Update Reservation" output="false">
		<cfargument name="contactid" type="numeric" required="yes" hint="Contact PK">
		<cfargument name="date" type="date" required="yes" hint="Reservation Date">
		<cfargument name="newreservationtime" type="date" required="yes">
		<cfargument name="numberinparty" type="numeric" required="yes">
		<cfargument name="barrived" type="boolean" required="yes">
		<cfargument name="updateuser" type="string" required="no" default="">
		
		<cftransaction>
	
			<cfset reservationDelete(contactid = arguments.contactid, date = arguments.date)>
			<cfset reservationSave(contactid = arguments.contactid,
											 reservationtime = arguments.newreservationtime,
											 numberinparty = arguments.numberinparty, 
											 barrived = arguments.barrived,
											 updateuser = arguments.updateuser)
			>
		
			<!--- needs work to deal with updating contact information --->
			
		</cftransaction>
		
	</cffunction>
	
	
</cfcomponent>