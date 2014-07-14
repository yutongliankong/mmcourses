<cfquery name="qgetpages" datasource="acfd700-lab">
	select pagetitle,filename,page.directoryid,parentdirectoryid,directoryname, pageid, url, filename
	from directory inner join page
	on page.directoryid = directory.directoryid
	order by url,pagetitle
</cfquery>

<!--- walkthrough 10-2 --->


