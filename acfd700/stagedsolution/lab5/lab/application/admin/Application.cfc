<cfcomponent extends="mmcourses.acfd700.lab.Application">

	<cffunction access="public" name="getProperties" returntype="struct">
		<cfreturn getMetaData(this)>
	</cffunction>
	
</cfcomponent>