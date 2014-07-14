<!--- Walkthrough 11-1 --->
<cfset xSpecials = Application.cfc.specials.dailySpecials_GetAsRss()>
<cfsetting showdebugoutput="No"> 
<cfcontent type="text/html"><cfoutput>#toString(xSpecials)#</cfoutput>


