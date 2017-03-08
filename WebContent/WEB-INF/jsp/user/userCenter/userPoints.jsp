<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"></s:include>
		<title>个人中心-我的积分 -好捉急校园便利店</title>
		<style type="text/css">
			.uc_title{height:20px;width:1000px;margin:0 auto;padding:10px 5px;font:20px/20px 'microsoft yahei';color:#333333}
			.uc_frame{width:1000px;margin:0 auto;overflow:hidden}
			.uc_right{width:780px;margin-left:18px;float:left;box-shadow:0 0 6px #eeeeee;overflow:hidden}
			table{border-collapse:collapse;width:100%;vertical-align:center}
			a{cursor:pointer}
			td{border:1px solid #DDDDDD;text-align:center;height:30px}
			.up_title{color:#eb4a3f;font-size:20px}
			.comfirmConvert{color:#3377ff;text-decoration:none}
			.comfirmConvert:hover{text-decoration:underline;}
		</style>
		<script type="text/javascript">
			$(function(){
				$("tr:even").css("background-color","#f9f9f9");
				$("tr:odd").css("background-color","#fefefe");
				$("tr:gt(0)").hover(function(){
					$(this).css("background-color","#CEE3F7");
				},function(){					
					$("tr:even").css("background-color","#f9f9f9");
					$("tr:odd").css("background-color","#fefefe");
				});
				$(".comfirmConvert").click(function(){
					var tr= $(this).closest("tr");
					g_mess.show({content:"确认兑换",title:"提示",confirm:function(){
						$.ajax({
							url:"<s:property value="@com.haozhuoji.mall.util.Constant@user_P" />/user/user_exchangePoints.action",
							type:"post",
							data:{pointToCouponID:tr.attr("pointToCouponID"),updateTimeStamp:tr.attr("updateTimeStamp")},
							beforeSend:function(){
								g_mess.show({showAjax:true,title:'正在兑换'});
							},
							success:function(data){
								if(data=="success"){
									g_mess.show({content:"兑换成功",title:"提示",showCancel:false,confirm:function(){g_mess.close();location.reload();}});
								}else{
									g_mess.show({content:data,title:"提示",showCancel:false,confirm:function(){g_mess.close();}});
								}
							},
							error:function(){
								g_mess.show({content:"兑换失败，请刷新后重试！",title:"提示",showCancel:false,confirm:function(){g_mess.close();}});
							}
						});
					},cancel:function(){g_mess.close();}});
				});
			});
		</script>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp" />
		<s:include value="/WEB-INF/jsp/user/userCenter/headerStyle.jsp" />
		<s:include value="/WEB-INF/jsp/frame/message.jsp" />
		<div class="uc_title">
			个人中心
		</div>
		<div class="uc_frame">
			<s:include value="/WEB-INF/jsp/user/userCenter/menu.jsp" />
			<div class="uc_right">
				我的积分：<span class="up_title"><s:property value="points" /></span>
				<br />
				<br />
				积分兑换
				<table>
					<tr class="header">
						<td class="width2">兑换内容</td>
						<td class="width4">所需积分</td>
						<td class="width4">使用范围</td>
						<td class="width5">起始使用时间</td>
						<td class="width5">过期时间</td>
						<td class="width3" style="width:100px">操作</td>
					</tr>
					<s:set value="points" var="userPoints" />
					<s:iterator value="#request.pointToCouponList">
						<tr pointToCouponID="<s:property value="pointToCouponID" />" updateTimeStamp="<s:property value="updateTimeStamp" />" />
							<td>
							<s:if test="rech==sub">
								<span><s:property value="@com.haozhuoji.mall.util.Arith@format(sub)"/></span> 元代金券
							</s:if>
							<s:else>
								 满<span><s:property value="@com.haozhuoji.mall.util.Arith@format(rech)" /></span> ，减 <span><s:property value="@com.haozhuoji.mall.util.Arith@format(sub)"/></span>  
							</s:else>
							</td>
							<td><s:property value="points" /></td>
							<td><s:property value="fullTypeName" /></td>
							<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format_dateTime(beginDateTime)" /></td>
							<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format_dateTime(endDateTime)" /></td>
							<td>
							<s:if test="#userPoints>=points">
								 <a class="comfirmConvert" href="javascript:void(0)" >兑换</a>
							</s:if>
							<s:else>
								积分不足
							</s:else>
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
		</div>
	</body>
</html>