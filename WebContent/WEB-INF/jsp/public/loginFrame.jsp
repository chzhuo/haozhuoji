<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>

<style type="text/css">
	#g_cart_cover{position:fixed;background-color:#999999;top:0;left:0;z-index:101;opacity:0.3;display:none}
	#g_login_frame{position:fixed;border:1px solid #999999;z-index:101;background-color:#ffffff;width:450px;height:390px}
	#g_login_frame .loginFrame{float:left;width:340px;height:300px;padding:25px 55px}
	#g_login_frame .loginFrame{font:14px/18px '宋体';color:#666666}
	#g_login_frame .loginFrame .textInput{display:block;border:1px solid #999999;width:333px;font:14px/20px 'microsoft yahei';height:20px;padding:7px 0 7px 5px;margin:5px 0 20px;outline:0}
	#g_login_frame .loginFrame .autoLogin{font:14px/14px '宋体';height:14px;margin:40px 0 20px}
	#g_login_frame .loginFrame .autoLogin input{border:1px solid #999999;float:left}
	#g_login_frame .loginFrame a{font:14px/14px '宋体';color:#3377ff}
	#g_login_frame .submitInput{cursor:pointer;border:0;width:340px;height:36px;display:block;text-align:center;border-radius:3px;font:600 16px/36px '宋体';color:#FFFFFF;background-color:#eb4f3a}
	#g_login_frame .submitInput:hover{background-color:#e55f55}
</style>
<script type="text/javascript">
	function show_login(){
		$("#g_cart_cover").width($(window).width()).height($(window).height()).css({"display":"block"});
		$("#g_login_frame").css({top:($(window).height()-390)/2,left:($(window).width()-450)/2}).css({"display":"block"});
		$(window).resize(function(){
			$("#g_cart_cover").width($(window).width()).height($(window).height()).css({"display":"block"});
			$("#g_login_frame").css({top:($(window).height()-390)/2,left:($(window).width()-450)/2}).css({"display":"block"});
		});
	};
	function close_login(){
		$(window).unbind("resize");
		$("#g_cart_cover").css({"display":"none"});
		$("#g_login_frame").css({"display":"none"});
	}
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
							location.reload();
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
	$(function(){
		login.init();
		show_login();
	});
</script>
<div id="g_cart_cover"></div>
<div id="g_login_frame">			
	<div class="login_top" style="height:29px;border-bottom:1px solid #eeeeee">
		<div style="float:left;height:29px;font:600 14px/29px '宋体';margin:0 5px;color:#999999">您尚未登录</div>
		<div style="float:right;height:29px;width:29px;margin-right:5px;cursor:pointer;text-align:center;font:29px/29px 'microsoft yahei';color:#aaaaaa" onclick="close_login()">×</div>
	</div>
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