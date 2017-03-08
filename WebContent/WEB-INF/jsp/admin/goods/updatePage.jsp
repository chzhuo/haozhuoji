<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
	<head>
		<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
		<script type="text/javascript">
			var initParams={
				goodsID:<s:property value="goodsID" />,
				filePath:'<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />',
				adminPath:'<s:property value="@com.haozhuoji.mall.util.Constant@admin_p" />'
			};
		</script>
		<script type="text/javascript" src='/ueditor1_3_6-utf8/ueditor.config.js'></script>
		<script type="text/javascript" src='/ueditor1_3_6-utf8/ueditor.all.js'></script>
		<script type="text/javascript">
			$(function(){
				var editor = UE.getEditor('descriptionPage');
			});
		</script>
		<style type="text/css">
			span{color:#999999}
		</style>
	</head>
<body>
	<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
	<div class="trueBody">
		<div class="title">修改详情页面</div>
		<span id="spanSWFUploadButton">上传</span>
		<s:form action="%{@com.haozhuoji.mall.util.Constant@admin_p}/goods_update.html">
			<div style="padding:30px;width:300px;float:left">
				<s:hidden name="goodsID" />
				<s:textarea id="descriptionPage" cssStyle="width:978px;height:500px;padding:2px;line-height:15px" name="descriptionPage" /><br/>
				<s:submit value="提交" />
			</div>
		</s:form>
	</div>
</body>
</html>
