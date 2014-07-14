<cfcomponent extends="mmcourses.acfd700.solution.application">
	<cffunction access="public" name="getProperties" returntype="struct">
		<cfreturn getMetaData(this)>
	</cffunction>
</cfcomponent>