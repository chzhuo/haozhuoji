<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"></s:include>
		<title>个人中心 -好捉急校园便利店</title>
		<style type="text/css">
			.uc_title{height:20px;width:1000px;margin:0 auto;padding:10px 5px;font:20px/20px 'microsoft yahei';color:#333333}
			.uc_frame{width:1000px;margin:0 auto;overflow:hidden}
			.uc_right{width:780px;margin-left:18px;float:left;box-shadow:0 0 6px #eeeeee;overflow:hidden}
		</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp" />
		<s:include value="/WEB-INF/jsp/user/userCenter/headerStyle.jsp" />
		<div class="uc_title">
			个人中心
		</div>
		<div class="uc_frame">
			<s:include value="/WEB-INF/jsp/user/userCenter/menu.jsp" />
			<div class="uc_right">0</div>
		</div>
	</body>
</html>