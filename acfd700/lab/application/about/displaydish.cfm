<cfparam name="url.dishid" default="2">

<cfquery name="qGetDish" datasource="#application.datasource#">
	SELECT 
		Dish.DishName, 
		Dish.DishDescription, 
		DishType.DishTypeName, 
		MenuDish.Price
	FROM 
		(DishType INNER JOIN Dish ON DishType.DishTypeId = Dish.DishTypeID) 
		INNER JOIN MenuDish ON (DishType.DishTypeId = MenuDish.DishTypeID) AND (Dish.DishID = MenuDish.DishID)
	WHERE 
		Dish.DishID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.dishid#">
</cfquery>

<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="Display Dish">

<cfoutput>
	<div class="menu_title">#qGetDish.dishtypename#</div>
 	<div class="menu" align="center"><em>#qGetDish.dishname# - #qGetDish.price#</em><br />
			#paragraphformat(qGetDish.DishDescription)#
	</div>
</cfoutput>

</cfmodule>

