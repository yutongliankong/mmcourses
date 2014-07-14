<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   <xsl:template match="/">
      <xsl:apply-templates select="rss" />
   </xsl:template>


   <xsl:template match="rss">
      <xsl:if test="@version != '2.0'">
         <div id="error">
            Unrecognized RSS feed version.</div>
      </xsl:if>
      <xsl:if test="@version = '2.0'">
         <xsl:apply-templates select="channel" />
      </xsl:if>
   </xsl:template>
 

   <xsl:template match="channel">
      <div id="feed" style="width:300px; height:300px; overflow:auto">
         <a>
            <xsl:attribute name="href">
               <xsl:value-of select="link" />
            </xsl:attribute>
            <xsl:attribute 
                name="target">_blank</xsl:attribute>
            <h2>
               <xsl:value-of select="title" />
            </h2>
         </a>
         <br />

         <div style="font-size: x-small">
            <xsl:value-of select="copyright" />
         </div>
         <br />

         <div id="items">
            <xsl:apply-templates select="item" />
         </div>
      </div>
   </xsl:template>

   <xsl:template match="item">
     <xsl:if test="contains(title, 'organic')">
      <div>
         <a>
            <xsl:attribute 
               name="target">_blank</xsl:attribute>
            <xsl:attribute name="href">
               <xsl:value-of select="link" />
            </xsl:attribute>
            <xsl:value-of select="title" />
         </a>
         <br />
         <xsl:value-of select="description" />
      </div>
	  <br />
	  </xsl:if>
   </xsl:template>
</xsl:stylesheet>
