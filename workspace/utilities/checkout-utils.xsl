<?xml version="1.0" encoding="UTF-8"?>
<!--checkout-utils.xsl
 *
 * Utilities for generating checkout forms
 *
 * Author: David Anderson 2011
 * dave@veodesign.co.uk
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:form="http://nick-dunn.co.uk/xslt/form-controls"
	extension-element-prefixes="exsl form">



<!-- ###############################  ######  ############################### -->
<!-- ###############################  BASKET  ############################### -->
<!-- ###############################  ######  ############################### -->

<xsl:template name="get-basket-total-item-count">
	<xsl:param name="items" select="//data/basket-order-items/entry"/>
	
	<xsl:choose>
		<xsl:when test="$items">
			
			<xsl:variable name="i">
				<xsl:value-of select="$items['0']/quantity"/>
			</xsl:variable>
			
			<xsl:variable name="next">
				<xsl:call-template name="get-basket-item-count">
					<xsl:with-param name="items" select="$items[position() &gt; '1']"/>
				</xsl:call-template>
			</xsl:variable>
			
		<xsl:value-of select="$i + $next"/>
		
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="'0'"/>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template name="get-basket-item-count">
	<xsl:param name="items" select="//data/basket-order-items/entry"/>
	<xsl:value-of select="count($items)"/>
</xsl:template>



<!-- ###############################  ############  ############################### -->
<!-- ###############################  BASKET FORMS  ############################### -->
<!-- ###############################  ############  ############################### -->

<xsl:template name="checkout-modify-basket-form">
	<xsl:param name="product"/>
	<xsl:param name="quantity" select="'1'"/>
	<xsl:param name="action" select="'update'"/>
	<xsl:param name="show-label" select="'1'"/>
	
	<form action="" enctype="multipart/form-data" method="post">
		<xsl:if test="$action = 'add'"><xsl:attribute name="id">basket-add</xsl:attribute></xsl:if>
			
		<div class="l">
			<xsl:if test="$show-label = '1'">
				<label for="quantity">Quantity</label>
			</xsl:if>
			<input name="quantity" id="cart-quantity" type="text" value="{$quantity}" />

		</div>
								
		<div class="r">
			<xsl:choose>
				<xsl:when test="$action = 'update'">
					<input name="options" type="hidden" value="{$option}"/>
					<input name="id" type="hidden" value="{$product/@id}"/>
					<input name="basket-action[{$action}]" type="submit" value="Update" />
				</xsl:when>
				<xsl:otherwise>
					<input name="id" type="hidden" value="{$product/@id}"/>
					<input name="basket-action[{$action}]" type="submit"  value="Add" />
				</xsl:otherwise>				
			</xsl:choose>
		</div>
		
		<div class="clear"></div>
	</form>
	<xsl:if test="$action = 'update'">
		<form action="" enctype="multipart/form-data" method="post">
			<div class="r">
				<input name="id" type="hidden" value="{$product/@id}"/>
				<input name="quantity" type="hidden" value="0"/>
				<input name="basket-action[{$action}]" type="submit"  value="Remove" />
			</div>	
		</form>
	</xsl:if>

</xsl:template>


<!-- ###############################  #############  ############################### -->
<!-- ###############################  CHECKOUT MAIN  ############################### -->
<!-- ###############################  #############  ############################### -->

