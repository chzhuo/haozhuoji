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
			.loginLogo{overflow:hidden;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/getPassword.png) no-repeat;width:1000px;margin:25px auto}
			.loginLogo{outline:0}
			.loginLogo a{display:block;height:59px;width:214px;}
			.bodyStyle{width:950px;height:350px;border:4px solid #DDDDDD;margin:0 auto;background-color:#FFFFFF}
			.imgDiv{float:left;width:500px;height:350px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/.png)}
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
							g_mess.alert("请输入密码！");
							return ;
						}else if(!$(".loginFrame .textInput:eq(0)").val().match("^(.){6,20}$")){
							g_mess.alert("密码格式错误,6-20位字符！");
							return ; 
						}
						
						if($(".loginFrame .textInput:eq(1)").val()==""){
							g_mess.alert("请输入确认密码！");
							return ;
						}else if(!$(".loginFrame .textInput:eq(1)").val().match("^(.){6,20}$")){
							g_mess.alert("确认密码格式错误，6-20位字符！");
							return ; 
						}
						
						if($(".loginFrame .textInput:eq(1)").val()!=$(".loginFrame .textInput:eq(0)").val()){
							g_mess.alert("两次密码输入不一致！");
							return;
						}
						
						if(login.flag){
							login.flag = false;
							var params={
								password:$(".loginFrame .textInput:eq(0)").val().trim(),
								source:$("input[name='source']").val()
							};
							$.ajax({
								url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/changePassword.action",
								data:params,
								success:function(data){
									data = eval("("+data+")");
									if(data.status=="success"){
										location.href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p"/>/successRePassword.html";
									}else{
										g_mess.alert(data.status);
										login.flag=true;
									}
								},
								error:function(){
									g_mess.alert("修改失败，请刷新后再试！")
									login.flag=true;
								},
								beforeSend:function(){
									g_mess.ajax("修改中");
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
			<a style="float:left" href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />"></a>
			<div style="float:left;font:25px/55px 'microsoft yahei';color:#666666;padding-left:120px">-重置密码</div>
		</div>
		<div class="bodyStyle">
			<s:if test="#request.error!=null">
				<div style="text-align:center;font:30px/350px 'microsoft yahei';color:#333333">该链接错误或已失效，参数错误！</div>
			</s:if>
			<s:else>
				<div class="loginFrame">
					<form action="/" onsubmit="return false">
					<s:hidden value="%{#request.source}" name="source" />
					<div class="titilDiv">密码</div>
					<input class="textInput" type="password" style="background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/userPass.png) no-repeat 306px -39px" autocomplete="off" />
					<div class="titilDiv">确认密码</div>
					<input class="textInput" type="password" style="background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/loginRegister/userPass.png) no-repeat 306px -39px" autocomplete="off" />
					<input class="submitInput" type="submit" value="确定修改" autocomplete="off"/>
					</form>
				</div>
				<div class="imgDiv"></div>
			</s:else>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"/>
	</body>
</html>