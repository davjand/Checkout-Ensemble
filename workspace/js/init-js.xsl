<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--  initjs.xsl
 *
 * templates to allow dynamic javascript injection
 *
 * Author: David Anderson 2010
 * dave@veodesign.co.uk
-->

<!-- carousel -->
<xsl:template name="js-init-carousel">
	<xsl:param name="id-prefix" select="'carousel-'"/>
	<xsl:param name="duration" select="'8000'"/>
	
	<xsl:text>
		$(document).ready(function() {
			//params
			var idPrefix='</xsl:text><xsl:value-of select="$id-prefix"/><xsl:text>';
			var duration=</xsl:text><xsl:value-of select="$duration"/><xsl:text>;
			
			initCarousel(idPrefix,duration);
		});
	</xsl:text>


</xsl:template>


</xsl:stylesheet>