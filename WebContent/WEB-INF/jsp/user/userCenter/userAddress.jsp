<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"></s:include>
		<title>个人中心 -好捉急校园便利店</title>
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
				<script type="text/javascript">
				$(function(){
							//update address button
							$(".updateAddress").click(function(){
								$(".addressFrame[curr]").css({"display":"block"}).removeAttr("curr");
								var $curr = $(this).closest(".addressFrame");
								var $add = $(".recevice .addAddress").css({'display':'block'});
								$add.find("input:eq(0)").val($curr.find("span:eq(0)").text());
								$add.find("input:eq(1)").val($curr.find("span:eq(1)").text());
								$add.find("input:eq(2)").val($curr.find("span:eq(2)").text());
								$add.attr("addressID",$curr.attr("addressID"));
								$curr.after($add).css({'display':'none'}).attr("curr","curr");
								return false;
							});
							//cancel add address button
							$(".addAddress .right a:eq(1)").click(function(){
								address.cancel();
							});
							//add address ajax
							$(".addAddress .right a:eq(0)").click(function(){
								if(address.validate()){
									var $addAddress = $(".addAddress");
									var p={
										addressID:$addAddress.attr("addressID"),
										name:$addAddress.find("input[name='name']").val(),
										cellphone:$addAddress.find("input[name='cellphone']").val(),
										address:$addAddress.find("input[name='address']").val(),
									};
									if($addAddress.attr("addressID")==null){
										$.ajax({
											type:"post",
											url:'<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/address_addAjax.action',
											data:p,
											success:function(data){
												data = eval("("+data+")");
												if(data.addressID!=null){
													address.add(data.addressID);
												}else{
													 g_mess_show(null,data.mesage,null);
												}
											},
											error:function(){
												g_mess_show(null,"增加失败，请刷新后重试！",null);
											}
										});
									}else{
										$.ajax({
											type:"post",
											url:'<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/address_updateAjax.action',
											data:p,
											success:function(data){
												if(data==""){
													address.update();
												}else{
													data = eval("("+data+")");
													g_mess_show(null,data.mesage,null);
												}
											},
											error:function(){
												g_mess_show(null,data.mesage,null);
												g_mess_show(null,"修改失败，请刷新后重试！",null);
											}
										});
									}
								}
							});
							// add address
							$(".recevice .newAddress a").click(function(){
								$(".addressFrame[curr]").css({"display":"block"}).removeAttr("curr");
								var $curr = $(this).closest(".addressFrame").css({"display":"none"}).attr("curr","curr");
								var $add = $(".recevice .addAddress").css({'display':'block'}).removeAttr("addressID");
								$curr.before($add);
								$add.find("input:eq(0)").val("");
								$add.find("input:eq(1)").val("");
								$add.find("input:eq(2)").val("");
							});
							//delete address
							$(".deleteAddress").click(function(){
								if(confirm("确认删除？")){									
									var addressID = $(this).closest(".addressFrame").attr("addressID");
									$.ajax({
										type:"post",
										data:{"addressID":addressID},
										url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/address_deleteAjax.action",
										success:function(data){
											if(data==""){
												$(".addressFrame[addressID='"+addressID+"']").remove();
												params.addressID=null;
												$(".bottomAddress").html("");
											}else{
												data = eval("("+data+")");
												g_mess_show(null,data.mesage,null);
											}
										},
										error:function(){
											g_mess_show(null,"删除失败，请刷新后重试！",null);									
										}
									});
								}
								});
							//set default address
							$(".setDefault").click(function(){
								var $target = $(this).closest(".trueAddress");
								$.ajax({
									type:"post",
									data:{"addressID":$target.attr("addressID")},
									url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/address_setDefaultAjax.action",
									success:function(data){
										if(data==""){
											$(".setDefault").each(function(){
												if($(this).css("visibility")=="hidden"){
													$(this).css({"visibility":"visible"});
												}
											});
											$target.find(".setDefault").css({"visibility":"hidden"});
										}else{
											data = eval("("+data+")");
											g_mess_show(null,data.mesage,null);								
										}
									},
									error:function(){
										g_mess_show(null,"设置失败，请刷新后重试！",null);
									}
								});
								return false;
							});
						});
					var address={
						//cancel add or update
						cancel:function(){
							var $curr = $(".addAddress");
							$(".addressFrame[curr]").css({"display":"block"}).removeAttr("curr");
							$curr.css({"display":"none"});
						},
						//validate address
						validate:function(){
							if(!$(".addAddress input[name='name']").val().match("^([\u0391-\uFFE5]){2,10}$")){
								g_mess_show(null,"姓名格式错误，2-10个汉字！",null);
								return false;
							}
							if(!$(".addAddress input[name='cellphone']").val().match("^1\\d{10}$")){
								g_mess_show(null,"手机号码格式错误！",null);
								return false;
							}
							if(!$(".addAddress input[name='address']").val().match("^\.{1,25}$")){
								g_mess_show(null,"地址格式错误，1-25个字符！",null);								
								return false;
							}
							return true;
						},
						//add address to docuemnt
						add:function(addressID){
							var $add = $(".addressFrame[clone_address]").clone(true).css({'display':'block'}).attr({"addressID":addressID}).removeAttr("clone_address");
							$(".newAddress").css({"display":"block"}).before($add);
							$add.find("span:eq(0)").text($(".addAddress input[name='name']").val());
							$add.find("span:eq(1)").text($(".addAddress input[name='cellphone']").val());
							$add.find("span:eq(2)").text($(".addAddress input[name='address']").val());
							address.cancel();
						},
						//update address to docuemnt
						update:function(){
							var $add = $(".addressFrame[curr]");
							$add.find("span:eq(0)").text($(".addAddress input[name='name']").val());
							$add.find("span:eq(1)").text($(".addAddress input[name='cellphone']").val());
							$add.find("span:eq(2)").text($(".addAddress input[name='address']").val());
							address.cancel();
						}
					};
				</script>
		  		<%--收货地址 --%>
				<style type="text/css">
					.item_frame{width:745px;overflow:hidden;}
					.recevice .addressFrame{font:12px/22px '宋体';padding:0px 30px;overflow:hidden;}
					.recevice .addressFrame span{float:left;margin-right:15px}
					.recevice .addressFrame a{color:#3377FF;text-decoration:none}
					.recevice .addressFrame a:hover{text-decoration:underline;}
					.recevice .addressFrame .right{float:right}
					.recevice .addAddress input{font:12px/12px '宋体';padding:4px;width:120px;border:1px solid #dddddd;margin:0;float:left;line-height:12px}
					.recevice .addAddress{display:none}
					.recevice .addAddress span{margin-right:0;line-height:22px}
					.trueAddress:hover{background-color:#eeeeee}
				</style>
				<div class="recevice item_frame">
					<s:iterator value="#request.addressList">
						<div class="addressFrame trueAddress" addressID="<s:property value="addressID" />" >
							<span><s:property value="name" /></span><span><s:property value="cellphone" /></span><span><s:property value="address" /></span>
							<div class="right">
							<s:if test="%{(flag&1)==0}">
								<a class="setDefault" href="javascript:void(0)">设为默认</a>
							</s:if>
							&nbsp;<a href="javascript:void(0)" class="updateAddress">修改</a>&nbsp;<a class="deleteAddress" href="javascript:void(0)">删除</a></div>
						</div>
					</s:iterator>
					<div class="addressFrame trueAddress" style="display:none" clone_address="clone_address">
						<span></span><span></span><span></span>
						<div class="right"><a class="setDefault" href="javascript:void(0)">设为默认</a>&nbsp;<a href="javascript:void(0)" class="updateAddress">修改</a>&nbsp;<a class="deleteAddress" href="javascript:void(0)">删除</a></div>
					</div>
					<div class="addressFrame newAddress">
						<a href="javascript:void(0)">增加地址</a>
					</div>
					<div class="addressFrame addAddress">
						<span>姓名：</span><input autocomplete="off" name="name" /><span>&nbsp;&nbsp;手机号码：</span><input autocomplete="off" name="cellphone" /><span>&nbsp;&nbsp;地址：</span><input autocomplete="off" name="address" />
						<div class="right"><a href="javascript:void(0)">确定</a>&nbsp;<a href="javascript:void(0)">取消</a></div>
					</div>
				</div>
				<script type="text/javascript">
					$(function(){
						 $("#g_mess_remain .g_mess_title").mousedown(function(e){  
			                var offset = $("#g_mess_remain").offset();
			                var x = e.pageX - offset.left;
			                var y = e.pageY - offset.top;
			                $(document).bind("mousemove",function(ev){  
			                    $("#g_mess_remain").stop();
			                    var _x = ev.pageX - x;
			                    var _y = ev.pageY - y;
			                    $("#g_mess_remain").animate({left:_x+"px",top:_y+"px"},0);  
			                });  
			            });
			            $(document).mouseup(function(){  
			                 $(this).unbind("mousemove");  
			            });  
			            g_mess_show=function(title,content,confirm){			            	
			            	$("#g_mess_remain").css({display:"block"});
			            	$("#g_mess_remain .g_mess_title").text(title==null?'提示':title);
			            	$("#g_mess_remain .g_mess_message").text(content);
			            	$("#g_mess_remain .g_mess_confirm").text(title==null?'确定':title);
			            };
			            g_mess_close=function(){
			            	$("#g_mess_remain").css({display:"none"});
			            };
			            $("#g_mess_remain .g_mess_confirm").click(function(){
			            	g_mess_close();
			            });
					});
				</script>
				<style type="text/css">
					#g_mess_remain{background-color:#ffffff;width:300px;box-shadow:0 0 10px #eb4a3f;border:1px solid #F6ABA6;position:absolute;z-index:999;display:none}
					#g_mess_remain .g_mess_title{height:20px;border-bottom:1px solid #eeeeee;background-color:#fafafa;font:12px/20px 'microsoft yahei';text-indent:6px;cursor:move}
					#g_mess_remain .g_mess_message{padding:10px;height:40px;color:#eb4a3f;font:12px/20px '宋体';text-indent:24px}
					#g_mess_remain .g_mess_confirm{height:15px;padding:3px 0;width:100px;margin:0 auto 5px;font:12px/15px 'microsoft yahei';text-align:center;cursor:pointer;background-color:#cccccc;color:#ffffff;border-radius:3px}
					#g_mess_remain .g_mess_confirm:hover{background-color:#aaaaaa}
				</style>
				<div id="g_mess_remain">
					<div class="g_mess_title">提示</div>
					<div class="g_mess_message"></div>
					<div class="g_mess_confirm">确定</div>
				</div>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp" />
	</body>
</html>