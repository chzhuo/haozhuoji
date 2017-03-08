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
			span{color:#999999}
		</style>
	</head>
<body>
	<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
	<div class="trueBody">
		<div class="title">修改商品属性</div>
		<s:form action="%{@com.haozhuoji.mall.util.Constant@admin_p}/goods_update.html">
			<div style="padding:30px;width:300px;float:left">
				<s:hidden name="goodsID" />
				<s:hidden name="newGoods" />
				<s:textarea cssStyle="width:300px;height:500px;padding:2px;line-height:15px" name="properties" /><br/>
				<s:submit value="提交" />
			</div>
			<div style="float:left;padding-top:30px">
				<span>格式如:<br/><br/><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;产地：上海<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;保质期：180天</span>
			</div>
		</s:form>
	</div>
</body>
</html>
