<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
		<title>邮件发送成功-好捉急校园便利店</title>
		<style type="text/css">
			*{padding:0;margin:0}
			.loginLogo{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/getPassword.png) no-repeat;width:1000px;margin:25px auto}
			.loginLogo{outline:0}
			.loginLogo a{display:block;height:59px;width:214px;}
			.bodyStyle{width:950px;height:350px;border:4px solid #DDDDDD;margin:0 auto;background-color:#FFFFFF}
		</style>
	</head>
	<body style="background-color:#EEEEEE">
		<s:include value="/WEB-INF/jsp/frame/message.jsp"/>
		<div class="loginLogo">
			<a href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />"></a>
		</div>
		<div class="bodyStyle">
			<div >
				<div style="padding-left:100px;padding-right:50px;font-size:200px;color:#eb4a3f;line-height:350px;float:left">√</div>
				<div style="font:30px/350px 'microsoft yahei';color:#333333">密码修改成功，立即<s:a onmouseover="this.style.color='#eb4a3f'" cssStyle="color:#333333;text-decoration:underline" href="%{@com.haozhuoji.mall.util.Constant@http_p}/login.html" >登录账户</s:a></div>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"/>
	</body>
</html>