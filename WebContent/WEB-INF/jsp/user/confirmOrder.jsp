<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title>订单确认-好捉急校园便利店</title>
	<s:include value="/WEB-INF/jsp/frame/headMeta.jsp"/>
	<s:include value="/WEB-INF/jsp/frame/message.jsp"/>
	<s:include value="../frame/headMeta.jsp"></s:include>
	<script type="text/javascript" src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/js/jquery.cookie.js"></script>
	<script type="text/javascript">
		function format(num) {
		    num = num.toString().replace(/\$|\,/g,'');
		    if(isNaN(num))
		    num = "0";
		    sign = (num == (num = Math.abs(num)));
		    num = Math.floor(num*100+0.50000000001);
		    cents = num%100;
		    num = Math.floor(num/100).toString();
		    if(cents<10)
		    cents = "0" + cents;
		    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
		    num = num.substring(0,num.length-(4*i+3))+','+
		    num.substring(num.length-(4*i+3));
		    return (((sign)?'':'-') + num + '.' + cents);
		};
		//globe parameters
		var init={
				emLeft:62,
				emTop:23
		};
		//return parameters
		var params={
			rechSendPrice:<s:property value="@com.haozhuoji.mall.util.Constant@rechSendPrice" />,
			addSendPrice:<s:property value="@com.haozhuoji.mall.util.Constant@addSendPrice" />,
			sendPrice:<s:property value="#request.order.send_price==null?0:#request.order.send_price" />,
			couponNumber:"<s:property value="#request.order.coupon.couponNumber"/>",
			activitySub:"<s:property value="#request.order.activitySub"/>",
			orderTimeStamp:"<s:property value="#request.orderTimeStamp"/>",
			addressID:null,
			date:null,
			periodID:null,
			timePeriod:null
		};
		//error message of delete
		var em={
				show:function(message,offset){		
					$(".em_errorMess .em_title").text(message);
					$(".em_errorMess").offset({"left":$(this).offset().left-offset.left+init.emLeft,"top":$(this).offset().top+init.emTop}).css({"visibility":"visible"});
				},
				hide:function(){
					$(".em_errorMess").css({"visibility":"hidden"});
				}
		};
		//globe message
		$(function(){
			$("#g_mess_frame input").click(function(){
				g_message.hide();
			});
		});
		var g_message={
				show:function(message,flag){
					if(flag){
						$("#g_mess_frame .ajax").css({"display":"none"});
						$("#g_mess_frame input").css({"display":"block"});
					}else{
						$("#g_mess_frame .ajax").css({"display":"block"});
						$("#g_mess_frame input").css({"display":"none"});
					}
					$("#g_mess_frame .message").text(message);
					$("#g_cover").width($(window).width()).height($(window).height()).css({"display":"block"});
					$("#g_mess_frame").css({top:($(window).height()-100)/2,left:($(window).width()-300)/2}).css({"display":"block"});
					$(window).resize(function(){
						$("#g_cover").width($(window).width()).height($(window).height()).css({"display":"block"});
						$("#g_mess_frame").css({top:($(window).height()-100)/2,left:($(window).width()-300)/2}).css({"display":"block"});
					});
				},
				hide:function(){
					$(window).unbind("resize");
					$("#g_cover").css({"display":"none"});
					$("#g_mess_frame").css({"display":"none"});					
				}
		};
	</script>
