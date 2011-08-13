<?xml version="1.0" encoding="utf-8"?>
<!-- navigation.xsl
 * 
 * Navigation functions for Core Interiors 
 *
 * Author: David Anderson 2010
 * dave@veodesign.co.uk
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- NAVIGATION -->
<!-- ################################################## -->


<!-- Generate URLS for products filtering -->

<xsl:template name="url-item">
	<xsl:param name="product" select="."/>
	<xsl:value-of select="concat($root,'/product/',$product/product-type/item/@handle,'/',$product/brand/item/@handle,'/',$product/title/@handle)"/>
</xsl:template>

<xsl:template name="url-i">
	<xsl:param name="product" select="."/>
	<xsl:attribute name="href">
		<xsl:call-template name="url-item">
			<xsl:with-param name="product" select="$product"/>
		</xsl:call-template>
	</xsl:attribute>
</xsl:template>


<xsl:template name="url-products">
	<xsl:param name="type" select="''"/>
	<xsl:param name="brand" select="''"/>
	<xsl:param name="cats" select="''"/>
	<xsl:param name="q" select="''"/>
	<xsl:param name="sort" select="''"/>
	<xsl:param name="page" select="''"/>
	
	<xsl:variable name="params">
		<xsl:if test="$q != '' and $sort != '' and $page != ''">
			<xsl:value-of select="concat('?q=',$q,'&amp;page=',$page,'&amp;sort=',$sort)"/>
		</xsl:if>
	</xsl:variable>
	<xsl:value-of select="concat($root,'/products/')"/>
	
	<xsl:choose>
		<xsl:when test="$type != ''">
			<xsl:value-of select="concat($type,'/')"/>
		</xsl:when>
		<xsl:when test="$brand != ''">
			<xsl:value-of select="concat($brand,'/')"/>
			
		</xsl:when>	
	</xsl:choose>
	
	<xsl:if test="$cats!=''">
		<xsl:value-of select="$cats"/>
	</xsl:if>
	
</xsl:template>

<!--shortcuts-->

<xsl:template name="url-p">
	<xsl:param name="type" select="''"/>
	<xsl:param name="brand" select="''"/>
	<xsl:param name="cats" select="''"/>
	<xsl:param name="q" select="''"/>
	<xsl:param name="sort" select="''"/>
	<xsl:param name="page" select="''"/>
	
	<xsl:attribute name="href">
		<xsl:call-template name="url-products">
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="brand" select="$brand"/>
			<xsl:with-param name="cats" select="$cats"/>
			<xsl:with-param name="q" select="$q"/>
			<xsl:with-param name="sort" select="$sort"/>
			<xsl:with-param name="page" select="$page"/>
		</xsl:call-template>
	</xsl:attribute>
</xsl:template>


<!--product nav lists-->
<xsl:template match="nav-product-types/entry" mode="li">
	
	<li>
		<a>
			<xsl:call-template name="url-p">
				<xsl:with-param name="type" select="title/@handle"/>
			</xsl:call-template>
			<xsl:value-of select="title"/>
		</a>
	</li>
</xsl:template>

<xsl:template match="nav-brands/entry" mode="subnav">
	<xsl:param name="children" select="'yes'"/>
	<li>
		<xsl:variable name="cid" select="@id"/>
		<xsl:variable name="t" select="title/@handle"/>
		
		<xsl:attribute name="class">
			<xsl:if test="count(//data/fp-brands/entry/title[@handle=$t]) &gt; '0'">active</xsl:if>
		</xsl:attribute>

		<a>
			<xsl:call-template name="url-p">
				<xsl:with-param name="brand" select="title/@handle"/>
			</xsl:call-template>
			<xsl:value-of select="title"/>
			
			<xsl:call-template name="image">
				<xsl:with-param name="item" select="image/item"/>
				<xsl:with-param name="width" select="'100'"/>
				<xsl:with-param name="height" select="'40'"/>
				<xsl:with-param name="alt" select="title" />
			</xsl:call-template>
			
			<div class="clear"></div>
		</a>
		
		
		<xsl:if test="$children = 'yes'">
			<xsl:if test="count(//data/nav-categories/entry[parent/item/@id = $cid]) &gt; 0">
				<ul>				
					<xsl:apply-templates select="//data/nav-categories/entry[parent/item/@id = $cid]"/>
				</ul>
			</xsl:if>
		</xsl:if>
	</li>
