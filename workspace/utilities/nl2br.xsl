<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Example:

	<xsl:call-template name="nl2br">
		<xsl:with-param name="string" select="body"/>
	</xsl:call-template>
	
	modified to allow a limit of replaces, after the limit is replaced, the string is truncated
-->

<xsl:template name="nl2br">
	<xsl:param name="string"/>
	<xsl:param name="limit"/>
	<xsl:param name="count" select="'1'"/>
	<xsl:value-of select="normalize-space(substring-before($string,'&#10;'))"/>
	<xsl:choose>
		<xsl:when test="contains($string,'&#10;')">
			<br />
			<xsl:choose>
				<xsl:when test="$limit">
					<xsl:if test="$count &lt; $limit">
						<xsl:call-template name="nl2br">
							<xsl:with-param name="string" select="substring-after($string,'&#10;')"/>	
							<xsl:with-param name="limit" select="$limit"/>
							<xsl:with-param name="count" select="$count + '1'"/>			
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="nl2br">
						<xsl:with-param name="string" select="substring-after($string,'&#10;')"/>				
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$string"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>