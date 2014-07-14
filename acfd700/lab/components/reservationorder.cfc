<cfcomponent>

	<cffunction name="init" access="public" returntype="reservationorder" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		<cfset datasource = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	
	<cffunction name="get" access="public" returntype="query" output="false">
		<cfargument name="contactid" type="numeric" required="yes">
		<cfargument name="reservationdatetime" type="date" required="yes">
		
		<cfset var qresult = "">

		<cfquery name="qresult" datasource="#datasource#">
			 select reservationorder.quantity, 
			 		   reservationorder.price,
					   dish.dishname,
					   dish.dishid
			from	   reservationorder inner join dish
							on reservationorder.dishid = dish.dishid
			where 	contactid = <cfqueryparam  cfsqltype="cf_sql_integer" value="#arguments.contactid#">
						and reservationdatetime = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.reservationdatetime#">
						and reservationorder.endtime is null
		</cfquery>
		
		<cfreturn qresult>
	</cffunction>
	
</cfcomponent>