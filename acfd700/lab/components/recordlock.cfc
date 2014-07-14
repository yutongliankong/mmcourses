

<cfcomponent hint="Generic code for locking data records">

	<cffunction name="init" access="public" returntype="recordLock" output="false" hint="initializes locking memory structure">
			
		<cfset instance = structnew()>
		<cfset instance.numlocks = 0>
		<cfset instance.stLocks = structnew()>

		<cfreturn this>
	</cffunction>
	
	
	<cffunction name="locksTimeout" access="private" returntype="void" hint="clears dead locks">
		
		<cfset var thislock = "">
		<cfset var counter = 0>
		
		<cflock name="objectlock" type="exclusive" timeout="30"> 
			<cfloop collection="#instance.stLocks#" item="thislock">
				<cfif now() gt instance.stLocks[thislock].timeout>
					<cfset structdelete(instance.stLocks,thislock)>
				<cfelse>
					<cfset counter = counter + 1>
				</cfif>
			</cfloop>
			<cfset instance.numlocks = counter>
		</cflock>
		<cfreturn>
	</cffunction>
	
	
	<cffunction name="get" access="public" returntype="struct" output="false" hint="returns all valid locks">
	
		<cfset locksTimeout()>
			
		<cfreturn instance>
	
	</cffunction>
	
	
	<cffunction name="set" access="public" returntype="struct" output="false">
		<cfargument name="type" type="string" required="Yes" hint="Type of object to lock, i.e. page, article, etc">
		<cfargument name="id" type="numeric" required="Yes" hint="Primary key of record to lock">
		<cfargument name="lockholdername" type="string" required="Yes" hint="Name of lock holder">
		<cfargument name="lockholderid" type="string" required="Yes" hint="PK of lock holder id">
		<cfargument name="locktimeout" type="numeric" required="no" hint="Lock timeout (in minutes)" default="2">
		
		<cfset var pk = arguments.lockholderid & "," &  arguments.type & "," & arguments.id & "," & arguments.lockholdername>
		<cfset var stResult = structnew()>
		<cfset var obj = structnew()>
		
		<cflock name="objectlock" type="exclusive" timeout="30"> <!--- lock for concurrency --->
		
			<cfloop collection = "#instance.stLocks#" item="thislock">
				<cfset obj = instance.stLocks[thislock]>
				<cfif now() gt obj.timeout> <!--- lock timed out, delete --->
					<cfset structdelete(instance.stLocks,thislock)>
				<cfelse> <!--- valid lock, verify --->
					<cfif obj.type is arguments.type and obj.id is arguments.id>
							<cfif obj.lockholderid is arguments.lockholderid> <!--- we're simply updating a pre-existing lock --->
								<cfset obj.timeout =  dateadd('n',arguments.locktimeout,now())>
								<cfset stresult.bstatus = "True">
								<cfset stResult.stLock = obj>
								<cfbreak>
							<cfelse> <!--- someone else has a lock --->
								<cfset stResult.bStatus = "False">
								<cfset stResult.stLock = obj>	
								<cfbreak>
							</cfif>
					</cfif> <!--- was same type and id --->
				</cfif> <!--- lock did not time out --->
			</cfloop>
		
			<cfif structIsEmpty(stResult)> <!--- new lock --->
				<cfscript>
					instance.stLocks[pk] = structnew();
					instance.stLocks[pk].timeout = dateadd('n',arguments.locktimeout,now()); // lock for 2 minutes 
					instance.stLocks[pk].type = arguments.type;
					instance.stLocks[pk].id = arguments.id;
					instance.stLocks[pk].lockholdername = arguments.lockholdername;
					instance.stLocks[pk].lockholderid = arguments.lockholderid;
				
					stResult.bStatus = "true";
					stResult.stLock = instance.stLocks[pk];
					instance.numlocks = instance.numlocks + 1;
				</cfscript>
			</cfif>

		</cflock>

		<cfreturn stResult>
		
	</cffunction>
	

</cfcomponent>