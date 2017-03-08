<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
	<head>
		<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
		<script type="text/javascript">
		var goodsID = null;
		$(function(){
			$("tr:even").css("background-color","#f9f9f9");
			$("tr:odd").css("background-color","#fefefe");
			$("tr").hover(function(){
				$(this).css("background-color","#CEE3F7");
			},function(){					
				$("tr:even").css("background-color","#f9f9f9");
				$("tr:odd").css("background-color","#fefefe");
			});
		});
		</script>
		<style type="text/css">
			.left{text-align:right;padding-right:20px}
			.remind{color:#999999;padding-left:20px}
			table{padding:30px;border:0}
			td{border:0}
			input{width:300px;height:20px;margin:5px 0;padding-left:5px}
		</style>
	</head>
<body>
	<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
	<div class="trueBody">
		<s:form action="%{@com.haozhuoji.mall.util.Constant@admin_p}/goods_%{newGoods?'add':'update'}.html">
				<table>
					<s:hidden name="goodsID" />
					<tr>
						<td class="left">条形码：</td><td><s:textfield name="productNumber" cssClass="productNumber"/></td><td class="remind">没有不填</td>
					</tr>
					<tr>
						<td class="left">商品名称:</td><td><s:textfield name="goodsName" /></td><td class="remind">不包括规格和品牌</td>
					</tr>
					<tr>
						<td class="left">商品库存:</td><td><s:textfield name="amount" value="0"/><br/></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">商品价格:</td><td><s:textfield name="product_price"/></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">参考价格:</td><td><s:textfield name="reference_price"/></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">成本价格:</td><td><s:textfield name="cost_price"/></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">活动价格:</td><td><s:textfield name="promotion_price"/></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">商品规格:</td><td><s:textfield name="specification" /></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">关键字:</td><td><s:textfield name="keyWord" /></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">促销语:</td><td><s:textfield name="promotion_sentence"/></td><td class="remind">会在商品名称后面红色显示</td>
					</tr>
					<tr>
						<td class="left">货架号:</td><td><s:textfield name="shelfNumber"/></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">类型:</td><td><s:select name="typeID" list="#request.goodsTypeList" listKey="typeID" listValue="fullTypeName" value="typeID"></s:select>
						</td><td class="remind"><a href="javascript:void(0)">修改类型</a></td>
					</tr>
					<tr>
						<td class="left">品牌:</td><td><s:textfield name="brand"/></td><td class="remind"></td>
					</tr>
					<tr>
						<td class="left">积分:</td><td><s:textfield name="points"/></td><td class="remind"></td>
					</tr>
					<tr>
						<td> </td><td><input type="submit" value="提交" /></td><td> </td>
					</tr>
				</table>
		</s:form>
	</div>
</body>
</html>
