<cfcomponent hint="Manipulate Menu">
	<cfproperty name="stMenu" displayname="Menu" hint="Menu items and their prices" type="struct">
	<cfset this.stMenu=structNew()>
	<cffunction name="ClearMenu">
		<cfset structClear(this.stMenu)>
		<cfreturn true>
	</cffunction>
</cfcomponent>
