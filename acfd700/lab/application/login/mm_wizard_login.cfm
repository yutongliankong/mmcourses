
<cfparam name="loginmsg" type="string" default="Please Log In">

<html>
<body>
<head><title>Please Log In</title></head>
<body>

<!--- This is the login form, you can change the font and color etc but please keep the username and password input names the same --->
   <cfform  name="loginform" action="#CGI.script_name#?#CGI.query_string#" format="Flash"  width="300" height="300" preservedata="Yes">
   	<cfformgroup type="Panel" label="#loginmsg#">
     	
		<cfinput type="text" name="j_username" required="yes" message="A username is required" label="User Name:" width="100">
        <cfinput type="password" name="j_password" required="yes" message="A password is required" label="Password:" width="100">
		
		<cfformgroup type="horizontal">
		 	<cfinput type="submit" value="Log In" name="btnSubmitLogin">
		</cfformgroup>
		
	</cfformgroup>
   </cfform>
 </body>
</html>
