<cfif isdefined("form.maintenancemode")>
   <cfset application.cfc.system.maintenancemodeset(maintenancemode = form.maintenancemode)>
</cfif>

<cfset stLocks = application.cfc.recordlock.get()>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>System Status</title>
</head>

<body leftmargin="0" topmargin="0">

<!--- invoke java.lang.runtime library --->
<cfset runtime = CreateObject("java","java.lang.Runtime")>

<div align="center">
<cfchart chartwidth="630" chartheight="320" format="flash" title="Server Memory Utilization (in megabytes)" show3d="yes">
	 <cfchartseries type="bar" serieslabel="yes">
	 	<cfchartdata item="Max Heap Size (MB)" value="#round(runtime.getRuntime().maxMemory() / 1000000)#">
		<cfchartdata item="Current Heap Size (MB)" value="#round(runtime.getRuntime().totalMemory() / 1000000)#">
		<cfchartdata item="Free Heap Size (MB)" value="#round(runtime.getRuntime().freeMemory() / 1000000)#">
	 </cfchartseries>
</cfchart>

<cfoutput>
<div style="font-family:Arial; font-size: 10px">
<table border="1" style="font-family:Arial, Helvetica, sans-serif; font-size:10px">
	<tr>
		<td>ColdFusion Version:</td>
		<td>#server.ColdFusion.ProductName# #server.ColdFusion.ProductVersion#</td>
	</tr>
	<tr>
		<td>ColdFusion License:</td>
		<td>#server.ColdFusion.ProductLevel#</td>
	</tr>
	<tr>
		<td>Operating System:</td>
		<td>#server.OS.Name# #server.OS.Version#</td>
	</tr>
</table>
</cfoutput>
<cfform>

<cfoutput>
<br />
There are currently #application.activesessions# active sessions. <br />
</cfoutput>

System Status: 
<cfinput type="radio" name="maintenancemode" value="0" checked="#iif(not application.maintenancemode,de(1),de(0))#">Online
<cfinput type="radio" name="maintenancemode" value="1" checked="#iif(application.maintenancemode,de(1),de(0))#">Offline</div>
<cfinput type="submit" value="Refresh" name="btnSubmit">
</cfform>

</div>



</body>
</html>
