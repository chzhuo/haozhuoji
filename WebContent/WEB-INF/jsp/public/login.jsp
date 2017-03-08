<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
		<title>用户登录-好捉急校园便利店</title>
	</head>
	<body style="background-color:#EEEEEE">
		<style type="text/css">
			*{padding:0;margin:0}
			.loginLogo{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/loginLogo.png) no-repeat;width:1000px;margin:25px auto}
			.loginLogo{outline:0}
			.loginLogo a{display:block;height:59px;width:214px;color:#3377ff}
			.bodyStyle{width:950px;height:350px;border:4px solid #DDDDDD;margin:0 auto;background-color:#FFFFFF}
			.imgDiv{float:left;width:500px;height:350px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/loginImg.png) no-repeat}
			.loginFrame{float:left;width:340px;height:300px;padding:25px 55px}
			.loginFrame{font:14px/18px '宋体';color:#666666}
			.loginFrame .textInput{display:block;border:1px solid #999999;width:333px;font:14px/20px 'microsoft yahei';height:20px;padding:7px 0 7px 5px;margin:5px 0 20px;outline:0;}
			.loginFrame .autoLogin{font:14px/14px '宋体';height:14px;margin:40px 0 20px}
			.loginFrame .autoLogin input{border:1px solid #999999;float:left}
			.loginFrame a{font:14px/14px '宋体';color:#3377ff}
			.submitInput{cursor:pointer;border:0;width:340px;height:36px;display:block;text-align:center;border-radius:3px;font:600 16px/36px '宋体';color:#FFFFFF;background-color:#eb4f3a}
			.submitInput:hover{background-color:#e55f55}
		</style>
		<script type="text/javascript">
			$(function(){
				login.init();
			});
			
			var login={
				flag:true,
				init:function(){
					$(".loginFrame .textInput").focus(function(){
						login.closeError();
						$(this).css({'border-color':'#7ABD54'});
					});
					$(".loginFrame .textInput").focusout(function(){
						$(this).css({'border-color':'#999999'});
					});
					$(".loginFrame .submitInput").click(function(){
						if($(".loginFrame .textInput:eq(0)").val()==""){
							login.showError("请输入邮箱！");
							return ;
						}else if(!$(".loginFrame .textInput:eq(0)").val().match("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")){
							login.showError("邮箱格式错误！");
							return ; 
						}
						
						if($(".loginFrame .textInput:eq(1)").val()==""){
							login.showError("请输入密码！");
							return ;
						}else if(!$(".loginFrame .textInput:eq(1)").val().match("^(.){6,20}$")){
							login.showError("密码格式错误");
							return ; 
						}
						
						login.closeError();
						
						if(login.flag){
							login.flag = false;
							var params={
								email:$(".loginFrame .textInput:eq(0)").val(),
								password:$(".loginFrame .textInput:eq(1)").val(),
								autoLogin:$("#isAutoLogin").prop("checked")
							};
							$.post("/loginRegister_login.html",params,function(data){
								data = eval("("+data+")");
								if(data.flag=="true"){
									if(location.href.indexOf("href=")!=-1){
										var href = location.href.split("href=")[location.href.split("href=").length-1];
										if(href==""){
											location.href = '<%=com.haozhuoji.mall.util.Constant.http_p%>';
										}else{
											location.href = href;
										}
									}else{
										location.href = '<%=com.haozhuoji.mall.util.Constant.http_p%>';
									}
								}else{
									login.flag = true;
									$(".loginFrame .textInput:eq(1)").val("");
									login.showError("邮箱和密码不匹配！");
								}
							});
						}
						
					});
				},
				showError:function(message){
					$(".loginFrame .errorDiv").text(message).animate({
						height:"34px"
					},100);
				},
				closeError:function(){
					$(".loginFrame .errorDiv").text("").animate({
						height:"0"
					},100);
				}
			};
		</script>
		<div class="loginLogo">
			<a href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />"></a>
		</div>
		<div class="bodyStyle">
			<div class="imgDiv"></div>
			<div class="loginFrame">
				<form action="/" onsubmit="return false">
				<div class="titilDiv">邮箱</div>
				<input class="textInput" style="background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/userPass.png) no-repeat 306px -2px" autocomplete="off" />
				<div class="titilDiv">密码</div>
				<input class="textInput" style="background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/userPass.png) no-repeat 306px -39px"  type="password" autocomplete="off"/>
				<div class="autoLogin"><input checked="checked" style="height:14px;outline:none;border:0" autocomplete="off" type="checkbox" id="isAutoLogin" />&nbsp;<label for="isAutoLogin">自动登陆</label>&nbsp;&nbsp;&nbsp;&nbsp;<s:a href="%{@com.haozhuoji.mall.util.Constant@http_p}/forgettenPassword.html">忘记密码？</s:a> </div>
				<input class="submitInput" type="submit" value="登  陆" autocomplete="off"/>
				<div class="errorDiv" style="height:0;overflow:hidden;background-color:#FFEBEB;text-align:center;font:14px/34px '宋体';color:#e90000;"></div>
				<div class="noAccount" style="color:#222222;margin-top:10px">没有账号？&nbsp;&nbsp;<a href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/register.html">免费注册</a></div>
				</form>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"/>
	</body>
</html>