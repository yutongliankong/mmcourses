<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" omit-xml-declaration="yes"/>

<xsl:template match="/">
    <xsl:for-each select="articles/article">
		<div class="articledisplayteaser">
    		<div class="title"><xsl:value-of select="title"/></div>
      		<div class="teaser"><xsl:value-of select="teaser"/></div>
		</div>
     </xsl:for-each>
</xsl:template>
</xsl:stylesheet>