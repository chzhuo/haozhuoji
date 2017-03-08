<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<html>
  <head>
    <title></title>
    <s:include value="../frame/headMeta.jsp"></s:include>
	<link rel="stylesheet" href="css/classPage.css" type="text/css"/>
   	<script type="text/javascript">
	onload=function(){
		$(".goodsWrap .goods").hover(function() {
			$(this).css("border","2px solid #EB4A3F");				
		}, function() {
			$(this).css("border","2px solid #eeeeee");				
		});
	}
	</script>
  </head>
  <body>
  	<s:include value="../frame/navigation.jsp"></s:include>
  	<s:if test="%{#session.userBean!=null||#request.userBean!=null}">
	  	<s:include value="../frame/cart.jsp"></s:include>
  	</s:if>
		<div class="bodyWrap">
			<div class="topSlide">
			</div>
			<div style="height:20px;margin:30px 0">
				<table style="height:20px" cellpadding="0" cellspacing="0" class="naviTitle">
				   	<tr>
				        	<td><div style="width:10px; height:20px; background-color:#EB4A3F;"></div></td>
				            <td width="100px" align="center"><s:a action="goods_keyword?keyword=%{keyword}"><s:property value="keyword"/></s:a></td>
				            
				           <td ><div style="width:750px; height:2px;background-color:#EB4A3F;float:right"></div></td>
				           <td ><div style="width:120px; height:2px;background-color:#E9EAE8;float:right"></div></td>
				      </tr>
				</table>
			</div>
			<div class="goodsWrap">
				<!-- goodsInclude -->
				<s:include value="../frame/keyGoods.jsp"></s:include>
				
			</div><!-- GoodsWrap -->
		</div>
		<s:property value="new Date()"/>
  </body>
</html>
