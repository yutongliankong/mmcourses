<cfparam name="form.searchterm" default="">

<!--- publish to page --->
<cfif isdefined("form.btnSubmit") and arraylen(form.dgrid.key) gt 0>
	<cfloop from="1" to="#arraylen(form.dgrid.key)#" index="i">
		<cfset position = application.cfc.article.PagePositionGet(pageid = form.pageid, articleid = form.articleid)>
		<cfif form.mode is "before">
			<cfset position = position - 1>
		</cfif>
		<cfset application.cfc.article.pageBind(articleid = form.dgrid.key[i], pageid = form.pageid, sortorder = variables.position )>
	</cfloop>
	<script language="javascript">
		window.opener.location.href = window.opener.location.href;
		<cfoutput>
		alert("#arraylen(form.dgrid.key)# article(s) published to page.");
		</cfoutput>
	</script>
</cfif>

<cfif isdefined("form.pageid")>
	<cfset url.pageid = form.pageid>
	<cfset url.articleid = form.articleid>
	<cfset url.mode = form.mode>
</cfif>

<cfset stresults = application.cfc.article.veritysearch(form.searchterm)>
<cfset qdisplayhandlers = application.cfc.displayhandler.get()>



<!--- doesn't work in flash grid 
<cfset ldisplayhandlernames = ' ,' &  valuelist(qdisplayhandlers.displayhandlername)>
<cfset ldisplayhandlerids =  "0"  & valuelist(qdisplayhandlers.displayhandlerid)>
<cfset queryaddColumn(stresults.qresult,"displayhandlerid","varchar",arraynew(1))>
--->
<cfset queryaddColumn(stresults.qresult,"bselected","bit",arraynew(1))>


<cfparam name="url.pageid">
<cfparam name="url.articleid">
<cfparam name="url.mode">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Select Article for Publication</title>
</head>

<body>

<cfform format="flash">

<cfformgroup type="horizontal">
<cfinput type="text" name="searchterm" width="200" label="Search Term:">
<cfinput type="submit" name="btnSearch" value="Search">
</cfformgroup>

<cfinput type="hidden" name="pageid" value="#url.pageid#">
<cfinput type="hidden" name="articleid" value="#url.articleid#">
<cfinput type="hidden" name="mode" value="#url.mode#">

<cfgrid selectmode="edit" query="stresults.qresult" name="dgrid" rowheaders="no" height="280">

	<cfgridcolumn name="key" display="no">
	
	<!--- note: only works in java grid 
	<cfgridcolumn name="displayhandlerid"  values="#variables.lDisplayHandlernames#" valuesdisplay="#variables.ldisplayhandlerids#">
	--->
	
	<cfgridcolumn name="bselected" header="" width="27" type="boolean">
	<cfgridcolumn name="custom1" header="Last Updated" select="no">
	<cfgridcolumn name="author" header="Author" select="no">
	<cfgridcolumn name="title" header="Title" select="no">
	<cfgridcolumn name="summary" header="Summary" select="no">
	
</cfgrid>

<cfformgroup type="horizontal">
	<cfformitem type="spacer" />
	<cfinput type="submit" name="btnSubmit" value="Publish">
	<cfformitem type="spacer" />
</cfformgroup>
</cfform>

</body>
</html>
