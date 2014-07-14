<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cf="http://www.macromedia.com/2004/cfform" 
xmlns:xf="http://www.w3.org/2002/xforms" 
xmlns:html="http://www.w3.org/1999/xhtml" 
exclude-result-prefixes="xsi cf xsl xf html">
	
	<xsl:output method="html"/>
	
	<xsl:template match="/">
	
		<xsl:element name="script"> 
			<xsl:attribute name="src">
				<xsl:text>treemenu/ua.js</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="language">
				<xsl:text>JavaScript</xsl:text>
			</xsl:attribute>
			<xsl:text> </xsl:text>
		</xsl:element>

		<xsl:element name="script"> 
			<xsl:attribute name="src">
				<xsl:text>treemenu/ftiens4.js</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="language">
				<xsl:text>JavaScript</xsl:text>
			</xsl:attribute>
			<xsl:text>alert();</xsl:text>
		</xsl:element>
		
		<xsl:element name="script">
			<xsl:attribute name="language">
				<xsl:text>JavaScript</xsl:text>
			</xsl:attribute>
			<xsl:text>
			ICONPATH="treemenu/";
			USETEXTLINKS = 1;
			STARTALLOPEN = 0;
			USEFRAMES = 0;
			USEICONS = 1;
			WRAPTEXT = 1;
			PRESERVESTATE = 1;
			BUILDALL=0;
			
			foldersTree = gFld("Cafe Townsend");
			foldersTree.treeID = "sitemapTree";
			
			</xsl:text>
		</xsl:element>
		
		<xsl:element name="style">
		<xsl:text>
		   SPAN.TreeviewSpanArea A {
				font-family: Verdana, Arial, Helvetica, sans-serif;
				font-size: 11px;
				line-height: 18px;
				color: #006633;
				text-decoration: none;
		   }
		   SPAN.TreeviewSpanArea A:hover {
				text-decoration: underline;
  		   }
		</xsl:text>
		</xsl:element>
	
		<xsl:element name="script">
			<xsl:attribute name="language">
				<xsl:text>JavaScript</xsl:text>
			</xsl:attribute>
			<xsl:for-each select="cf:tree">
				<xsl:call-template name="menu"/>
			</xsl:for-each>
		</xsl:element>
		
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:text>TreeviewSpanArea</xsl:text>
			</xsl:attribute>
			<xsl:element name="script">
				<xsl:attribute name="language">
					<xsl:text>JavaScript</xsl:text>
				</xsl:attribute>
				<xsl:text>initializeDocument();</xsl:text>
			</xsl:element>
		</xsl:element>
		
	</xsl:template>

	<xsl:template name="menu">	
			<xsl:for-each select="node">
				<xsl:call-template name="treenode"/>
			</xsl:for-each>
	</xsl:template>

	<xsl:template name="treenode">
		<xsl:text>aux_</xsl:text>
		<xsl:value-of select="@value"/>
		<xsl:text>=insFld(</xsl:text>
		
		<xsl:if test="@parent='DIR_'">
			<xsl:text>foldersTree</xsl:text>
		</xsl:if>
		
		<xsl:if test="@parent!='DIR_'">
			<xsl:text>aux_</xsl:text>
			<xsl:value-of select="@parent"/>
		</xsl:if>
		
		<xsl:if test="contains(@value,'DIR')">
			<xsl:text>,gFld("</xsl:text>
		</xsl:if>
		<xsl:if test="contains(@value,'PAGE')">
			<xsl:text>,gLnk('R',"</xsl:text>
		</xsl:if>
		
		<xsl:value-of select="@display"/>
		<xsl:text>","</xsl:text>
		<xsl:value-of select="@href"/>
		<xsl:text>")); </xsl:text>	
		
		<xsl:if test="node">
				<xsl:for-each select="node">
					<xsl:call-template name="treenode"/>
				</xsl:for-each>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
