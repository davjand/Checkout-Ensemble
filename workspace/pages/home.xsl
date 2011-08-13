<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- ********************************* -->
<!-- javascript init -->
<!-- ********************************* -->
<xsl:template name="init-page-js"> 
	<!--init the carousel-->
	<xsl:call-template name="js-init-carousel">
		<xsl:with-param name="wrapper-id" select="'#home-carousel'"/>
		<xsl:with-param name="duration" select="'7000'" />
	</xsl:call-template>
</xsl:template>



<!-- ********************************* -->
<!-- includes -->
<!-- ********************************* -->
<xsl:include href="../utilities/master.xsl" />

<!-- ********************************* -->
<!-- data root -->
<!-- ********************************* -->
<xsl:template match="/data">
	
</xsl:template>


<!-- ********************************* -->
<!-- template positions -->
<!-- ********************************* -->


</xsl:stylesheet>