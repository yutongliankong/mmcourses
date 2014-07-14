<cfset stStatus = application.cfc.recordlock.set(url.type,url.id,session.user.name,session.user.contactid)>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Keep Lock Alive</title>
	<script language="JavaScript">
	  <cfif stStatus.bstatus>
		function fnRefresh() {
			location.href = location.href;
		}
		function fnUpdate() {
			var obj = document.getElementById('lockview');
			nval = parseInt(obj.innerHTML);
			nval--;
			obj.innerHTML = nval;
			if (nval == 0) {
				fnRefresh();
			}
		}
		setInterval("fnUpdate()",1000); /* refresh every 1 seconds, countdown from 30 */
	  <cfelse>
	  	alert("Record Lock Lost!");
	  </cfif>
	</script>
	
</head>

<body>

<div align="center" style="font-family:Arial; font-size: 12px; font-weight:bold;">
The record will be relocked in 
<span id="lockview">30</span> seconds</div>


</body>
</html>
