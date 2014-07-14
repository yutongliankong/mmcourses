<!--- lab 11 --->

<cfset xNews = application.cfc.Article.getAsRSS()>
 
<cfsetting showdebugoutput="no">
<cfcontent type="text/xml">
<cfoutput>#tostring(xNews)#</cfoutput>
