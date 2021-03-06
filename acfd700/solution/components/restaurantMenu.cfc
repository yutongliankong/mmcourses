<cfcomponent>

	<cffunction name="init" access="public" returntype="restaurantMenu" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="get" access="public" returntype="query" output="false">
		<cfargument name="menudate" type="date" required="yes">
		<cfargument name="menutypeid" type="string" required="no" default="">
		<cfargument name="cachetimeout" type="numeric" required="no" default="#createtimespan(0,0,1,0)#">
		<cfset qmenu = "">
		
		<cfquery name="qmenu" datasource="#instance.datasource#" cachedwithin="#arguments.cachetimeout#">
			select 	dish.dishname, 
						dish.dishdescription,
						menudish.price,
						menudish.specialprice,
						menutype.menutype,
						dishtype.dishtypename
			from dishtype, menutype, dish, menudish
			where menudish.dishtypeid = dishtype.dishtypeid
			and menudish.dishid = dish.dishid
			and menudish.menutypeid = menutype.menutypeid
			and menudish.menudate = #createOdbcDate(arguments.menudate)#
			<cfif arguments.menutypeid is not "">
			and menutype.menutypeid = #val(arguments.menutypeid)#
			</cfif>
			and menudish.endtime is null
			order by menutype.menutypesortorder,dishtype.dishtypesortorder, dishname
		</cfquery>
		
		<cfreturn qmenu>
	
	</cffunction>

	
</cfcomponent>