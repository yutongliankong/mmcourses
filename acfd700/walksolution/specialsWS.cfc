<cfcomponent>
	<cffunction name="dailySpecials_Get" access="private"  returntype="query" output="false">
		
		<cfset var qgetspecials = "">
		<cfquery name="qgetspecials" datasource="acfd700-lab">
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

	<!--- Walkthrough 10-2 --->	

</cfcomponent>