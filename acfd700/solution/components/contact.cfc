<cfcomponent>
	<cffunction name="init" access="public" returntype="contact" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="recordInsert" access="public" returntype="numeric" output="false">
		<cfargument name="contact" type="struct" required="yes" hint="lastname,firstname,email,address1,address2,city,state,zipcode">
		<cfargument name="updateuser" type="string" required="no" default="" hint="Account responsible for update">
		
		<cfset var qcontactid = "">
		
		<cftransaction>
			<cfquery datasource="#instance.datasource#">
				insert into contact (lastname, firstname, email, address1, address2, city, state, zipcode, updateuser)
				values (
					<cfqueryparam value="#arguments.contact.lastname#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.contact.firstname#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.contact.email#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.contact.address1#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.contact.address2#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.contact.city#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.contact.state#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.contact.zipcode#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.updateuser#" cfsqltype="cf_sql_varchar">)
			</cfquery>
			<cfquery name="qcontactid" datasource="#instance.datasource#">
				select max(contactid) as thecontactid
				from contact
			</cfquery>
		</cftransaction>
		
		<cfreturn qcontactid.thecontactid>
	</cffunction>
	
	
	<cffunction name="Update" access="public" returntype="void" output="false">
		<cfargument name="contact" type="struct" required="yes" hint="contactid,lastname,firstname,email,address1,address2,city,state,zipcode">
		<cfargument name="updateuser" type="string" required="no" hint="User account responsible for update" default="">
		
		<cfquery datasource="#instance.datasource#">
			update contact
			set lastname = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.lastname#">,
				firstname =  <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.firstname#">,
				email = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.email#">,
				address1 = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.address1#">,
				address2 = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.address2#">,
				city = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.city#">,
				state = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.state#">,
				zipcode = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.contact.zipcode#">,
				updateuser = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.updateuser#">,
				updatedate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
			where contactid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contact.contactid#">
		</cfquery>

	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="contactid" type="numeric" required="yes" hint="Primary Key">
		<cfargument name="updateuser" type="string" required="no" hint="User account responsible for update" default="">
		
		<cfquery datasource="#instance.datasource#">
			update contact
			set 	endtime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
				 	updatedate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
					updateuser = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#arguments.updateuser#">
			where contactid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contact.contactid#">
		</cfquery>
		
	</cffunction>
	
	
	<cffunction name="get" access="public" returntype="query" output="false">
		<cfargument name="lcontactids" type="string" required="no" hint="Primary Key" default="">
		
		<cfset var qresult = "">
		
		<cfquery name="qresult" datasource="#instance.datasource#">
			select *
			from contact
			where 0=0
			<cfif arguments.lcontactids is not "">
				and contactid in  (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#arguments.lcontactids#">)
			</cfif>
			and endtime is null
		</cfquery>
		
		<cfreturn qresult>
		
	</cffunction>
	
	
	<cffunction name="getByEmail" access="public" returntype="query" output="false">
		<cfargument name="email" type="string" required="yes" hint="Email address of contact" default="">
		
		<cfset var qresult = "">
		
		<cfquery name="qresult" datasource="#instance.datasource#">
			select *
			from contact
			where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
		</cfquery>
		
		<cfreturn qresult>
	
	</cffunction>
	
</cfcomponent>