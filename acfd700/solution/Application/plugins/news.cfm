

<cftry>
  <cfset xNews = application.cfc.ExternalSystems.ExternalXML_GetViaHTTP()>
  <cfcatch type="any">
  
  </cfcatch>
</cftry>

<cffile action="read" 
	file="#application.installdir#xsl\rss_display_organicNews.xsl" 
	variable="thisXSL">

<cfset Result = xmlTransform(xNews,thisxsl)>

<cfoutput>#variables.result#</cfoutput>

