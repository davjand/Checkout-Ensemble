<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str">

<!--
Name: E-mail Obfuscator
Version: 0.1
Author: Nick Dunn <nick@nick-dunn.co.uk>
URL: http://symphony-cms.com/downloads/xslt/file/20574/

Parameters:
* email (required) an e-mail address
-->

<xsl:template name="obfuscate-email">
	<xsl:param name="email"/>
	
	<xsl:variable name="encoded">
	<xsl:for-each select="str:tokenize(translate($email,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')">
		<xsl:text>&amp;#</xsl:text>
		<xsl:choose>
			<xsl:when test="text()='a'">x0061</xsl:when>
			<xsl:when test="text()='b'">x0062</xsl:when>
			<xsl:when test="text()='c'">x0063;</xsl:when>
			<xsl:when test="text()='d'">x0064</xsl:when>
			<xsl:when test="text()='e'">x0065</xsl:when>
			<xsl:when test="text()='f'">x0066</xsl:when>
			<xsl:when test="text()='g'">x0067</xsl:when>
			<xsl:when test="text()='h'">x0068</xsl:when>
			<xsl:when test="text()='i'">x0069</xsl:when>
			<xsl:when test="text()='j'">x006a</xsl:when>
			<xsl:when test="text()='k'">x006b</xsl:when>
			<xsl:when test="text()='l'">x006c</xsl:when>
			<xsl:when test="text()='m'">x006d</xsl:when>
			<xsl:when test="text()='n'">x006e</xsl:when>
			<xsl:when test="text()='o'">x006f</xsl:when>
			<xsl:when test="text()='p'">x0070</xsl:when>
			<xsl:when test="text()='q'">x0071</xsl:when>
			<xsl:when test="text()='r'">x0072</xsl:when>
			<xsl:when test="text()='s'">x0073</xsl:when>
			<xsl:when test="text()='t'">x0074</xsl:when>
			<xsl:when test="text()='u'">x0075</xsl:when>
			<xsl:when test="text()='v'">x0076</xsl:when>
			<xsl:when test="text()='w'">x0077</xsl:when>
			<xsl:when test="text()='x'">x0078</xsl:when>
			<xsl:when test="text()='y'">x0079</xsl:when>
			<xsl:when test="text()='z'">x007a</xsl:when>
			
			<xsl:when test="text()='0'">x0030</xsl:when>
			<xsl:when test="text()='1'">x0031</xsl:when>
			<xsl:when test="text()='2'">x0032</xsl:when>
			<xsl:when test="text()='3'">x0033</xsl:when>
			<xsl:when test="text()='4'">x0034</xsl:when>
			<xsl:when test="text()='5'">x0035</xsl:when>
			<xsl:when test="text()='6'">x0036</xsl:when>
			<xsl:when test="text()='7'">x0037</xsl:when>
			<xsl:when test="text()='8'">x0038</xsl:when>
			<xsl:when test="text()='9'">x0039</xsl:when>
			
			<xsl:when test="text()='.'">x002e</xsl:when>
			<xsl:when test="text()='!'">x0021</xsl:when>
			<xsl:when test="text()='#'">x0023</xsl:when>
			<xsl:when test="text()='$'">x0024</xsl:when>
			<xsl:when test="text()='%'">x0025</xsl:when>
			<xsl:when test="text()='*'">x002a</xsl:when>
			<xsl:when test="text()='/'">x002f</xsl:when>
			<xsl:when test="text()='='">x003d</xsl:when>
			<xsl:when test="text()='?'">x003f</xsl:when>
			<xsl:when test="text()='^'">x005e</xsl:when>
			<xsl:when test="text()='_'">x005f</xsl:when>
			<xsl:when test="text()='`'">x0060</xsl:when>
			<xsl:when test="text()='{'">x007b</xsl:when>
			<xsl:when test="text()='|'">x007c</xsl:when>
			<xsl:when test="text()='}'">x007d</xsl:when>
			<xsl:when test="text()='~'">x007e</xsl:when>
			<xsl:when test="text()='+'">x002b</xsl:when>
			<xsl:when test="text()='-'">x002d</xsl:when>
			<xsl:when test="text()='@'">x0040</xsl:when>
		</xsl:choose>
	</xsl:for-each>
	</xsl:variable>
	<xsl:value-of select="$encoded" disable-output-escaping="yes"/>
</xsl:template>

</xsl:stylesheet>