<xsl:template name="checkout-info-form">	
	<div id="checkout-info">
	<form method="post" enctype="multipart/form-data">
		
		<xsl:variable name="c1" select="'grid_2 alpha l'"/>
		<xsl:variable name="c2" select="'grid_4 omega r'"/>
		<xsl:variable name="e" select="'error'"/>
				
		<div class="alpha omega grid_12">
			
			<!--FIRST NAME-->
			<div class="grid_6 alpha">
				
				<h2>Your Details</h2>
			
				<div class="item {$form:event/first-name/@error}">
					<div class="{$c1} ">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'first-name'"/>
							<xsl:with-param name="text" select="'First Name *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'first-name'"/>
							<xsl:with-param name="value" select="first-name"/>
							<xsl:with-param name="title" select="'Please Enter your First Name'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/first-name">
						<div class="{$e}">
							<xsl:text>Please Enter Your First Name</xsl:text>
						</div>
					</xsl:if>
	
					<div class="clear"></div>
				</div>		
			
				<div class="clear"></div>
			
				<!-- SECOND NAME -->
			
				<div class="item {$form:event/last-name/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'last-name'"/>
							<xsl:with-param name="text" select="'Last Name *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'last-name'"/>
							<xsl:with-param name="value" select="last-name"/>
							<xsl:with-param name="title" select="'Please Enter your Last Name'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/last-name">
						<div class="{$e}">
							<xsl:text>Please Enter your Last Name</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
			
		 	<!-- COMPANY -->
			
				<div class="item">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'company'"/>
							<xsl:with-param name="text" select="'Company'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'company'"/>
							<xsl:with-param name="value" select="company"/>
							<xsl:with-param name="title" select="'Please Enter your Company'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			
			<!--PHONE AND EMAIL-->
			
			
			
			<!--PHONE-->
			<div class="grid_6 omega">
				
				<h2>Contact Info</h2>
				
				<div class="item {$form:event/phone/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'phone'"/>
							<xsl:with-param name="text" select="'Phone No *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'phone'"/>
							<xsl:with-param name="value" select="phone"/>
							<xsl:with-param name="title" select="'Please Enter Your Phone No'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/phone">
						<div class="{$e}">
							<xsl:text>Please Enter Your Phone Number</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>

			
				<div class="clear"></div>
				
				<!--MOBILE-->
				<div class="item {$form:event/mobile/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'mobile'"/>
							<xsl:with-param name="text" select="'Mobile No'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'mobile'"/>
							<xsl:with-param name="value" select="mobile"/>
							<xsl:with-param name="title" select="'Please Enter Your Mobile Number'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/mobile">
						<div class="{$e}">
							<xsl:text>Please Enter Your Mobile Number</xsl:text>
						</div>
					</xsl:if>

					<div class="clear"></div>
				</div>

				<div class="clear"></div>
			
				<!--EMAIL-->
			
				<div class="item {$form:event/email/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'email'"/>
							<xsl:with-param name="text" select="'Email *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'email'"/>
							<xsl:with-param name="value" select="email"/>
							<xsl:with-param name="title" select="'Please Enter Your Email Address'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					
					<xsl:if test="$form:event/email">
						<div class="{$e}">
							<xsl:text>Please Enter a Valid Email Address</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
			</div>
		</div>
			
			<div class="clear"></div>
			
			<!--SAME BILLING ADDRESS-->
			
			<div class="prefix_2 grid_6 alpha omega ">
				<div class="item inline seperator">
					<xsl:variable name="address-checked">
						<xsl:choose>
							<xsl:when test="status/item/@handle != 'basket'">
								<xsl:value-of select="same-as-shipping-address"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>yes</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
				
					<xsl:call-template name="form:checkbox">
						<xsl:with-param name="handle" select="'same-as-shipping-address'"/>
						<xsl:with-param name="checked" select="$address-checked"/>
						<xsl:with-param name="title"/>
					</xsl:call-template>
					<xsl:call-template name="form:label">
						<xsl:with-param name="for" select="'same-as-shipping-address'"/>
						<xsl:with-param name="text" select="'Billing Address the same as Shipping Address?'"/>
					</xsl:call-template>
				</div>
			</div>
			
			<div class="clear"></div>
			
			<!-- SHIPPING ADDRESS -->
			<div class="grid_6 alpha" id="shipping address">
				
				<h2>Shipping Address</h2>
				
				<!-- ADDRESS-1 -->
				<div class="item {$form:event/address-1/@error}">
					<div class="{$c1} ">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'address-1'"/>
							<xsl:with-param name="text" select="'Address *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'address-1'"/>
							<xsl:with-param name="value" select="address-1"/>
							<xsl:with-param name="title" select="'Please Enter your Shipping Address'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/address-1">
						<div class="{$e}">
							<xsl:text>Please Enter your Shipping Address</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
				
				<!-- ADDRESS-2 -->
				<div class="item {$form:event/address-2/@error}">
					<div class="prefix_2 grid_4 alpha omega r">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'address-2'"/>
							<xsl:with-param name="value" select="address-2"/>
							<xsl:with-param name="title" select="'Please Enter your Shipping Address'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/address-2">
						<div class="{$e}">
							<xsl:text>Please Enter your Shipping Address</xsl:text>
						</div>
					</xsl:if>

					<div class="clear"></div>
				</div>
				
				<!-- ADDRESS-3 -->
				<div class="item {$form:event/address-3/@error}">
					<div class="prefix_2 grid_4 alpha omega r">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'address-3'"/>
							<xsl:with-param name="value" select="address-3"/>
							<xsl:with-param name="title" select="'Please Enter your Shipping Address'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
				</div>
				
				<!-- CITY -->
				<div class="item {$form:event/city/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'city'"/>
							<xsl:with-param name="text" select="'City *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'city'"/>
							<xsl:with-param name="value" select="city"/>
							<xsl:with-param name="title" select="'Please enter your City'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/city">
						<div class="{$e}">
							<xsl:text>Please Enter Your City</xsl:text>
						</div>
					</xsl:if>
	
					<div class="clear"></div>
				</div>
				
				<!-- POSTCODE -->
				<div class="item {$form:event/postcode/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'postcode'"/>
							<xsl:with-param name="text" select="'Postcode *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'postcode'"/>
							<xsl:with-param name="value" select="postcode"/>
							<xsl:with-param name="title" select="'Please enter your Postcode'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/postcode">
						<div class="{$e}">
							<xsl:text>Please Enter a Valid Postcode</xsl:text>
						</div>
					</xsl:if>

					<div class="clear"></div>
				</div>
				
				<!-- COUNTRY -->
				<div class="item {$form:event/country/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'country'"/>
							<xsl:with-param name="text" select="'Country *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<select name="fields[country][]" id="country">
							<xsl:apply-templates select="//data/basket-countries-all/entry" mode="opt">
								<xsl:with-param name="val" select="country"/>
							</xsl:apply-templates>
						</select>

					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/country">
						<div class="{$e}">
							<xsl:text>Please Enter Your Country</xsl:text>
						</div>
					</xsl:if>
	
					<div class="clear"></div>
				</div>
				
			</div>
			
			
			<!--BILLING ADDRESS-->
			<div class="grid_6 alpha" id="billing-address">
				
				<h2>Billing Address</h2>
				
				<!-- ADDRESS-1 -->
				<div class="item {$form:event/billing-address-1/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'billing-address-1'"/>
							<xsl:with-param name="text" select="'Address *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'billing-address-1'"/>
							<xsl:with-param name="value" select="billing-address-1"/>
							<xsl:with-param name="title" select="'Please Enter your Billing Address'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>						
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/billing-address-1">
						<div class="{$e}">
							<xsl:text>Please Enter your Billing Address</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
				
				<!-- ADDRESS-2 -->
				<div class="item {$form:event/billing-address-2/@error}">
					<div class="prefix_2 grid_4 alpha omega r">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'billing-address-2'"/>
							<xsl:with-param name="value" select="billing-address-2"/>
							<xsl:with-param name="title" select="'Please Enter your Billing Address'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/billing-address-2">
						<div class="{$e}">
							<xsl:text>Please Enter your Billing Address</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
				
				<!-- ADDRESS-3 -->
				<div class="item">
					<div class="prefix_2 grid_4 alpha omega r">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'billing-address-3'"/>
							<xsl:with-param name="value" select="billing-address-3"/>
							<xsl:with-param name="title" select="'Please Enter the Third Line of Your Address'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
				</div>
				
				<!-- CITY -->
				<div class="item {$form:event/billing-city/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'billing-city'"/>
							<xsl:with-param name="text" select="'City *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'billing-city'"/>
							<xsl:with-param name="value" select="billing-city"/>
							<xsl:with-param name="title" select="'Please enter your City'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/billing-city">
						<div class="{$e}">
							<xsl:text>Please Enter Your City</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
				
				<!-- POSTCODE -->
				<div class="item {$form:event/billing-postcode/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'billing-postcode'"/>
							<xsl:with-param name="text" select="'Postcode *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">
						<xsl:call-template name="form:input">
							<xsl:with-param name="handle" select="'billing-postcode'"/>
							<xsl:with-param name="value" select="billing-postcode"/>
							<xsl:with-param name="title" select="'Please enter your Postcode'"/>
							<xsl:with-param name="class" select="'text'"/>
						</xsl:call-template>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/billing-postcode">
						<div class="{$e}">
							<xsl:text>Please Enter a Valid Postcode</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
				
				<!-- COUNTRY -->
				<div class="item {$form:event/billing-country/@error}">
					<div class="{$c1}">
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'billing-country'"/>
							<xsl:with-param name="text" select="'Country *'"/>
						</xsl:call-template>
					</div>
					<div class="{$c2}">

						<select name="fields[billing-country][]" id="billing-country">
							<xsl:apply-templates select="//data/basket-countries-all/entry" mode="opt">
								<xsl:with-param name="val" select="billing-country"/>
							</xsl:apply-templates>
						</select>
					</div>
					<div class="clear"></div>
					<xsl:if test="$form:event/billing-country">
						<div class="{$e}">
							<xsl:text>Please Enter Your Country</xsl:text>
						</div>
					</xsl:if>
					<div class="clear"></div>
				</div>
				
			</div>
			
			<div class="clear"></div>
			

		<div>	
			
			<div class="prefix_2 grid_4 alpha">
				<div class="item inline">
					<xsl:call-template name="form:checkbox">
						<xsl:with-param name="handle" select="'newsletter'"/>
						<xsl:with-param name="checked" select="newsletter"/>
						<xsl:with-param name="checked-by-default" select="'yes'"/>
						<xsl:with-param name="title" select="'Newsletter Signup'"/>
					</xsl:call-template>
					<xsl:call-template name="form:label">
						<xsl:with-param name="for" select="'newsletter'"/>
						<xsl:with-param name="text" select="'Newsletter Signup'"/>
					</xsl:call-template>
				</div>
			</div>
			
			<div class="clear"></div>
			
			<div class="prefix_2 grid_4 alpha">
				<div class="item inline {$form:event/t-and-c/@error}">
					<div>
						<xsl:call-template name="form:checkbox">
							<xsl:with-param name="handle" select="'t-and-c'"/>
							<xsl:with-param name="checked" select="t-and-c"/>
							<xsl:with-param name="checked-by-default" select="'no'"/>
							<xsl:with-param name="title" select="'Agree to Our Terms *'"/>
						</xsl:call-template>
						<xsl:call-template name="form:label">
							<xsl:with-param name="for" select="'t-and-c'"/>
							<xsl:with-param name="text" select="'Agree to Our Terms'"/>
						</xsl:call-template>
					</div>
					<xsl:if test="$form:event/t-and-c">
						<div class="{$e}">
							<xsl:text>Please Agree to our Terms</xsl:text>
						</div>
					</xsl:if>
				</div>
				<div class="clear"></div>
				
			</div>
			
			<div class="prefix_2 grid_2 omega">
				<div class="item no-hover">					
					<input name="id" type="hidden" value="{@id}" />
  					<input name="action[checkout-customer-details]" type="submit" value="Submit" />
				</div>
			</div>
			
			<div class="clear"></div>
			
		</div>
	</form>	
	</div>
