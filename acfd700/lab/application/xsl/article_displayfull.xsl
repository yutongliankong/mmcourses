<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <xsl:for-each select="articles/article">
		<div class="articledisplayfull">
    		<div class="italicsbold"><xsl:value-of select="title"/></div>
      		<div class="main"><xsl:value-of select="fulltext"/></div>
		</div>
     </xsl:for-each>
</xsl:template>
</xsl:stylesheet>