<cfquery name="qgetpages" datasource="acfd700-lab">
	select pagetitle,filename,page.directoryid,parentdirectoryid,directoryname, pageid, url, filename
	from directory inner join page
	on page.directoryid = directory.directoryid
	order by url,pagetitle
</cfquery>

<cfset basehref = left(application.basehref,len(application.basehref) - 1)>

<!--- walkthrough 10-2 --->

<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="Site Map">

<cfform  type="xml" skin="beige"> 
	<cftree  name="sitemap" format="xml">
		<cfoutput query="qgetpages" group="url">
			<cftreeitem
				display="#qgetpages.directoryname#" 
				parent="DIR_#qgetpages.parentdirectoryid#" 
				value="DIR_#qgetpages.directoryid#" href="#variables.basehref##qgetpages.url#">
			<cfoutput>
				<cftreeitem
					display="#qgetpages.pagetitle#" 
					parent="DIR_#qgetpages.directoryid#" 
					value="PAGE_#qgetpages.pageid#" href="#variables.basehref##qgetpages.url##qgetpages.filename#.cfm">
			</cfoutput>
		</cfoutput>
	</cftree>
</cfform> 


<cffile action="read" file="#expandpath('.')#\_cftree_menu.xsl"  variable="xsl">

<!-- Removing this link will make the script stop from working -->
<table border=0><tr><td><font size=-2><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target=_blank>JavaScript Tree Menu</a></font></td></tr></table>

<!--- output tree here --->
<cfoutput>#xmltransform(sitemap,xsl)#</cfoutput>


</cfmodule>

