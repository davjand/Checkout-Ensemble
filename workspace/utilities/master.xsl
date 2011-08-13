<?xml version="1.0" encoding="UTF-8"?>
<!-- master.xsl
 * 
 * Master xsl file for Symphony template 	
 *
 * Author: David Anderson 2010
 * dave@veodesign.co.uk
-->

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:date="http://exslt.org/dates-and-times"
		xmlns:exsl="http://exslt.org/common"
		xmlns:form="http://nick-dunn.co.uk/xslt/form-controls"
		extension-element-prefixes="exsl form date">

<xsl:output method="xml"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    indent="yes" />

<!-- ********************************* -->
<!-- includes -->
<!-- ********************************* -->

<!-- symphony utils -->
<xsl:include href="typography.xsl"/>
<xsl:include href="html-truncate.xsl"/>
<xsl:include href="date-time.xsl"/>

<!--custom utils-->
<xsl:include href="header.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="page-title.xsl"/>
<xsl:include href="image-format.xsl"/>
<xsl:include href="navigation.xsl"/>
<xsl:include href="nl2br.xsl"/>
<xsl:include href="pricing-utils.xsl"/>



<!-- js -->
<xsl:include href="../js/init-js.xsl"/>


<!-- ********************************* -->
<!-- global variables -->
<!-- ********************************* -->


<!-- ********************************* -->
<!-- root template -->
<!-- ********************************* -->

<xsl:template match="/">
<html>
<head>
	
	<!-- TITLE -->
	<title>
		<xsl:apply-templates select="/data"  mode="site-title"/>
	</title>
	
	<link rel="shortcut icon" type="image/x-icon" href="{$workspace}/favicon.ico" />
	
	<!-- META -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="robots" content="index, follow" />
	<meta name="description" content="{//data/settings/entry/site-description}"/>

	<!-- 960 GRID -->
   	<link rel="stylesheet" media="screen" href="{$workspace}/css/reset.css" type="text/css"/>
	<link rel="stylesheet" media="screen" href="{$workspace}/css/960.css" type="text/css"/>
    
    <!-- CSS -->
    <link rel="stylesheet" media="screen" href="{$workspace}/css/typography.css" type="text/css"/>
	<link rel="stylesheet" media="screen" href="{$workspace}/css/main.css" type="text/css"/>
	
	<!--COLORBOX-->
    <link rel="stylesheet" media="screen" href="{$workspace}/css/colorbox.css" type="text/css"/>
    
	<meta name="google-site-verification" content="" />
	
    <!--JS -->
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>    
	<script type="text/javascript">
		google.load("jquery", "1.4.2");
		google.load("jqueryui", "1.8.4");
		google.load('maps', '3', {other_params:'sensor=false'}); 

	 	google.setOnLoadCallback(function() {
			<xsl:call-template name="init-page-js" />	
					
	  	});
	</script>
	<script type="text/javascript" src="{$workspace}/js/jquery.scrollTo-1.4.2-min.js"></script>
	<script type="text/javascript" src="{$workspace}/js/javascript.js"></script>
	<script type="text/javascript" src="{$workspace}/js/jquery.timers-1.2.js"></script>
	<script type="text/javascript" src="{$workspace}/js/jquery.colorbox-min.js"></script>
	<script type="text/javascript" src="{$workspace}/js/jquery.plugins.js"></script>	
	<script type="text/javascript" src="{$workspace}/js/jquery.scrollfollow.js"></script>

</head>

<body>
<div id="bg">
	<xsl:call-template name="header" />
	
	<div id="wrapper">
		<div class="container_16">
					
			<xsl:apply-templates match="data" />
			
			<div class="clear"></div>
			
		</div>
	</div>
	
	<div class="container_16">
		<xsl:call-template name="footer" />	
	</div>
	
</div><!-- #bg -->


</body>
</html>        	
                
</xsl:template>


</xsl:stylesheet>