</xsl:template>


<xsl:template match="//data/basket-countries-all/entry" mode="opt">
	<xsl:param name="val"/>
	<option value="{@id}">
		<xsl:if test="$val = code">
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		
		<xsl:value-of select="name"/>
	</option>	
	
</xsl:template>



<!-- ###############################  ##############  ############################### -->
<!-- ###############################  CHECKOUT STAGE  ############################### -->
<!-- ###############################  ##############  ############################### -->

<xsl:template name="checkout-stages">
	<xsl:param name="stage" select="'1'"/>
	
	<div class="checkout-stages">
		<div class="grid_3 alpha">
			<div>
				<xsl:attribute name="class">
					<xsl:text>inner </xsl:text>
					<xsl:if test="$stage = '1'">active</xsl:if>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="$stage &gt; '1'">
						<a href="/checkout">
							<b>1)</b>
							<xsl:text> Your Basket</xsl:text>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<b>1)</b>
						<xsl:text> Your Basket</xsl:text>
					</xsl:otherwise>	
				</xsl:choose>			
				
			</div>
		</div>
		
		<div class="grid_3">
			<div>
				<xsl:attribute name="class">
					<xsl:text>inner </xsl:text>
					<xsl:if test="$stage = '2'">active</xsl:if>
				</xsl:attribute>

				<xsl:choose>
					<xsl:when test="$stage &gt; '2'">
						<a href="/checkout/info">
							<b>2)</b>
							<xsl:text> Your Details</xsl:text>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<b>2)</b>
						<xsl:text> Your Details</xsl:text>
					</xsl:otherwise>	
				</xsl:choose>	
			</div>	
		
		</div>
		
		<div class="grid_3">
			<div>
				<xsl:attribute name="class">
					<xsl:text>inner </xsl:text>
					<xsl:if test="$stage = '3'">active</xsl:if>
				</xsl:attribute>

				<xsl:choose>
					<xsl:when test="$stage &gt; '3'">
						<a href="/checkout/shipping">
							<b>3)</b>
							<xsl:text> Shipping</xsl:text>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<b>3)</b>
						<xsl:text> Shipping</xsl:text>
					</xsl:otherwise>	
				</xsl:choose>	
			</div>	
		
		</div>
		
		<div class="grid_3 omega">
			<div>
				<xsl:attribute name="class">
					<xsl:text>inner </xsl:text>
					<xsl:if test="$stage = '4'">active</xsl:if>
				</xsl:attribute>
				<b>3)</b>
				<xsl:text> Pay</xsl:text>
			</div>
		</div>
		
		<div class="clear"></div>	
	</div>	
</xsl:template>



	
</xsl:stylesheet>