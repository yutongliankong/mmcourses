<cfscript>
	qmenuchoices = querynew("Link,class,display");
	queryaddrow(qmenuchoices,1);
	querysetcell(qmenuchoices,"link","index.cfm",1);
	querysetcell(qmenuchoices,"class","navigation",1);
	querysetcell(qmenuchoices,"display","Cuisine",1);	
	queryaddrow(qmenuchoices,1);
	querysetcell(qmenuchoices,"link","about/chefipsum.cfm",2);
	querysetcell(qmenuchoices,"class","navigation",2);
	querysetcell(qmenuchoices,"display","Chef Ipsum",2);	
	queryaddrow(qmenuchoices,1);
	querysetcell(qmenuchoices,"link","news/index.cfm",3);
	querysetcell(qmenuchoices,"class","navigation",3);
	querysetcell(qmenuchoices,"display","Articles",3);
	queryaddrow(qmenuchoices,1);
	querysetcell(qmenuchoices,"link","about/specialevents.cfm",4);
	querysetcell(qmenuchoices,"class","navigation",4);
	querysetcell(qmenuchoices,"display","Special Events",4);
	queryaddrow(qmenuchoices,1);
	querysetcell(qmenuchoices,"link","about/menu.cfm",5);
	querysetcell(qmenuchoices,"class","navigation",5);
	querysetcell(qmenuchoices,"display","Menu",5);
	queryaddrow(qmenuchoices,1);
	querysetcell(qmenuchoices,"link","sitemap/index.cfm",6);
	querysetcell(qmenuchoices,"class","navigation",6);
	querysetcell(qmenuchoices,"display","Site Map",6);
	//Lab 7 - Step 2

</cfscript>
<!--- Lab 7: Step 20--->