</xsl:template>



<!--NAV LINKS FOR TREE NAV-->
<xsl:template match="nav-product-types/entry" mode="subnav">
	<xsl:param name="children" select="'yes'"/>
	<li>
		<xsl:variable name="cid" select="@id"/>
		<xsl:variable name="t" select="title/@handle"/>
		
		<xsl:attribute name="class">
			<xsl:if test="count(//data/fp-types/entry/title[@handle=$t]) &gt; '0'">active</xsl:if>
		</xsl:attribute>
		<a>
			<xsl:call-template name="url-p">
				<xsl:with-param name="type" select="title/@handle"/>
			</xsl:call-template>
			<xsl:value-of select="title"/>
		</a>
		
		<xsl:if test="$children = 'yes'">
			<xsl:if test="count(//data/nav-categories/entry[parent/item/@id = $cid]) &gt; 0">
				<ul>				
					<xsl:apply-templates select="//data/nav-categories/entry[parent/item/@id = $cid]"/>
				</ul>
			</xsl:if>
		</xsl:if>
	</li>
</xsl:template>


<xsl:template match="nav-categories/entry">
	<xsl:param name="root-node"/>
	<li>
		<xsl:variable name="cid" select="@id"/>
		<xsl:variable name="t" select="title/@handle"/>
		
		<xsl:attribute name="class">
			<xsl:if test="count(//data/fp-cats/entry/title[@handle=$t]) &gt; '0'">active</xsl:if>
		</xsl:attribute>
		
		<a>
			<xsl:call-template name="url-p-cat">			
				<xsl:with-param name="cats" select="title/@handle"/>
				<xsl:with-param name="parent">
					<xsl:call-template name="cat-determine-parent"/>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:value-of select="title"/>
		</a>	

		<xsl:if test="count(//data/nav-categories/entry[parent/item/@id = $cid]) &gt; 0">
			<ul>				
				<xsl:apply-templates select="//data/nav-categories/entry[parent/item/@id = $cid]"/>
			</ul>
		</xsl:if>
	</li>
</xsl:template>


<!--USE THE CAT-DETERMINE-PARENT DATA to produce a subcat link

-->
<xsl:template name="url-p-cat">
	<xsl:param name="cats" select="title/@handle"/>
	<xsl:param name="parent"/>
	
	<xsl:param name="q"/>
	<xsl:param name="sort"/>
	<xsl:param name="page"/>
	
	<xsl:variable name="brand">
		<xsl:if test="substring-before($parent,',') = 'brand'">
			<xsl:value-of select="substring-after($parent,',')"/>		
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="type">
		<xsl:if test="substring-before($parent,',') = 'type'">
			<xsl:value-of select="substring-after($parent,',')"/>		
		</xsl:if>
	</xsl:variable>	
	
	
	<xsl:attribute name="href">
		<xsl:call-template name="url-products">
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="brand" select="$brand"/>
			<xsl:with-param name="cats" select="$cats"/>
			<xsl:with-param name="q" select="$q"/>
			<xsl:with-param name="sort" select="$sort"/>
			<xsl:with-param name="page" select="$page"/>
		</xsl:call-template>
	</xsl:attribute>
	
</xsl:template>


