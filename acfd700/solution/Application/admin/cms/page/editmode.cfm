


<cfset qpage = application.cfc.page.get(url.id)>
<cfset stLock = application.cfc.recordLock.set(type=url.type,id=url.id,lockholdername=session.user.name, lockholderid=session.user.contactid)>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Lock Page</title>
<script language="javascript">
	<cfif stLock.bStatus>
		<cfoutput>
		window.opener.location.href = '#left(application.basehref,len(application.basehref)-1)##qpage.url##qpage.filename#.cfm?edit=1';
		window.close();
		</cfoutput>
	</cfif>
	<cfif isdefined("form.btnCancel")>
		window.close();
	</cfif>
</script>
</head>

<body>

<cfif not stLock.bStatus>

	<cfif not isdefined("form.type")>
		<cfform>
			<cfinput type="hidden" name="type" value="#url.type#">
			<cfinput type="hidden" name="id" value="#url.id#">
			<cfoutput>
			<div align="center" style="font-family: Arial; font-size: 10px;">
			This page is currently locked by<br /><strong>#stLock.stLock.lockholdername#</strong><br />
			Would you like to be notified when the page becomes available for editing?<br />
			</cfoutput>
			<br />
			<cfinput type="submit" name="btnSubmit" value="Yes">
			<cfinput type="submit" name="btnCancel" value="No">
			</div>
		</cfform>
	<cfelse>
		<cfform>
			<cfinput type="hidden" name="type" value="#form.type#">
			<cfinput type="hidden" name="id" value="#form.id#">
			<cfoutput>
			<br /><br />
			<div align="center" style="font-family: Arial; font-size: 12px; font-weight: bold;">
				Trying to establish lock... Please stand by....
				<br/>
				Next check in <span id="counter">10</span> seconds
			</div>
			</cfoutput>
		</cfform>
		<script language="JavaScript">
			function updateCounter() {
				var nVal = parseInt(document.getElementById('counter').innerHTML);
				document.getElementById('counter').innerHTML = nVal - 1;
				if (nVal == 1) {
					document.forms[0].submit();
				} else {
					setTimeout("updateCounter()",1000);	
				}
			}
		
			setTimeout("updateCounter()",1000); /* check every ten seconds */
		</script>
	</cfif>
</cfif>

</body>
</html>
