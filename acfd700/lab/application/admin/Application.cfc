<cfcomponent>

	<cffunction access="public" name="getProperties" returntype="struct" extends="mmcourses.acfd700.lab.application">
		<cfreturn getMetaData(this)>
	</cffunction>
	
</cfcomponent>