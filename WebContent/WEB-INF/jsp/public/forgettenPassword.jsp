<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
		<title>忘记密码-好捉急校园便利店</title>
		<style type="text/css">
			*{padding:0;margin:0}
			.loginLogo{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/getPassword.png) no-repeat;width:1000px;margin:25px auto}
			.loginLogo{outline:0}
			.loginLogo a{display:block;height:59px;width:214px;}
			.bodyStyle{width:950px;height:350px;border:4px solid #DDDDDD;margin:0 auto;background-color:#FFFFFF}
			.imgDiv{float:left;width:500px;height:350px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/forgettenPasswordImg.png)}
			.loginFrame{float:left;width:340px;height:300px;padding:25px 55px}
			.loginFrame{font:14px/18px '宋体';color:#666666}
			.loginFrame .textInput{display:block;border:1px solid #999999;width:333px;font:16px/18px Arial;height:18px;padding:8px 0 8px 5px;margin:5px 0 20px;outline:0}
			.submitInput{margin-top:30px;cursor:pointer;border:0;width:340px;height:36px;display:block;text-align:center;font:600 16px/36px '宋体';color:#FFFFFF;background-color:#eb4a3f;border-radius:3px}
			.submitInput:hover{background-color:#e55f55}
		</style>
		<script type="text/javascript">
			$(function(){
				login.init();
			});
			
			var login={
				flag:true,
				init:function(){
					$(".loginFrame .submitInput").click(function(){
						if($(".loginFrame .textInput:eq(0)").val()==""){
							g_mess.alert("请输入邮箱！");
							return ;
						}else if(!$(".loginFrame .textInput:eq(0)").val().match("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")){
							g_mess.alert("邮箱格式错误！");
							return ; 
						}
						
						if($(".loginFrame .textInput:eq(1)").val()==""){
							g_mess.alert("请输入验证码！");
							return ;
						}else if(!$(".loginFrame .textInput:eq(1)").val().match("^(\\w){4}$")){
							g_mess.alert("验证码格式错误");
							return ; 
						}
						
						if(login.flag){
							login.flag = false;
							var params={
								email:$(".loginFrame .textInput:eq(0)").val().trim(),
								verify:$(".loginFrame .textInput:eq(1)").val().trim()
							};
							$.ajax({
								url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/loginRegister_sendEmail.action",
								data:params,
								success:function(data){
									data = eval("("+data+")");
									if(data.status=="success"){
										location.href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p"/>/sendEmailSuccess.html?email="+data.email;
									}else{
										$(".loginFrame .textInput:eq(1)").val("");
										$("#verify").click();
										g_mess.alert(data.status);
										login.flag=true;
									}
								},
								error:function(){
									g_mess.alert("发送失败，请刷新后再试！")
									login.flag=true;
								},
								beforeSend:function(){
									g_mess.ajax("发送中");
								}
							});
						}
						
					});
				}
			};
		</script>
	</head>
	<body style="background-color:#EEEEEE">
		<s:include value="/WEB-INF/jsp/frame/message.jsp"/>
		<div class="loginLogo">
			<a href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />"></a>
		</div>
		<div class="bodyStyle">
			<div class="loginFrame">
				<form action="/" onsubmit="return false">
				<div class="titilDiv">邮箱</div>
				<input class="textInput" style="background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/userPass.png) no-repeat 306px -2px" autocomplete="off" />
				<div class="titilDiv">验证码</div>
				<div style="overflow:hidden;margin-top:5px">
				<input class="textInput" style="margin:0;float:left;width:150px"  type="verify" autocomplete="off"/>
				<img id="verify" style="margin-left:12px;width:100px;height:36px;float:left" src="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/loginRegister_getVerify.html" onclick="this.src='/loginRegister_getVerify.html?ddddd='+new Date().getTime()" />
				</div>
				<input class="submitInput" type="submit" value="确  定" autocomplete="off"/>
				</form>
				<div style="font-size:12px; padding-top:20px;text-indent:24px">
					填写注册时的邮箱，我们会给您发送一份邮件，通过邮件找回密码！
				</div>
			</div>
			<div class="imgDiv"></div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"/>
	</body>
</html>