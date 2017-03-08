<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title>订单确认-好捉急校园便利店</title>
	<s:include value="/WEB-INF/jsp/frame/headMeta.jsp"/>
	<s:include value="/WEB-INF/jsp/frame/message.jsp"/>
	<s:include value="../frame/headMeta.jsp"></s:include>
	<script type="text/javascript" src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/js/jquery.cookie.js"></script>
</head>
	
	
<body>
		<%--头部 --%>
		<s:include value="/WEB-INF/jsp/frame/topStatus.jsp"></s:include>
		<style type="text/css">
			.topBar .topBar_content{width:1000px}
			.totalTitle{width:1000px;margin:20px auto;position:relative;}
			.totalTitle h1{color:#333333}
		</style>
		<div style="text-align:center;color:#eb4a3f;font:40px/60px 'microsoft yahei'">暂停营业</div>
  </body>
</html>