<!--DETERMINE THE CATEGORY ROOT PARENT USING RECURSION
# Includes a self limiter
# Returns type of node(brand,type,filter),handle
-->
<xsl:template name="cat-determine-parent">
	<xsl:param name="count" select="'0'"/>
	<xsl:param name="node" select="parent/item"/>
	<xsl:param name="root-node" select="//data/nav-categories"/>
	
	<xsl:choose>
		<xsl:when test="$count &gt; '20'">
			<xsl:text></xsl:text>
		</xsl:when>
		<xsl:when test="$node/@section-handle = 'product-types'">
			<xsl:value-of select="concat('type,',$node/@handle)"/>
		</xsl:when>
		<xsl:when test="$node/@section-handle = 'brands'">
			<xsl:value-of select="concat('brand,',$node/@handle)"/>
		</xsl:when>
		<xsl:when test="$node/@section-handle = 'product-filters'">
			<xsl:value-of select="concat('filter,',$node/@handle)"/>
		</xsl:when>
		<xsl:otherwise>
			
			<xsl:variable name="id" select="$node/@id"/>
			
			<xsl:call-template name="cat-determine-parent">
				<xsl:with-param name="count" select="$count + '1'"/>
				<xsl:with-param name="node" select="$root-node/entry[@id = $id]/parent/item"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>


<!--BUILD FILTER URLS
##################################################### -->

