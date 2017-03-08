<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>    
    <title>好着急后台管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp"></s:include>
		<div class="trueBody">
			<s:property value="#request.errorMessage"/>
		</div>
	</body>
</html>
