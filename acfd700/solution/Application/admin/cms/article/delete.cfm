
<cfparam name="url.articleid">

<cfset application.cfc.article.delete(articleid = url.articleid, updateuser=" ")>

<script language="javascript">
	window.opener.location.href = window.opener.location.href;
	window.close();
</script>