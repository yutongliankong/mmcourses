<!--- Walkthrough 11-2 --->

<cfset xNews = application.cfc.externalsystems.externalxml_getviahttp("http://p.moreover.com/page?o=rss002&c=Consumer:%20food%20and%20drink%20news")>
<cfdump var="#xNews#">