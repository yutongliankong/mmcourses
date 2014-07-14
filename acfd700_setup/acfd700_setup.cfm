<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<!--- NOTE: IF you have installed to a different path do a search and replace
	 	to match your path --->
		
<cfif IsDefined("form.submitted")>
    <!--- Action logic goes here --->
	<cfscript>
		//Check for proper admin password, Boolean returned
		adminobj = createObject("component", "CFIDE.adminapi.administrator").login(#form.adminpass#);
		if(NOT adminobj) //Unsuccessful login
		{
			WriteOutput("<h2>You did not login correctly, please recheck the password</h2>");
		}
		else //Successful login
		{

			//Create data sources
			db = structNew();
			db.name = "acfd700-lab";
			db.databasefile = "C:\CFusionMX7\wwwroot\mmcourses\acfd700\database\Acfd700-lab.mdb";
				
			obj = createObject("component","cfide.adminapi.datasource");
			obj.setMsAccessUnicode(argumentCollection=db);
			
			db = structNew();
			db.name = "acfd700-solution";
			db.databasefile = "C:\CFusionMX7\wwwroot\mmcourses\acfd700\database\Acfd700-solution.mdb";
				
			obj = createObject("component","cfide.adminapi.datasource");
			obj.setMsAccessUnicode(argumentCollection=db);

			//Create custom tag paths
			obj = createObject("component","cfide.adminapi.extensions");
			obj.setCustomTagPath("C:\CFusionMX7\wwwroot\mmcourses\acfd700\solution\Application\customtags");
			
			obj = createObject("component","cfide.adminapi.extensions");
			obj.setCustomTagPath("C:\CFusionMX7\wwwroot\mmcourses\acfd700\solution\Application\admin\cms\customtags");
			
			obj = createObject("component","cfide.adminapi.extensions");			
			obj.setCustomTagPath("C:\CFusionMX7\wwwroot\mmcourses\acfd700\lab\Application\customtags");
			
			obj = createObject("component","cfide.adminapi.extensions");			
			obj.setCustomTagPath("C:\CFusionMX7\wwwroot\mmcourses\acfd700\lab\Application\admin\cms\customtags");

		}
	</cfscript>
	
	<cfif adminobj><!--- Execute only if successful login --->
		
		<h3>The following data sources were created</h3>
		<h4>acfd700-lab</h4>
		<h4>acfd700-solution</h4>

		<h3>The following ColdFusion Custom Tag Paths were created</h3>
		<h4>C:\CFusionMX7\wwwroot\mmcourses\acfd700\solution\Application\customtags</h4>
		<h4>C:\CFusionMX7\wwwroot\mmcourses\acfd700\solution\Application\admin\cms\customtags</h4>
		<h4>C:\CFusionMX7\wwwroot\mmcourses\acfd700\lab\application\customtags</h4>
		<h4>C:\CFusionMX7\wwwroot\mmcourses\acfd700\lab\application\admin\cms\customtags</h4>

		
	</cfif>


<cfelse>
	<!--- Form goes here --->
	<form action="<cfoutput>#CGI.script_name#?#CGI.query_string#</cfoutput>" method="post">
          <!--- Form controls go here --->
		  <em><strong>
			  This page configures a data source and custom tag mappings.<p><p>
			  If you use a password on your ColdFusion administrator please enter it here. If you do not use an 
			  administrator's password just leave the input blank<p><p>
			  THE PAGE WILL TAKE A FEW MINUTES BEFORE IT COMPLETES ITS TASKS.  BE PATIENT!<p><p>
		  </strong></em>	         
		 
		 ColdFusion Administrator Password: <input name="adminpass" type="password"><p>
		 
		 <br>
		 <input type="hidden" name="submitted">
         <input type="submit" name="submit" value="Configure">
     </form>
</cfif>

</body>
</html>
