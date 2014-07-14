<cfcomponent>

	<cffunction access="public" name="getProperties" returntype="struct">
		<cfreturn getMetaData(this)>
	</cffunction>
	
</cfcomponent>