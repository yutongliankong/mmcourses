<cfparam name="url.pageid">
<cfparam name="url.articleid">
<cfparam name="url.mode">

<cfset application.cfc.article.articlepagereorder(pageid = url.pageid, articleid = url.articleid, mode = url.mode)>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Move Article</title>
<script language="javascript">
	window.opener.location.href = window.opener.location.href;
	window.close();
</script>
</head>

<body>
</body>
</html>
