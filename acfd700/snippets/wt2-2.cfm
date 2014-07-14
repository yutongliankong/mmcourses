
<cfset application.datasource = trim(getProfileString(inipath,"Global","datasource"))>
<cfset application.installdir = trim(getProfileString(inipath,"Global","installdir"))>
<cfset application.lAdministratorIPs = trim(getProfileString(inipath,"Global","lAdministratorIPs"))>
<cfset application.cfcpath = trim(getProfileString(inipath,"Global","cfcpath"))>
<cfset application.basepath = left(getDirectoryFromPath(inipath),len(getDirectoryFromPath(inipath))-1) & "application\">
<cfset application.verityarticlecollection =  trim(getProfileString(inipath,"Verity","articles"))>
<cfset application.veritypagecollection =  trim(getProfileString(inipath,"Verity","pages"))>