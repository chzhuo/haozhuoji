<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"></s:include>
		<title>个人中心 -好捉急校园便利店</title>
		<style type="text/css">
			.uc_right .inputItem{height:36px;overflow:hidden;margin-bottom:30px}
			.uc_right .genderRadio{float:left;width:243px;padding:10px 0;overflow:hidden}
			.uc_right .genderRadio input{float:left;font:14px/14px 'mircosoft yahei';}			
			.uc_right .genderRadio label{float:left;font:14px/14px 'mircosoft yahei';padding-right:5px}			
			.uc_right .titilDiv{float:left;font:14px/36px '宋体';width:150px;text-align:right;color:#666666}
			.uc_right .titilDiv span{color:#EB4A3F;}
			.uc_right .textInput{float:left;display:block;border:1px solid #999999;width:243px;font:14px/14px 'mircosoft yahei';height:14px;padding:7px 0 7px 2px;outline:0;margin:3px 0}
			.uc_right .errorDiv{margin-left:10px;width:250px;height:34px;border:1px solid #ffffff;color:#eb4a3f;float:left;font:12px/34px '宋体';padding:0 10px}
			.uc_right .autoregister{font:14px/14px '宋体';height:14px;margin:40px 0 20px}
			.uc_submitInput{float:left;margin:7px 0 7px 150px;width:50px;border:1px solid #999999;height:20px;text-align:center;line-height:20px}
		</style>
		<script type="text/javascript">
			$(function(){
				$("#uc_form").submit(function(){
					if(uc_check()){
						var name = $(".textInput[name='name']").val().trim();
						var nickName = $(".textInput[name='nickName']").val().trim();
						var studentID = $(".textInput[name='studentID']").val().trim();
						var gender = $("input[name='gender']:checked").val().trim();
						$.ajax({
							url:"<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/user_updateUser.action",
							type:"post",
							data:{nickName:nickName,name:name,studentID:studentID,gender:gender},
							success:function(data){
								if(data=="success"){
									location.reload();
								}else{									
									$(".uc_sf_errorDiv").text(data);
								}
							},
							error:function(data){
								$(".uc_sf_errorDiv").text("更新失败，请刷新后再试");
							}
						});
						return false;
					}
					return false;
				});
				uc_check=function(){
					var ret = true;
					var i = $(".textInput[name='nickName']");
					var e = i.closest(".inputItem").find(".errorDiv");
					var m = i.val().trim();
					if(m==""){
						e.text("昵称不能为空！");
						ret = false;
					}else if(!m.match("^(.){1,15}$")){
						e.text("昵称格式错误，可为中英文，长度小于15!");
						ret = false;
					}
					
					var i = $(".textInput[name='name']");
					var e = i.closest(".inputItem").find(".errorDiv");
					var m = i.val().trim();
					if(m!=""&&!m.match("^([\u0391-\uFFE5]){2,10}$")){
						e.text("姓名格式错误，2-10个汉字！");
						ret = false;
					}
					
					var i = $(".textInput[name='studentID']");
					var e = i.closest(".inputItem").find(".errorDiv");
					var m = i.val().trim();
					if(m!=""&&!m.match("^201\\d{9,9}$")){
						e.text("学号格式错误！");
						ret = false;
					}
					return ret;
				};
			});
		</script>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp" />
		<s:include value="/WEB-INF/jsp/user/userCenter/headerStyle.jsp" />
		<div class="uc_title">
			个人中心
		</div>
		<div class="uc_frame">
			<s:include value="/WEB-INF/jsp/user/userCenter/menu.jsp" />
			<div class="uc_right">
				<s:form id="uc_form" action="%{@com.haozhuoji.mall.util.Constant@user_p}/user_updateUser.html" method="post" onSubmit="return false">
					<div class="inputItem">
						<div class="titilDiv"><span>*</span>&nbsp;昵称：</div>
						<s:textfield cssClass="textInput" name="nickName" autocomplete="off"  />
						<div class="errorDiv"></div>
					</div>
					<div class="inputItem">
						<div class="titilDiv">性别：</div>
						<div class="genderRadio">
							<input id="uc_form_genderfalse" type="radio" value="false" <s:if test="!gender">checked='checked'</s:if> name="gender" autocomplete="off" />
							<label for="uc_form_genderfalse">女</label>
							<input id="uc_form_gendertrue" type="radio" value="true" <s:if test="gender">checked='checked'</s:if> name="gender" autocomplete="off" />
							<label for="uc_form_gendertrue">男</label>
						</div>
						<div class="errorDiv"></div>
					</div>
					<div class="inputItem">
						<div class="titilDiv">真实姓名：</div>
						<s:textfield cssClass="textInput" name="name" autocomplete="off"  />
						<div class="errorDiv"></div>
					</div>
					<div class="inputItem">
						<div class="titilDiv">学号：</div>
						<s:textfield cssClass="textInput" name="studentID" autocomplete="off"  />
						<div class="errorDiv"></div>
					</div>
					<div class="submitFrame">
						<input class="uc_submitInput" type="submit" value="提交" autocomplete="off"/>
						<div class="uc_sf_errorDiv errorDiv"></div>
					</div>
				</s:form>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp" />
	</body>
</html>