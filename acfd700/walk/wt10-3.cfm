<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

<cfForm>
	Search Google Through ColdFusion:
	<cfinput type="text" name="search" size="15">
	<cfinput type="submit" name="btnSubmit" value="Search">
</cfForm>

<cfif isdefined("form.search") or isdefined("url.search")>
	
	<cfobject component="search" name="cfcSearch">
	<cfset aresults = cfcSearch.googleSearch(searchquery = form.search)>
		
  <cfoutput>
	<ol style="font-family:Arial, Helvetica, sans-serif">
	<cfloop from="1" to="#arraylen(aresults)#" index="i">
		<li><a href="#aresults[i].url#">#aresults[i].title#</a>
		#paragraphformat(aresults[i].description)#
		</li>
	</cfloop>	
	</ol>	
 </cfoutput>
</cfif>
			 

</body>
</html>
