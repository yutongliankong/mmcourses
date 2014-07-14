
<cfquery name="updatedates1" datasource="acfd700-lab">
	update menudish
	set menudate = '#dateformat(now(),"mm/dd/yyyy")#'
</cfquery>

<cfquery name="updatedates1" datasource="acfd700-solution">
	update menudish
	set menudate = '#dateformat(now(),"mm/dd/yyyy")#'
</cfquery>

<script language="JavaScript">
	alert("Function Complete");
</script>