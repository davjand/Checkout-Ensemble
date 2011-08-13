<?xml version="1.0" encoding="UTF-8"?>
<!-- 
About:
============
Author: Will Nielsen
Version: 1.0
Date: 23 October 2009
Email: will@nielsendigital.com
Web: http://nielsendigital.com

Instructions:
=============
 1. Download and install the reCaptcha Extension (http://github.com/pointybeard/recaptcha/tree)
 2. Create a utility which includes this code
 3. Import that utility (e.g., <xsl:import href="../utilities/get-recaptcha.xsl" /> into the templates you wish to use.
 4. Call the template "recaptcha-field" with optional params in place of Step #8 in the reCaptcha Extension 1.0 README

Params
=============
tabindex: integer value (default: 10)
theme: string red | white (default) | blackglass | clean | custom


 -->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="recaptcha-field">
	<xsl:param name="tabindex" select="'10'" />
	<xsl:param name="theme" select="'white'" />
		<div id="recaptcha" >
			<xsl:if test="/data/events/register/filter/@name = 'recaptcha'" >
				<xsl:attribute name="class">correction</xsl:attribute>
			</xsl:if>
			<script type="text/javascript">
				var RecaptchaOptions = {
				theme : '<xsl:value-of select="$theme"/>',
				tabindex : <xsl:value-of select="$tabindex"/>
				};				
		    </script>
			<script type="text/javascript"
				src="http://api.recaptcha.net/challenge?k={/data/recaptcha}"></script>
		</div>
	</xsl:template>
</xsl:stylesheet>