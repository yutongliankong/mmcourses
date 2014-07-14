<cfcomponent hint="Support functions for Restaurant Daily Menu Specials">

	<!--- ----------------------------------------------------------------------------------------
	
		metadata_get :Returns metadata about component
	
	----------------------------------------------------------------------------------------- --->

	<cffunction name="metadata_Get" returntype="struct" access="public" hint="Returns metadata about component">
	
		<cfreturn getMetadata(this)>
	
	</cffunction>

	<!--- ----------------------------------------------------------------------------------------
	
		DailySpecials_Init : Bind Datasource to CFC methods
	
	----------------------------------------------------------------------------------------- --->
	
	<cffunction name="init" access="public" returntype="Specials"  output="false">
		<cfargument name="dsn" required="yes" type="string" hint="Datasource for data">
		
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
		<cfreturn this>
		
	</cffunction>
	
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
		
		<cfset var qgetspecials = "">
		<cfquery name="qgetspecials" datasource="#instance.datasource#">
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
	
	<cffunction name="dailySpecials_getAsRss" access="Public" returntype="XML" output="False">

		<cfset var qSpecials = dailySpecials_Get()>
		<cfset var xSpecials = "">
		
		<cfxml variable="xSpecials" casesensitive="no">
			<?xml version="1.0" encoding="UTF-8"?>
			<rdf:RDF 
			xmlns="http://purl.org/rss/1.0/" 
			xmlns:admin="http://webns.net/mvcb/" 
			xmlns:ag="http://purl.org/rss/1.0/modules/aggregation/" 
			xmlns:dc="http://purl.org/dc/elements/1.1/" 
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
			
			<channel rdf:about="About Cafe Townsend">
			<title>About Cafe Townsend</title>
			<link>http://localhost:8500/mmcourses/acfd700/solution/Application/about/menu.cfm</link>
			<description>
			Cafe Townsend -  the best place for bits and bytes of the gastronomic persuasion
			</description>
			
			<cfoutput query="qSpecials">
			<item rdf:about="http://localhost:8500/mmcourses/acfd700/solution/Application/about/displaydish.cfm?dishid=#qSpecials.dishid#">
			<title>#xmlFormat(qSpecials.DishName)#</title>
			<link>http://localhost:8500/mmcourses/acfd700/solution/Application/about/displaydish.cfm?dishid=#qSpecials.dishid#</link>
			<description>
			#xmlFormat(qSpecials.DishDescription)#
			</description>
			</item>
			</cfoutput>
							
			</channel>
			</rdf:RDF>
		
		</cfxml>
	
		<cfreturn xSpecials>
	
	</cffunction>



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
	
		DailySpecials_GetCurrentAsXML : Returns Specials based on current time of day
	
	---------------------------------------------------------------------------------------- --->
	
	<cffunction name="dailySpecials_GetCurrentAsXML" access="public" returntype="array" output="true">
		
		<cfset var xSpecials = dailySpecials_getAsXML()>

		<cfif hour(now()) lt 10>
			<cfset xSpecials=xmlSearch(xresult,"/restaurantspecials/menu[@type='Breakfast']")>
		<cfelseif hour(now()) lt 14>
			<cfset xSpecials=xmlSearch(xresult,"/restaurantspecials/menu[@type='Lunch']")>
		<cfelse>
			<cfset xSpecials=xmlSearch(xresult,"/restaurantspecials/menu[@type='Dinner']")>
		</cfif>

		<cfreturn xSpecials>
	</cffunction>
	

</cfcomponent>