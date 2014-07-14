<!--- lab 11 --->


<cfset xNews = application.cfc.article.getAsRSS()>

<cfsetting showdebugoutput = "No">

<cfcontent type="text/xml">

<cfoutput>#toString(xNews)#</cfoutput>
