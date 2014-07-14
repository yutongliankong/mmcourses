<cfcomponent>

	<!--- ----------------------------------------------------------------------------------------
	
		metadata_get :Returns metadata about component
	
	----------------------------------------------------------------------------------------- --->

	<!--- walkthrough 5-2 --->

	<!--- ----------------------------------------------------------------------------------------
	
		DailySpecials_Init : Bind Datasource to CFC methods
	
	----------------------------------------------------------------------------------------- --->
	
	<!--- walkthrough 5-3 --->
	
	<!--- ----------------------------------------------------------------------------------------
	
		DailySpecials_DefaultGet : Returns structures of component properties
	
	----------------------------------------------------------------------------------------- --->
	<cffunction name="DefaultGet" access="public" returntype="struct" output="false">
		<cfreturn instance>		
	</cffunction>
	
	<!--- ---------------------------------------------------------------------------------------
	
		DailySpecials_Get : Retrieve special menu items
	
	---------------------------------------------------------------------------------------- --->

	<cffunction name="dailySpecials_Get" access="public"  returntype="query" output="false">
		<cfargument name="datasource" required="yes">
		
		<cfset var qgetspecials = "">
		<cfquery name="qgetspecials" datasource="#arguments.datasource#">
			select dish.dishname, 
				   dish.dishid,
				   dish.dishDescription,
				   dishtype.dishtypename,
				   menutype.menutype,
				   menudish.price,
				   menudish.specialprice
				   
			
			from	dish, dishtype, menudish, menutype
			
			where  dish.dishtypeid = dishtype.dishtypeid
					  and menudish.dishid = dish.dishid
					  and menudish.menutypeid = menutype.menutypeid
					  and menudish.bspecial=1
			
			order by menutype.menutypesortorder, dishtype.dishtypesortorder
	
		</cfquery>
		
		<cfreturn qgetspecials>
	
	</cffunction>
	
	
	<!--- ---------------------------------------------------------------------------------------
	
		DailySpecials_GetAsRSS : Returns Specials as RSS XML
	
	---------------------------------------------------------------------------------------- --->
	
	
	<!--- ---------------------------------------------------------------------------------------
	
		DailySpecials_GetAsXML : Returns Specials as custom XML Packet
	
	---------------------------------------------------------------------------------------- --->
	<cffunction name="dailySpecials_GetAsXML" access="public" returntype="xml" output="false">
		
		<cfset var xresult = "">
		<cfset var qspecials = dailySpecials_Get()>
		
		<cfxml variable="xresult">
		  <restaurantspecials>
			<cfoutput query="qSpecials" group="menutype">
			<menu type="#qspecials.menutype#">
				<cfoutput group="dishtypename">
					<dishtype type="#qspecials.dishtypename#">
						<cfoutput>
							<dish>
								<name>#qspecials.dishname#</name>
								<price>#qspecials.specialprice#</price>
								<description>#qspecials.dishdescription#</description>
							</dish>
						</cfoutput>
					</dishtype>
				</cfoutput>
			</menu>
			</cfoutput>
			</restaurantspecials>
		</cfxml>
		
		<cfreturn xresult>
	
	</cffunction>

	<!--- ---------------------------------------------------------------------------------------
	
	    Walkthrough 8-4	
		DailySpecials_GetCurrentAsXML : Returns Specials based on current time of day
	
	---------------------------------------------------------------------------------------- --->
	


</cfcomponent>