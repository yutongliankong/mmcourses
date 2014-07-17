<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<!--- Walkthrough 7-1 --->
<cfscript>
	function query2array(qdata){
		var rc = qdata.recordcount;
		var collist = qdata.columnlist;
		var i = 1;
		var j = 1;
		var thiscolumn = "";
		var stdata = structNew();
		var collistlength = listLen(collist);
		var aresult = arrayNew(1);

		for(i = 1; i le rc; i = i + 1){
			stdata = structNew();
			for(j = 1; j le collistlength; j = j + 1){
				thiscolumn = listGetAt(collist,j);
				stdata[thiscolumn] = qdata[thiscolumn][i];
			}
			arrayAppend(aresult, stdata);
		}
		return aresult;
	}

</cfscript>

<cfscript>
	qnames = querynew("firstname,lastname");

	queryaddrow(qnames,2);

	querysetcell(qnames,"firstname","Steve",1);
	querysetcell(qnames,"lastname","Drucker",1);
	
	querysetcell(qnames,"firstname","Dave",2);
	querysetcell(qnames,"lastname","Watts",2);

</cfscript>

<cfdump var="#query2array(qnames)#">



</body>
</html>
