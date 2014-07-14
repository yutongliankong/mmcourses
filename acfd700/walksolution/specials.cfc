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
	
	<cffunction name="dailySpecials_GetAsRSS" access="public" returntype="xml" output="false">
	
		<cfset var qspecials = dailySpecials_Get()>
		<cfset var xSpecials = "">
		
		<cfxml variable="xspecials" casesensitive="no">
			<?xml version="1.0"?>
			<rdf:RDF
					 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
					 xmlns="http://purl.org/rss/1.0/"
					 xmlns:dc="http://purl.org/dc/elements/1.1/"
					 xmlns:ag="http://purl.org/rss/1.0/modules/aggregation/"
					 xmlns:admin="http://webns.net/mvcb/"
					>
				<channel rdf:about="About Cafe Townsend">
				<title>About Cafe Townsend</title>
				<link>http://localhost/acfd700/menu/specials.cfm</link>
				<description>Cafe Townsend -  the best place for bits and bytes of the gastronomic persuasion</description>
				<cfoutput query="qspecials">
					<item rdf:about="http://localhost/displaydish.cfm?dishid=#qspecials.dishid#">
					<title>#xmlFormat(qspecials.dishname)#</title>
					<link>http://localhost/displaydish.cfm?dishid=#qspecials.dishid#</link>
					<description>#xmlFormat(qspecials.dishdescription)#</description>
					</item>
				</cfoutput>
				</channel>
			</rdf:RDF>
		</cfxml>
		
		<cfreturn xspecials>
		
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
		
		<cfset var xresult = dailySpecials_getAsXML()>

		<cfif hour(now()) lt 10>
			<cfset xresult=xmlSearch(xresult,"/restaurantspecials/menu[@type='Breakfast']")>
		<cfelseif hour(now()) lt 14>
			<cfset xresult=xmlSearch(xresult,"/restaurantspecials/menu[@type='Lunch']")>
		<cfelse>
			<cfset xresult=xmlSearch(xresult,"/restaurantspecials/menu[@type='Dinner']")>
		</cfif>

		<cfreturn xResult>
	</cffunction>
	

</cfcomponent>