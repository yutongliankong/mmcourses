<!--- Walkthrough 7-5--->
<cfset runtime = CreateObject("java","java.lang.Runtime")>
<cfoutput>
<h1>System Memory Status</h1>
Heap Max size: #numberformat(runtime.getRuntime().maxMemory())# 
<br />
Current Heap:#numberformat(runtime.getRuntime().totalMemory())# <br />
Free Heap: #numberformat(runtime.getRuntime().freeMemory())# 
<br />
</cfoutput>
<cfdump var="#runtime#">