<?xml version="1.0" encoding="UTF-8"?>
<!--page-title.xsl
 *
 * Generate a page title 
 *
 * Author: David Anderson 2010
 * dave@veodesign.co.uk
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="data" mode="site-title" priority="-1">

	<!--see what the page title is-->
	<xsl:choose>
		<xsl:when test="$page-title='Home'">
			<xsl:value-of select="$site-title" />
			<xsl:text> - Homepage </xsl:text>
		</xsl:when>
		
		<xsl:when test="$page-title='Product'">
			<xsl:value-of select="//data/pi-product/entry/title" />
			<xsl:text> - </xsl:text>		
			<xsl:value-of select="$site-title" />
		</xsl:when>
		
		
		<!--otherwise nothing found -->
		
		<xsl:otherwise>
			<xsl:value-of select="$page-title" />
			<xsl:text> - </xsl:text>		
			<xsl:value-of select="$site-title" />
		</xsl:otherwise>
	
	</xsl:choose>

</xsl:template>

</xsl:stylesheet>