</head>
	
	
<body>
		<%--头部 --%>
		<s:include value="/WEB-INF/jsp/frame/topStatus.jsp"></s:include>
		<style type="text/css">
			.topBar .topBar_content{width:1000px}
			.totalTitle{width:1000px;margin:20px auto;position:relative;}
			.totalTitle h1{color:#333333}
  			.em_errorMess{visibility :hidden;width:140px;height:45px;border:1px solid #dddddd;box-shadow:1px 1px 1px #dddddd;padding:5px;border-radius:2px;overflow:visible;position:absolute;z-index:10;background-color:#ffffff;right:100px}
  			.em_errorMess span{position:absolute;font:20px/20px 'Arial';float:left}
  			.em_errorMess .first{color:#cccccc;top:-11px;right:20px}
  			.em_errorMess .second{color:#ffffff;top:-10px;right:20px}
  			.em_title{height:20px;width:140px;float:left;text-align:center;font:12px/20px 'Arial';padding-bottom:5px;color:#333333}
  			.em_errorMess a{margin:0 5px;width:60px;float:left;text-align:center;text-decoration:none;font:12px/20px 'Arial';background:#eeeeee;color:#3377FF;border-radius:2px}
  			.em_errorMess a:hover{text-decoration:underline;color:#3377FF}
  			
  			#g_cover{position:fixed;background-color:#999999;top:0;left:0;z-index:101;opacity:0.3;display:none}
  			#g_mess_frame{display:none;width:300px;height:100px;border:1px solid #999999;box-shadow:0 0 3px #999999;z-index:101;position:fixed;background-color:#ffffff}
  			#g_mess_frame .message{width:300px;height:30px;font:20px/30px 'microsoft yahei';text-align:center;padding:10px 0;color:#666666}
  			#g_mess_frame input{display:block;height:30px;font:18px/30px 'microsoft yahei';text-align:center;margin:8px 30px;background-color:#eb4f3a;width:240px;border:0;cursor:pointer;color:#ffffff;border-radius:3px}
  			#g_mess_frame .ajax{height:30px;margin:8px 30px;width:240px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/ajax/ajax-b.gif) no-repeat center center; }
  			#g_mess_frame input:hover{background-color:#eb4f3a}
		</style>
		<div id="g_cover"></div>
		<div id="g_mess_frame">
			<div class="message">订单多</div>
			<div class="ajax"></div>
			<input type="button" value="确定" />
		</div>
  		<div class="totalTitle">
  			<h1>结算中心</h1>
	  		<div class="em_errorMess">
	  			<div class="em_title">顶顶顶顶</div>
	  			<a href="javascript:void(0)">确定</a>
	  			<a href="javascript:void(0)">取消</a>
	  			<span class="first">◆</span>
	  			<span class="second">◆</span>
	  		</div>
  		</div>
  		
		<script type="text/javascript">
		//address
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
							address:$addAddress.find("input[name='address']").val()
						};
						if(p.adddressID==null||p.addressID==""){
							$.ajax({
								type:"post",
								url:'<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/address_addAjax.html',
								data:p,
								success:function(data){
									data = eval("("+data+")");
									if(data.addressID!=null){
										g_message.hide();
										address.add(data.addressID);
									}else{
										g_message.show(data.message,true);									
									}
								},
								beforeSend:function(){
									g_message.show("增加中。。。",false);
								},
								error:function(){
									g_message.show("增加失败，请刷新后重试！",true);
								}
							});
						}else{
							$.ajax({
								type:"post",
								url:'<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/address_updateAjax.html',
								data:p,
								success:function(data){
									if(data==""){
										g_message.hide();
										address.update();
									}else{
										data = eval("("+data+")");
										g_message.show(data.message,true);									
									}
								},
								beforeSend:function(){
									g_message.show("修改中。。。",false);
								},
								error:function(){
									g_message.show("修改失败，请刷新后重试！",true);
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
					em.show.call(this,"确认删除？",$(this).closest(".addressFrame").offset());
					var addressID = $(this).closest(".addressFrame").attr("addressID");
					$(".em_errorMess a:eq(1)").click(function(){
						em.hide();
					});
					$(".em_errorMess a:eq(0)").click(function(){
						em.hide();
						$.ajax({
							type:"post",
							data:{"addressID":addressID},
							url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/address_deleteAjax.action",
							success:function(data){
								if(data==""){
									g_message.hide();
									$(".addressFrame[addressID='"+addressID+"']").remove();
									params.addressID=null;
									$(".bottomAddress").html("");
								}else{
									data = eval("("+data+")");
									g_message.show(data.message,true);									
								}
							},
							beforeSend:function(){
								g_message.show("删除中。。。",false);
							},
							error:function(){
								g_message.show("删除失败，请刷新后重试！",true);
							}
						});
					});
					return false;
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
								g_message.hide();
								$(".setDefault").each(function(){
									if($(this).css("visibility")=="hidden"){
										$(this).css({"visibility":"visible"});
									}
								});
								$target.find(".setDefault").css({"visibility":"hidden"});
							}else{
								data = eval("("+data+")");
								g_message.show(data.message,true);									
							}
						},
						beforeSend:function(){
							g_message.show("设置中。。。",false);
						},
						error:function(){
							g_message.show("设置失败，请刷新后重试！",true);
						}
					});
					return false;
				});
				//select target address
				$(".trueAddress").click(function(){
					$(".trueAddress").css({"background-color":"#ffffff","color":"#333333"});
					$(this).css({"background-color":"#eeeeee","color":"#eb4a3f"}).find("input").prop("checked",true);
					$(".bottomAddress").html($(this).find("span:eq(0)").text()+"&nbsp;&nbsp;"+$(this).find("span:eq(1)").text()+"&nbsp;&nbsp;"+$(this).find("span:eq(2)").text());
					params.addressID=$(this).attr("addressID");
					$.cookie("addressID",''+params.addressID);
				});
				$(".trueAddress").hover(function(){
					if(!$(this).find("input").prop("checked")){
						$(this).css({"background-color":"#eeeeee"});
					}
				},function(){
					if(!$(this).find("input").prop("checked")){
						$(this).css({"background-color":"#ffffff"});
					}
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
					g_message.show("姓名格式错误，2-10个汉字！",true);
					return false;
				}
				if(!$(".addAddress input[name='cellphone']").val().match("^1\\d{10}$")){
					g_message.show("手机号码格式错误！",true);
					return false;
				}
				if(!$(".addAddress input[name='address']").val().match("^\.{1,25}$")){
					g_message.show("地址格式错误，1-25个字符！",true);
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
			.item_frame{width:1000px;border:1px solid #cccccc;overflow:hidden;margin:0 auto 40px;border-radius:2px;color:#333333;font:12px/12px 'Arial'}
			.item_frame .title{text-indent:10px;width:1000px;height:30px;border-bottom:1px solid #dddddd;color:#333333;font:16px/30px 'microsoft yahei';background-color:#f3f3f3}
			.recevice .addressFrame{font:12px/22px '宋体';padding:5px 30px;overflow:hidden;position:relative;}
			.recevice .addressFrame input{float:left;margin:4px 5px 5px 0;outline:0;}
			.recevice .addressFrame span{float:left;margin-right:15px}
			.recevice .addressFrame a{color:#3377FF;text-decoration:none}
			.recevice .addressFrame a:hover{text-decoration:underline;}
			.recevice .addressFrame .right{float:right}
			.recevice .addAddress>input{height:12px;width:150px;padding:4px;border:1px solid #dddddd;margin:0;}
			.recevice .addAddress{display:none}
			.recevice .addAddress>span{margin-right:0;}
			.trueAddress{cursor:pointer}
		</style>
		<div class="recevice item_frame">
			<div class="title">收货地址</div>
			<s:iterator value="#request.addressList">
				<div class="addressFrame trueAddress" addressID="<s:property value="addressID" />" >
					<input type="radio" autocomplete="off" name="addressRadio" />
					<span><s:property value="name" /></span><span><s:property value="cellphone" /></span><span><s:property value="address" /></span>
					<div class="right">
					<s:if test="%{flag&1==1}">
						<a class="setDefault" href="javascript:void(0)" style="visibility:hidden">设为默认</a>
					</s:if>
					<s:else>
						<a class="setDefault" href="javascript:void(0)">设为默认</a>
					</s:else>
					&nbsp;<a href="javascript:void(0)" class="updateAddress">修改</a>&nbsp;<a class="deleteAddress" href="javascript:void(0)">删除</a></div>
				</div>
			</s:iterator>
			<div class="addressFrame trueAddress" style="display:none" clone_address="clone_address">
				<input type="radio" autocomplete="off" name="addressRadio" />
				<span></span><span></span><span></span>
				<div class="right"><a class="setDefault" href="javascript:void(0)">设为默认</a>&nbsp;<a href="javascript:void(0)" class="updateAddress">修改</a>&nbsp;<a class="deleteAddress" href="javascript:void(0)">删除</a></div>
			</div>
			<div class="addressFrame newAddress">
				<a href="javascript:void(0)">+使用新地址</a>
			</div>
			<div class="addressFrame addAddress">
			<span>姓名：</span><input autocomplete="off" name="name" /><span>&nbsp;&nbsp;手机号码：</span><input autocomplete="off" name="cellphone" /><span>&nbsp;&nbsp;地址：</span><input autocomplete="off" name="address" />
				<div class="right"><a href="javascript:void(0)">确定</a>&nbsp;<a href="javascript:void(0)">取消</a></div>
			</div>
		</div>
	 <%--配送时段 --%>
		<script type="text/javascript">
			$(function(){			
				$(".timePeriod").hover(function(){
					if($(this).attr("pflag")==null){
						$(this).css({"color":"#eb4a3f","border-color":"#eb4a3f"});
					}
				},function(){
					if($(this).attr("pflag")==null){
						$(this).css({"color":"#333333","border-color":"#999999"});
					}					
				}).click(function(){
					$(".timePeriod[pflag]").removeAttr("pflag").css({"color":"#333333","border-color":"#999999"});
					$(this).attr("pflag","pflag").css({"color":"#eb4a3f","border-color":"#eb4a3f"});
					params.periodID = $(this).attr("periodID");
					params.timePeriod = $(this).text().trim();
					params.date = $("#dayChooser").val().trim();
					$.cookie("periodID", params.periodID); 
					$(".bottomPeriod span:eq(1)").text($(this).text());
				});
				//change period time of day
				$("#dayChooser").change(function(){
					$(".receviceTime .periodFrame").css({display:'none'});
					$(".receviceTime .periodFrame[day='"+$(this).val()+"']").css({display:'block'});
					$(".bottomPeriod span:eq(0)").text($(this).val()+" "+$("#dayChooser option[value='"+$("#dayChooser").val()+"']").text());
				});
				$("#dayChooser").change();
			});
		</script>
		<style type="text/css">
			.dayChoose{padding:10px 30px 20px;width:940px;}
			.receviceTime{margin:1px 15px;overflow:hidden}
			.receviceTime>div>div{width:162px;font:16px/40px 'microsoft yahei';text-align:center;float:left;margin:15px}
			.receviceTime .timePeriod{border:1px solid #999999;cursor:pointer;float:left}
			.receviceTime .noTimePeriod{border:1px dashed #dddddd;color:#dddddd;float:left};
		</style>
		<div class="item_frame">
			<div class="title">收货时间</div>
			<div class="dayChoose" >
				选择日期：
				<select id="dayChooser" autocomplete="off">
					<option value="<s:property value="#request.todayDate" />">当日（<s:property value="#request.todayWeek" />）</option>
					<option value="<s:property value="#request.tomDate" />">明日（<s:property value="#request.tomWeek" />）</option>
				</select>
				<br/>
			</div>
			<div class="receviceTime">
				<span style="padding-left:15px;display:block">选择时段：</span>
				<div class="periodFrame" day="<s:property value="#request.todayDate" />">
					<s:iterator value="#request.todayPeriod">
						<s:if test="outTime">
							<div periodID="<s:property value="periodID"/>" class="timePeriod"/><s:property value="timePeriod" /></div>
						</s:if>
						<s:else>
							<div periodID="<s:property value="periodID"/>" class="noTimePeriod"/><s:property value="timePeriod" /></div>
						</s:else>
					</s:iterator>
				</div>
				<div class="periodFrame" style="display:none" day="<s:property value="#request.tomDate" />">
					<s:iterator value="#request.tomPeriod">
						<div periodID="<s:property value="periodID"/>" class="timePeriod"/><s:property value="timePeriod" /></div>
					</s:iterator>
				</div>
			</div>
		</div>
		
		<%--商品列表 --%>
		<style type="text/css">
			.goodsList .goodsName{width:500px;heigth:60px;overflow:hidden}
			.goodsList .specification{width:140px;heigth:60px;text-align:center}
			.goodsList .price{width:100px;heigth:60px;text-align:center}
			.goodsList .count{width:100px;heigth:60px;text-align:center}
			.goodsList .subtotal{width:100px;heigth:60px;color:#eb4a3f;text-align:center;font-weight:600}
			.goodsList .titleNav{height:30px;border-bottom:1px solid #dddddd;padding:0 30px;line-height:30px}
			.goodsList .titleNav div{float:left;text-align:center}
			.goodsList .titleNav .goodsName{text-align:left}
			.goodsList .titleNav .subtotal{color:#333333;font-weight:400}
			.goodsList .goodsItem{border-bottom:1px solid #dddddd;overflow:hidden;padding:0 30px}
			.goodsList .goodsItem>div{float:left}
			.goodsList .goodsItem{line-height:60px}
			.goodsList .goodsItem .coupon{width:640px;overflow:hidden}
			.goodsList .goodsItem .coupon>div{float:left}
			.goodsList .goodsItem .goodsName{padding:4px 0;height:52px}
			.goodsList .goodsItem .goodsName a{font:12px/20px '宋体';color:#333333;text-decoration:none}
			.goodsList .goodsItem .goodsName a:hover{color:#eb4a3f;text-decoration:underline;}
			.goodsList .goodsItem img{float:left;heigth:50px;width:50px;border:1px solid #eeeeee;margin-right:5px;height:50px;width:50px}
			.goodsList .goodsItem .count span{color:#eb4a3f}
		</style>
		<div class="item_frame goodsList">
			<div class="title"><div style="float:left">商品清单</div><s:a cssStyle="float:right;color:#999999" href="%{@com.haozhuoji.mall.util.Constant@http_p}">修改购物车</s:a></div>
			<div class="titleNav">
				<div class="goodsName">商品名称</div>
				<div class="specification">规格</div>
				<div class="price">单价</div>
				<div class="count">数量</div>
				<div class="subtotal">小计</div>
			</div>
			<s:iterator value="#request.order.cartList">
				<div class="goodsItem">
					<s:iterator value="goodsList">
						<div class="coupon">
							<div class="goodsName">
								<img src="<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p+'/'+goodsID+'/main/main_50x50.jpg'" />" />
								<a target="_blank" href="<s:property value="@com.haozhuoji.mall.util.Constant@goods_p+goodsID+'.html'" />"><s:property value="brand+' '+goodsName" /></a>
							</div>
							<div class="specification"><s:property value="specification" /></div>
						</div>
					</s:iterator>
					<div class="price">¥<s:property value="@com.haozhuoji.mall.util.Arith@format(price)" /></div>
					<s:if test="stock&&sell">
						<div class="count">
						<s:property value="count" />
					</div>
					</s:if>
					<s:else>
						<div class="count" style="font:12px/20px '宋体';vertical-align:center">
							<br />
							<s:property value="count" />
							<s:if test="!sell">
								<br/><span>已下架</span>								
							</s:if>
							<s:else>
								<br/><span>库存不足</span>
							</s:else>
						</div>
					</s:else>
					<div class="subtotal">¥<s:property value="@com.haozhuoji.mall.util.Arith@mulFormat(price,count)" /></div>
				</div>
			</s:iterator>
		</div>
		
		<%--订单结算 --%>
		<style type="text/css">
			.settlement .itemFrame{overflow:hidden;margin:0 30px;padding:10px 0;font:600 12px/20px '宋体';border-bottom:1px solid #dddddd}
			.settlement .option{float:left}
			.settlement .value{float:right}
			.bottomFrame{margin-left:600px;padding:0 30px;margin-top:20px}
			.bottomItem{padding:10px 0;font:12px/20px '宋体';overflow:hidden}
			.bottomItem>div{float:left}
			.bottomItem option{width:100px}
			.bottomItem option a{color:#377ff;text-decoration:none}
			.bottomItem option a{text-decoration:underline;}
			.submitFrame{width:940px;padding:0 30px;height:50px;background-color:#efefef;margin:20px 0}
			.submitFrame .allPrice{color:#eb4a3f;font:30px/50px 'Arial';float:right}
			.submitFrame .submitInput{cursor:pointer;height:40px;background-color:#eb4a3f;width:200px;font:600 20px/40px 'microsoft yahei';margin:5px 0 5px 50px;float:right;color:#ffffff;text-align:center;border-radius:2px}
			.submitFrame .submitInput:hover{background-color:#E85F55}
		</style>
		<script type="text/javascript">
			$(function(){
				$(".openCouponFlag").click(function(){
					$.ajax({
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@user_p"/>/order_getCoupon.html",
						success:function(data){
							data = eval("("+data+")");
							var fa = $(".couponFrame").css({display:'block'});
							$(".couponFrame .couponItem[show]").remove();
							$("#couponCancal").css({display:'block'});
							for(var i in data.coupon){
								var zi = $(".couponFrame .couponClone").clone(true).removeClass("couponClone").css({display:'block'}).attr("show","show");
								zi.find(".c_title").text(coupon.sentence(data.coupon[i]));
								zi.closest(".couponItem").attr({"sub":data.coupon[i].sub,"couponNumber":data.coupon[i].couponNumber});
								if(data.coupon[i].startDateTime){
									if(data.coupon[i].totalPrice<data.coupon[i].rech){
										zi.find(".c_oper span").text("商品价格不足，还差"+format((data.coupon[i].rech*100-data.coupon[i].totalPrice*100)/100)+"元");
										zi.find(".c_oper a").css({display:'none'});
									}else{
										zi.find(".c_oper span").css({display:'none'});
										zi.find(".c_oper a").text("使用");								
									}
								}else{
									zi.find(".c_oper span").text("该优惠券未到使用日期");
									zi.find(".c_oper a").css({display:'none'});									
								}
								fa.append(zi);
							}
						},
						error:function(){
							g_mess.alert("获取失败，请刷新后再试！",function(){location.unload();});
						}
					});
				});
				//new coupon
				$("#couponNewConfrim").click(function(){
					if($("#couponNumber").val().trim()==""){
						g_mess.alert("优惠券/代金券编号不能为空！");
					}else{
						$.ajax({
							url:"<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/order_getNewCoupon.action",
							data:{'coupon.couponNumber':$("#couponNumber").val().trim()},
							success:function(data){
								data = eval("("+data+")");
								if(data.status=="success"){
									g_mess.alert(coupon.sentence(data));
									var send = parseFloat($("#g_sendPrice").text())*100;
									var total = parseFloat($("#g_totalPrice").text())*100;
									total = total-send;
									if(params.couponNumber){
										total=total+parseFloat($("#cancelUse").closest(".option").attr("sub"))*100;
									}
									total = total - data.sub*100;
									$("#cancelUse").closest(".option").attr("sub",data.sub);
									params.couponNumber = data.couponNumber;
									if(total<params.rechSendPrice*100){
										total=total+params.addSendPrice*100;
										send=params.addSendPrice;
									}else{
										send=0;
									}
									$("#g_sendPrice").text(format(send));
									$("#g_totalPrice").text(format(total/100));
									$("#g_trueCoupon").css({display:'block'});
									$("#o_useCoupon").css({display:'none'});
									$("#useCouponMess").text(coupon.sentence(data));
									$("#g_trueCoupon .value").text("- ¥"+format(data.sub));
									$("#couponCancal").css({display:'none'});
									$(".couponFrame").css({display:'none'});
								}else{
									g_mess.alert(data.status);									
								}
							},
							error:function(){
								g_mess.alert("获取失败，请刷新后再试！");
							}
						});
					}
				});
				//cancel useing coupon
				$("#couponCancal").click(function(){
					$(".couponFrame").css({display:'none'});
					$("#couponCancal").css({display:'none'});
				});
				$("#cancelUse").click(function(){
					if(params.couponNumber){
						var sub = parseFloat($("#cancelUse").closest(".option").attr("sub"))*100;
						var send = parseFloat($("#g_sendPrice").text())*100;
						var total = parseFloat($("#g_totalPrice").text())*100;
						total = total-send+sub;
						if(total<params.rechSendPrice*100){
							total=total+params.addSendPrice*100;
							send=params.addSendPrice;
						}else{
							send=0;
						}
						$("#g_sendPrice").text(format(send));
						$("#g_totalPrice").text(format(total/100));
						params.couponNumber=null;
					}
					$("#g_trueCoupon").css({display:'none'});
					$("#o_useCoupon").css({display:'block'});
				});
				$(".g_confirmCoupon").click(function(){
					var send = parseFloat($("#g_sendPrice").text())*100;
					var total = parseFloat($("#g_totalPrice").text())*100;
					total = total-send;
					if(params.couponNumber){
						total=total+parseFloat($("#cancelUse").closest(".option").attr("sub"))*100;
					}
					total = total - parseFloat($(this).closest(".couponItem").attr("sub"))*100;
					$("#cancelUse").closest(".option").attr("sub",$(this).closest(".couponItem").attr("sub"))
					params.couponNumber = $(this).closest(".couponItem").attr("couponNumber");
					if(total<params.rechSendPrice*100){
						total=total+params.addSendPrice*100;
						send=params.addSendPrice;
					}else{
						send=0;
					}
					$("#g_sendPrice").text(format(send));
					$("#g_totalPrice").text(format(total/100));
					$("#g_trueCoupon").css({display:'block'});
					$("#o_useCoupon").css({display:'none'});
					$("#useCouponMess").text($(this).closest(".couponItem").find(".c_title").text());
					$("#g_trueCoupon .value").text("- ¥"+format($(this).closest(".couponItem").attr("sub")));
					$("#couponCancal").css({display:'none'});
					$(".couponFrame").css({display:'none'});
				});
				coupon={
					sentence:function(data){
						if(data.rech==data.sub){
							return "代金券（"+data.couponNumber+"）（"+data.type+"）："+format(data.sub)+"元代金券";
						}else{
							return "优惠券（"+data.couponNumber+"）（"+data.type+"）：满"+format(data.rech)+"元,减"+format(data.sub)+"元";
						}
					}
				};
			});
		</script>
		<div class="item_frame settlement ">
			<div class="title">订单结算</div>
			<div class="itemFrame">
				<div class="option">商品总价</div>
				<div class="value">¥<span id="totalGoodsPrice"><s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.goods_price)"/></span></div>
			</div>
			<s:div cssClass="itemFrame" id="sendPriceFrame" rechSendPrice="%{@com.haozhuoji.mall.util.Constant@rechSendPrice}" sendPrice="%{@com.haozhuoji.mall.util.Constant@sendPrice}">
				<div class="option">运费（满<s:property value="@com.haozhuoji.mall.util.Arith@format(@com.haozhuoji.mall.util.Constant@rechSendPrice)" />元免运费）</div>
				<div class="value">&nbsp;¥<span id="g_sendPrice"><s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.send_price)"/></span></div>
			</s:div>
			<s:iterator value="#request.order.activityList" var="subInfo">
				<div class="itemFrame">
					<div class="option">活动（<s:property value="@com.haozhuoji.mall.util.DataUtil@typeSplit(fullTypeName)" />）：满<s:property value="@com.haozhuoji.mall.util.Arith@format(rech)" />元
					减<s:property value="@com.haozhuoji.mall.util.Arith@format(sub)" />元</div>
					<div class="value">-&nbsp;¥<s:property value="@com.haozhuoji.mall.util.Arith@format(sub)" /></div>
				</div>
			</s:iterator>
			<style type="text/css">
				.couponFrame{display:none;background-color:#f9f9f9;padding:10px;width:720px;font:12px/20px '宋体';border-radius:5px;border:1px solid #3377ff}
				.couponFrame .couponItem{border-bottom:1px solid #eeeeee;overflow:hidden}
				.couponFrame .c_title{width:500px;float:left;overflow:hidden;color:#777777}
				.couponFrame .c_oper{width:200px;float:left;overflow:hidden}
				.couponFrame .c_oper span{color:#999999}
				.itemFrame a{color:#3377ff;text-decoration:none;font:12px/20px '宋体'}
				.itemFrame a:hover{text-decoration:underline;}
				#couponCancal{width:50px;display:none;height:20px;font:12px/20px '宋体';background-color:#3377ff;color:#ffffff;text-align:center;margin-left:680px;box-radius:4px;cursor:pointer}
				#couponNumber{float:left;width:200px;height:12px;padding:3px;border:1px solid #aaaaaa}
				#couponNewConfrim{float:left;width:50px;height:20px;text-align:center;background-color:#eb4a3f;color:#ffffff;cursor:pointer;}
			</style>
			<div class="itemFrame" sub="0">
					<s:div id="g_trueCoupon" cssStyle="display:%{#request.order.coupon==null?'none':'block'};overflow:hidden">
						<s:div cssClass="option" sub="%{#request.order.coupon.sub}"><span id="useCouponMess">
						<s:property value="#request.order.coupon.rech==#request.order.coupon.sub?'代金券':'优惠券'" />（<s:property value="#request.order.coupon.couponNumber" />）（<s:property value="@com.haozhuoji.mall.util.DataUtil@typeSplit(#request.order.coupon.fullTypeName)" />）：
						<s:if test="#request.order.coupon.rech==#request.order.coupon.sub">
							<s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.coupon.sub)" />元代金券
						</s:if>
						<s:else>
							满<s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.coupon.rech)" />元
							减<s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.coupon.sub)" />元
						</s:else>
						</span>&nbsp;&nbsp;<a href="javascript:void(0)" id="changeCoupon" class="openCouponFlag">更换</a>&nbsp;&nbsp;<a href="javascript:void(0)" id="cancelUse">取消使用</a></s:div>
						<div class="value">-&nbsp;¥<s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.coupon.sub)" /></div>
					</s:div>
					
					<s:a href="javascript:void(0)" cssClass="openCouponFlag" id="o_useCoupon" cssStyle="display:%{#request.order.coupon!=null?'none':'block'}">+使用优惠券</s:a>
					<div class="couponFrame">
						<s:if test="#request.order.activityList.size()==0">
							<div class="couponItem" style="padding-bottom:10px"><div style="float:left">使用新优惠券/代金券（编号）：</div><input id="couponNumber" autocomplete="off" /><div id="couponNewConfrim">确认</div></div>
							<div class="couponItem couponClone" style="display:none"><div class="c_title"></div><div class="c_oper"><span></span><a href="javascript:void(0)" class="g_confirmCoupon"></a></div></div>
						</s:if>
						<s:else>
							<span style="font:12px/20px '宋体';color:#999999">对不起,参与活动后不能使用优惠券/代金券！</span>
						</s:else>
					</div>
					<div id="couponCancal">取消</div>
			</div>
			<div class="bottomFrame">
				<div class="bottomItem">
					<div class="option">收货地址：</div>
					<div class="value bottomAddress"></div>
				</div>
				<div class="bottomItem">
					<div class="option">收货时段：</div>
					<div class="value bottomPeriod"><span></span>&nbsp;&nbsp;<span></span></div>
				</div>
				<div class="bottomItem">
					<div class="option">用户留言：</div>
					<div class="value bottomPeriod"><input id="leaveMessage" autoComplete="off" /></div>
				</div>
			</div>
			<script type="text/javascript">
			$(function(){
				var submitFlag = true;
				$(".submitInput").click(function(){
						if(params.addressID==null){
							g_mess.alert("请选择收货地址！");
						}else if(params.date==null){
							g_mess.alert("请选择收货日期！");						
						}else if(params.periodID==null){
							g_mess.alert("请选择时段");
						}else if(params.activitySub==null||params.addSendPrice==null||params.orderTimeStamp==null||params.sendPrice==null||params.timePeriod==null){
							g_mess.alert("参数错数，请刷新后再试！");
						}else{
							params.leaveMessage = $("#leaveMessage").val().trim();
							if(submitFlag){
								params.totalGoodsPrice=$("#totalGoodsPrice").text().trim();
								params.totalPrice=$("#g_totalPrice").text().trim();
								submitFlag=false;
								$.ajax({
									data:params,
									type:'post',
									url:'<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/order_submitOrder.html',
									beforeSend:function(){
										g_mess.ajax("正在提交订单...");
									},success:function(data){
										try{
											data = eval("("+data+")");
										}catch(e){
											g_mess.alert("订单提交错误，请刷新后再试！");
										};
										if(data.status=="success"){
											location.href="<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/order_successOrder.html?orderNumber="+data.orderNumber+"&dateTime="+data.dateTime+"&price="+data.price;
										}else{
											g_mess.alert(data.status,function(){location.reload();});
											submitFlag=true;
										};
									},error:function(){
										g_mess.alert("订单提交错误请刷新后再试！");
										submitFlag=true;
									}
								});
							}
						}
				});
			});
			$(function(){
				var d = $(".timePeriod[periodID='"+$.cookie("periodID")+"']");
				if(d.length==0){
					d = $(".timePeriod:eq(0)");
				}
				var a = $(".trueAddress[addressID='"+$.cookie("addressID")+"']");
				if(a.length==0){
					$(".trueAddress:eq(0)").click();
				}else{
					a.click();
				}
				$("#dayChooser").val(d.closest(".periodFrame").attr("day")).change();
				d.click();
			});
			</script>
			<div class="submitFrame">
				<div class="submitInput">提交订单</div>
				<div class="allPrice"><span style="font:12px/14px 'Arial';color:#999999">总计：</span>&nbsp;&nbsp;¥<span id="g_totalPrice"><s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.order_price)" /></span></div>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"></s:include>
  </body>
</html>