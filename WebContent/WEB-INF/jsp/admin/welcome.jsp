<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>显示所有商品</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
		<script language="JavaScript">
		var changeTime = function(){
			document.getElementsByTagName("h3")[0].innerHTML=new Date();
				var t = setTimeout("changeTime()",1000);
		}
			onload=function(){
				changeTime();
			}
		</script>
	</head>
	<body style="text-align: center">
		<h1>欢迎进入好着急后台管理系统</h1>
		<h3></h3>
	</body>
</html>
