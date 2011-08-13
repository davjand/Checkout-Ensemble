<?xml version="1.0" encoding="utf-8"?>
<!-- image-format.xsl
 * Takes an image data object and produces a html
 *	
 *
 * Author: David Anderson 2010
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">




<!-- general image -->
<!--*********************************************

##sample code

<xsl:call-template name="image">
	<xsl:with-param name="item" select=""/>
	<xsl:with-param name="width" select=""/>
	<xsl:with-param name="height" select=""/>
	<xsl:with-param name="alt" select="" />
</xsl:call-template>

-->
<xsl:template name="image">
	<xsl:param name="item"/>
	<xsl:param name="width" />
	<xsl:param name="height"/>
	<xsl:param name="alt" />
	<xsl:param name="crop" select="$item/crop"/>
	<xsl:param name="image" select="$item/image"/>	

	<!--format the image-->
	<img>
		<!--path-->
		<xsl:attribute name="src">
			<xsl:call-template name="image-path">
				<xsl:with-param name="mode" select="'crop'"/>
				<xsl:with-param name="file" select="$image/filename"/>
				<xsl:with-param name="path" select="$image/@path"/>		
				<xsl:with-param name="crop" select="$crop"/>
				<xsl:with-param name="width" select="$width"/>
				<xsl:with-param name="height" select="$height"/>
			</xsl:call-template>
		</xsl:attribute>
		
		<xsl:attribute name="width">
			<xsl:value-of select="$width"/>
		</xsl:attribute>
		
		<xsl:attribute name="height">
			<xsl:value-of select="$height"/>
		</xsl:attribute>
		
		<xsl:attribute name="alt">
			<xsl:value-of select="$alt" />		
		</xsl:attribute>
	</img>
	
</xsl:template>


<!-- generate a static image with jit resizing 
	*
	* Params:
	* src - path to image relative to workspace directory
	* path - path to the image, use if image is on another server
	* mode - mode of image. can be full, resize,  or crop. defaults to resize
	* width - desired width of the image
	* height - desired height of the image
	* alt - alt text for the image

##sample code

<xsl:call-template name="img">
	<xsl:with-param name="src" select=""/>
	<xsl:with-param name="path" select="" />
	<xsl:with-param name="width" select="''" />
	<xsl:with-param name="height" select="''"/>
	<xsl:with-param name="alt" />
	<xsl:with-param name="mode" select="'resize'"/>
</xsl:call-template>



**************************************************-->
<xsl:template name="img">
	<xsl:param name="src" select="'images/misc/image_coming_soon.jpg'"/>
	<xsl:param name="path" select="''" />
	<xsl:param name="width" select="''" />
	<xsl:param name="height" select="''"/>
	<xsl:param name="alt" />
	<xsl:param name="mode" select="'resize'"/>
	
	<img>
		<xsl:attribute name="alt">
			<xsl:value-of select="$alt"/>
		</xsl:attribute>
		<xsl:attribute name="title">
			<xsl:value-of select="$alt"/>
		</xsl:attribute>
		
		<xsl:if test="$height != ''">
			<xsl:attribute name="height">
				<xsl:value-of select="$height"/>
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="$width != ''">
		<xsl:attribute name="width">
			<xsl:value-of select="$width"/>
		</xsl:attribute>
		</xsl:if>
		
		<xsl:attribute name="src">
			<xsl:call-template name="image-path">
				<xsl:with-param name="mode" select="$mode"/>
				<xsl:with-param name="file" select="$src"/>
				<xsl:with-param name="path" select="$path"/>		
				<xsl:with-param name="width" select="$width"/>
				<xsl:with-param name="height" select="$height"/>
			</xsl:call-template>
		</xsl:attribute>
	
	</img>
		
		
	
</xsl:template>



<!--generate the path to the image with jit -->
<!--*********************************************-->
<xsl:template name="image-path">
	<xsl:param name="mode" select="'full'" /> <!-- full,resize,crop,resize-canvas -->
	<xsl:param name="file" select="'images/misc/image_coming_soon.jpg'" />
	<xsl:param name="path" select="''"/>
	
	<!-- resizing/cropping data -->
	<xsl:param name="crop" />
	<xsl:param name="width" select="0" />
    <xsl:param name="height" select="0" />
	
	<!--check the crop settings-->
	<xsl:variable name="real-mode">
		<xsl:choose>
			<xsl:when test="$mode='crop'">
				<xsl:choose>
					<xsl:when test="$crop/@cropped='yes'">
						<xsl:value-of select="'crop'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'resize'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$mode" />
			</xsl:otherwise>
		
		</xsl:choose>
	</xsl:variable>
	
	
	<!--add in jit manipulation-->

	<xsl:choose>
		<xsl:when test="$real-mode='resize'">
			<xsl:value-of select="concat( $root , '/image/1/' , $width , '/' , $height , '/0' , $path , '/' , $file)" />	
		</xsl:when>
		
		<xsl:when test="$real-mode='crop'">
			<xsl:value-of select="concat( $root , '/image/4/' , $crop/@width ,'/', $crop/@height ,'/', $crop/@x1 ,'/', $crop/@y1 ,'/', $width ,'/', $height ,'/0/', $path , '/' , $file)" />	
		</xsl:when>
		
		<xsl:when test="$real-mode='crop-fill'">
			<xsl:value-of select="concat( $root , '/image/2/' , $width ,'/', $height ,'/5/0/', $path , '/' , $file)" />	
		</xsl:when>
		
		<xsl:otherwise>
			<xsl:value-of select="concat($root , '/image/0' , $path , '/' ,$file )" />
		</xsl:otherwise>		
	</xsl:choose>


</xsl:template>

<!--generate css for a background image          -->
<!--*********************************************-->

<xsl:template name="bg-image-css">
	<xsl:param name="repeat" select="'no-repeat'" />
	<xsl:param name="position" select="'top left'" />
	<xsl:param name="item" />
	
	<!--make the string concat easier! -->
	<xsl:variable name="apos"><xsl:text>'</xsl:text></xsl:variable>
	
	<xsl:variable name="img-path">
		<xsl:call-template name="image-path-format" >
			<xsl:with-param name="node" select="$node" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:value-of select="concat( 'background: url(' ,$apos, $img-path ,$apos, ') ' , $repeat,' ',$position ,';' )" />	
</xsl:template>




</xsl:stylesheet>