<xsl:template name="url-filter">
	
	<!--used to add/remove if currently applied a filter-->
	<xsl:param name="f" select="'-'"/>
	
	<!--used to add/remove if currently applied a category filter-->
	<xsl:param name="f-c" select="'-'"/>
	
	<!--URL PARAMS-->
	<xsl:param name="u-type" select="$types"/>
	<xsl:param name="u-cat" select="$categories"/>
	<xsl:param name="u-filter" select="$filter"/>
	<xsl:param name="u-filter-cat" select="$filter-cat"/>
	
	<!--ENSURE NONE ARE EMPTY -->
	<xsl:variable name="u-t">
		<xsl:choose>
			<xsl:when test="string-length($u-type)= '0'"><xsl:value-of select="'-'"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$u-type"/></xsl:otherwise>			
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="u-c">
		<xsl:choose>
			<xsl:when test="string-length($u-cat)= '0'"><xsl:value-of select="'-'"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$u-cat"/></xsl:otherwise>			
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="u-f">
		<xsl:choose>
			<xsl:when test="string-length($u-filter)= '0'"><xsl:value-of select="'-'"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$u-filter"/></xsl:otherwise>			
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="u-fc">
		<xsl:choose>
			<xsl:when test="string-length($u-filter-cat)= '0'"><xsl:value-of select="'-'"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$u-filter-cat"/></xsl:otherwise>			
		</xsl:choose>
	</xsl:variable>
	
	
	
	<!--BUILD THE FILTERING PARTS-->
	<!--this operates a "replace" policy for the values so it can only be set to one possible value-->
	<!--the second bit of logic is to prevent conflicts with the cat-filter being set for product-types and brands-->
	
	
	<!--determine the parent and type-->
	
	<xsl:variable name="cat-parent">
		<xsl:call-template name="cat-determine-parent">
			<xsl:with-param name="node" select="//data/nav-categories/entry[title/@handle = $f-c]/parent/item"/>
		</xsl:call-template>	
	</xsl:variable>
	<xsl:variable name="current-parent">
		<xsl:if test="not($f-c = '-')">
			<xsl:choose>
				<xsl:when test="substring-before($cat-parent,',') = 'brand'">
					<xsl:value-of select="'brand'"/>		
				</xsl:when>
				<xsl:when test="substring-before($cat-parent,',') = 'type'">
					<xsl:value-of select="'type'"/>		
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after($cat-parent,',')"/>		
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:variable>
	

	
	<!--BUILD THE FILTER -->
	<xsl:variable name="filter-str">
		<xsl:choose>
			<xsl:when test="$f = '-'">
				<xsl:choose>
					<!--if nothing selected, make sure the selection matches the new subcategory-->
					<xsl:when test="($current-parent = 'brand' or $current-parent = 'type') and $f != substring-after($cat-parent,',')">
						<xsl:value-of select="substring-after($cat-parent,',')"/>
					</xsl:when>
					<xsl:otherwise>
						<!--output the original string-->
						<xsl:value-of select="$u-f"/>	
					</xsl:otherwise>
				</xsl:choose>				
			</xsl:when>
			<xsl:otherwise>
				<!--output the new string-->
				<xsl:value-of select="$f"/>	
			</xsl:otherwise>	
		</xsl:choose>		
	</xsl:variable>
	
	
	
	
	<!--BUILD THE FILTER CAT-->
	
	
	
	<!-- BEHAVIOUR
			Will toggle the filter by allowing only one category per type/brand/category to be selected
			ie there would be no point allowing multiple from light, medium and dark for instance
			
			pseudo code:
			
			1) determine current items parent
			2) loop through all selected categories
				2.1) determine their parents
				2.2) if is the same then remove
				2.3) if is different then add to query string
		-->
		
	<!--first determine the current nodes parent-->
	
	
	
	
	<xsl:variable name="filter-cat-str">
	
		<!--toggle the current item-->
		<xsl:if test="not(//data/fp-filter-cats/entry[title/@handle = $f-c]) and not($f-c = '-')">
			<xsl:value-of select="$f-c"/>
		</xsl:if>
		
		<xsl:for-each select="//data/fp-filter-cats/entry">
			
			<!--the parent type or product filter-->
			<xsl:variable name="p">
				<xsl:call-template name="filter-get-parent">
					<xsl:with-param name="current-parent" select="parent/item"/>
				</xsl:call-template>
			</xsl:variable>
			
			<!--the parent if it is a type or brand-->
			<xsl:variable name="q">
				<xsl:call-template name="cat-determine-parent">
					<xsl:with-param name="node" select="parent/item"/>
				</xsl:call-template>
			</xsl:variable>
			
			<xsl:choose>
				<!--something has been set-->
				<xsl:when test="not($f-c = '-')">
			
					<xsl:choose>
						<!--remove and replace-->
						<xsl:when test="$current-parent = $p">
						
						</xsl:when>
						<!--keep-->
						<xsl:otherwise>
							<!--check not already active-->
							<xsl:if test="not(title/@handle = $f-c)">
								<xsl:value-of select="concat('+',title/@handle)"/>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
			
				</xsl:when>
				
				<!--the cat-filter must check that it doesn't conflict with the filter -->
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="($p = 'type' or $p = 'brand') ">
							
						</xsl:when>
						
						<xsl:otherwise>
							<xsl:value-of select="concat('+',title/@handle)"/>
						</xsl:otherwise>					
					</xsl:choose>

				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:for-each>	
			
	</xsl:variable>

		<xsl:variable name="url">
		<xsl:value-of select="concat($root,'/products/',$u-t,'/',$u-c,'/')"/>
		<xsl:choose>
			<xsl:when test="$filter-str = '-' and $filter-cat-str = '-'">
			
			</xsl:when>
			<xsl:when test="$filter-cat-str = '-'">
				<xsl:value-of select="$filter-str"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($filter-str,'/',$filter-cat-str)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:value-of select="$url"/>
	
</xsl:template>


<!--FILTER-GET-PARENT
 - Returns the relevent information needed with regards to the category parent for the filtering algorithm
 - Returns either "type","brand" or the name of the product filter that is the root node
 -->
<xsl:template name="filter-get-parent">
	<xsl:param name="current-parent"/>
	
	<!--determine the parent and type-->
	<xsl:variable name="cat-parent">
		<xsl:call-template name="cat-determine-parent">
			<xsl:with-param name="node" select="$current-parent"/>
		</xsl:call-template>	
	</xsl:variable>
	
	<!--parse the info into the format we require-->
	
	<xsl:choose>
		<xsl:when test="substring-before($cat-parent,',') = 'brand'">
			<xsl:value-of select="'brand'"/>		
		</xsl:when>
		<xsl:when test="substring-before($cat-parent,',') = 'type'">
			<xsl:value-of select="'type'"/>		
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="substring-after($cat-parent,',')"/>		
		</xsl:otherwise>
	</xsl:choose>	
	
</xsl:template>


</xsl:stylesheet>