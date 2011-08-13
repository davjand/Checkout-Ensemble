<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- carousel.xsl	
 * 
 * Carousel template and associated functions for decor blinds website
 *
 * Author: David Anderson 2010
-->

<xsl:template match="data/slides">
	<xsl:param name="item" />
	<xsl:param name="width" select="'780'"/>
	<xsl:param name="height" select="'300'"/>
	<xsl:param name="id-prefix" select="'carousel-'"/>
	
	<div class="carousel-wrapper-inner">
		<xsl:attribute name="style">
			<xsl:text>width:</xsl:text><xsl:value-of select="$width"/><xsl:text>px;</xsl:text>
			<xsl:text>height:</xsl:text><xsl:value-of select="$height"/><xsl:text>px;</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="id">
			<xsl:value-of select="concat($id-prefix,'inner')"/>
		</xsl:attribute>

		<xsl:apply-templates select="entry" mode="slides" >
			<xsl:with-param name="width" select="$width"/>
			<xsl:with-param name="height" select="$height"/>
			<xsl:with-param name="id-prefix" select="$id-prefix"/>
		</xsl:apply-templates>	
	</div>
	
	<div class="carousel-controller">	
		<xsl:attribute name="id">
			<xsl:value-of select="concat($id-prefix,'controller')"/>
		</xsl:attribute>
		
		<ul>
			<!--
			<li><a href="#" class="pause">pause</a></li>
			
			<li><a href="#" class="prev">&lt;&lt;</a></li>
			-->
			<xsl:apply-templates select="entry" mode="controller" />
			<!--
			<li><a href="#" class="next">&gt;&gt;</a></li>			
			-->
			
		</ul>
		<div class="clear"></div>
	</div>
	

</xsl:template>

<xsl:template match="data/slides/entry" mode="controller">
	<li>
		<xsl:attribute name="class"><xsl:text>slide-no</xsl:text></xsl:attribute>
		<a href="#">
			<xsl:attribute name="class"><xsl:value-of select="concat('s',position())"/></xsl:attribute>

			<xsl:value-of select="short-title"/>
		</a>
	</li>
	
	<xsl:if test="position() &lt; count(../entry)">
		<li class="sep">
			&gt;
		</li>
	</xsl:if>
	
</xsl:template>


<xsl:template match="data/slides/entry" mode="slides">
	<xsl:param name="width"/>
	<xsl:param name="height"/>
	<xsl:param name="id-prefix"/>
	
	<div class="slide">
		<xsl:attribute name="id"><xsl:value-of select="concat($id-prefix,position())" /></xsl:attribute>
	
		<div class="slide-image">
			<xsl:call-template name="image">
				<xsl:with-param name="item" select="."/>
				<xsl:with-param name="width" select="$width" />
				<xsl:with-param name="height" select="$height"/>
				<xsl:with-param name="alt" select="title" />
			</xsl:call-template>
		</div>
		
		<div class="slide-content">
			<h1>
				<a href="{link}">
					<xsl:value-of select="title"/>
				</a>
			</h1>
			<p>
				<a href="{link}">
					<b><xsl:value-of select="description"/></b>
				</a>
			</p>
		</div>
		
		
	</div>	
</xsl:template>
	
	
	
	
</xsl:stylesheet>