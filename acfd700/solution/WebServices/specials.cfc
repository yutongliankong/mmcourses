<cfcomponent extends="mmcourses.acfd700.solution.components.specials">

	<cffunction access="remote" name="dailySpecials_GetasArray" output="false" returntype="array">
			
		<cfreturn  application.cfc.toolbox.query2array(dailySpecials_Get())>	
	
	</cffunction>

</cfcomponent>