<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
		<style type="text/css">
			*{padding:0;margin:0}
			.g_cart{width:350px;border:1px solid #AAAAAA;box-shadow:3px 3px 2px #e0e0e0;position:absolute;display:none;background-color:#ffffff;z-index:10}
			.g_cart_frame{overflow:auto;max-height:399px}
			.g_cart_item{padding:0 10px;border-bottom:1px solid #eeeeee;overflow:hidden}
			.g_cart_goodsPic{float:left;width:40px;height:40px;border:1px solid #DDDDDD}
			.g_goodsLink_frame{float:left;width:177px;overflow:hidden;padding:7px 0}
			.g_cart_goodsName a{text-decoration:none;padding-left:5px;width:130px;float:left;height:42px;font:12px/20px '宋体';overflow:hidden;color:#666666}
			.g_cart_goodsName span{color:#eb4a3f;font:12px/20px '宋体'}
			.g_cart_goodsName a:hover{text-decoration:underline;color:#eb4a3f}
			.g_cart_goodsPrice{width:60px;padding-left:4px;padding-right:6px;float:left;height:40px;font:14px/42px '宋体';text-align:center;color:#EB4A3F;padding:7px 0}
			.g_cart_goodsPrice span{font:14px/42px '宋体';color:#EB4A3F}
			.g_cart_amount{width:65px;float:left;overflow:hidden;height:42px;padding:7px 0}
			
			.g_cart_amountCon{margin-top:4px;float:left;overflow:hidden;}
			.g_cart_del{display:block;font:12px/18px '宋体';color:#666666;text-align:center;width:65px;float:left;text-decoration:none}
			.g_cart_del:hover{color:#EB4A3F;text-decoration: underline}
			.g_cart_amount_add{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat -16px -200px;cursor:pointer;margin:2px 0 0 2px;color:#666666;font:12px/12px '宋体';float:left;width:15px;height:15px;text-align:center}
			.g_cart_amount_sub{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat 0 -200px;cursor:pointer;margin:2px 2px 0 0;color:#666666;font:12px/12px '宋体';float:left;width:15px;height:15px;text-align:center}
			.g_cart_curr_amount{float:left;height:18px;width:28px;border:1px solid #DDDDDD;color:#333333;text-align:center}
			
			.g_cart_total_count{color:#EB4A3F;font-weight:600}
			.g_cart_total_price{color:#EB4A3F;font-weight:600}
			.g_cart_bottom{height:30px;background-color:#efefef;border-top:1px solid #AAAAAA;padding:10px 10px;color:#333333;font:14px/30px '宋体';}
			.g_cart_total_count_frame{width:110px;float:left}
			.g_cart_total_price_frame{width:110px;float:left}
			.g_cart_submit{width:100px;padding:5px 0;height:20px;float:left;background-color:#EB4A3F;font:600 14px/20px '宋体';color:#FFFFFF;text-align:center;text-decoration:none}
			
			#g_cart_noLogin{height:57px;background-color:#ffffff;font:12px/57px '宋体';text-align:center;color:#666666}
			#g_cart_noLogin a{color:#0000ee;text-decoration:none}
			#g_cart_noLogin a:hover{color:#eb4a3f;text-decoration:underline}
		</style>
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
			$(function(){
				cart.init();
			});
			var cart={
				timer:null,
				changeCountPirce:function(){
					var countPrice=0;
					var count=0;
					$(".g_cart_item[id!='g_cart_item_clone']").each(function(){
						countPrice=countPrice+(parseFloat($(this).find(".g_cart_goodsPrice span").text())*100*parseInt($(this).find(".g_cart_curr_amount").val()));
						count=count+parseInt($(this).find(".g_cart_curr_amount").val());
					});
					$(".g_cart_total_price_frame span:eq(1)").text(format(countPrice/100));
					$(".g_cart_total_count_flag").text(count);
				},
				init:function(){
					<%-- 购物车初始化 --%>
					$(".g_cart_flag").hover(function(){
						if(cart.timer!=null){
							clearTimeout(cart.timer);
						}
							//同步购物车
							if($(".g_cart").css("display")=="none"&&$(".g_cart_frame").length!=0){
								cart.syncCart();
							}
						if($(".fixed_navigation_cart").css("visibility")=="visible"){
		                	var position = $(".g_fixed_cart").offset();
		                	$(".g_cart").css({"position":"fixed","display":"block"}).offset({top:position.top+38,left:position.left-101});
						}else{
		                	var position = $(".g_position_cart").position();
		                	$(".g_cart").css({"position":"absolute","display":"block"}).offset({top:position.top+38,left:position.left-101});
						}
					},function(){
						cart.timer=setTimeout(function(){
							$(".g_cart").css({"display":"none"});
						},50);
					});
					
					if($(".g_cart_frame").length!=0){
						<%--初始化金额数量 --%>
						cart.changeCountPirce();
					}
					
					<%-- 为提交注册事件 --%>
					$(".g_cart_submit").click(function(){
						if(parseInt($(".g_cart_total_count_flag").text().trim())==0){
							g_mess.alert("购物车没有任何商品！");
							return;
						}else{
							location.href="<s:property value="@com.haozhuoji.mall.util.Constan@http_p"/>/user/order_confirmOrder.html";
						}
					});
					
					<%-- 为减注册事件 --%>
					$(".g_cart_amount_sub").click(function(){
						var count = parseInt($(this).siblings(".g_cart_curr_amount").val());
						if(count>1){
							$(this).siblings(".g_cart_curr_amount").val(count-1);
							cart.updateCart.call(this,"", -1);
							cart.changeCountPirce();
						}else{
							cart.showError.call(this,"不能为零");
						}
					});
					<%-- 为加注册事件 --%>
					$(".g_cart_amount_add").click(function(){
						var amount = parseInt($(this).siblings(".g_cart_curr_amount").attr("amount"));
						var count = parseInt($(this).siblings(".g_cart_curr_amount").val())+1;
						if(count>amount){
							cart.showError.call(this,"库存不足");
						}else{
							$(this).siblings(".g_cart_curr_amount").val(count);
							cart.updateCart.call(this,"", 1);
							cart.changeCountPirce();
						}
					});
					<%-- 为input直接输入注册事件 --%>
					$(".g_cart_curr_amount").focus(function(){
						$(this).attr("count",$(this).val());
					});
					$(".g_cart_curr_amount").focusout(function(){
						var pre = parseInt($(this).attr("count"));
						var amount = parseInt($(this).attr("amount"));
						if(!$(this).val().match("^\\d+$")){
							$(this).val(pre);
						}else{
							var curr = parseInt($(this).val());
							if(curr<=0){
								$(this).val(pre);
								cart.showError.call(this,"不能为零");
							}else if(curr>amount){
								$(this).val(amount);
								cart.updateCart.call(this,"", amount-pre);
								cart.changeCountPirce();
								cart.showError.call(this,"库存不足");
							}else if(curr<amount){
								cart.updateCart.call(this,"", curr-pre);
								cart.changeCountPirce();
							}
						}
					});
					<%-- 为删除注册  --%>
					$(".g_cart_del").click(function(){
						var $item = $(this).closest(".g_cart_item");
						$item.remove();
						cart.changeCountPirce();
						$.ajax({
							url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/cart_delete.action",
							data:{cartID:$(this).closest(".g_cart_item").attr("cartID")},
							error:function(){
								g_mess.alert("删除失败，请刷新后重试");
							}
						});
					});
				},
				//error message
				showError:function(message){
					var position;
					//g_mess.alert($(".g_cart").css("position")=="fixed");
					if($(".g_cart").css("position")=="fixed"){						
						position = $(this).closest(".g_cart_item").find(".g_cart_curr_amount").offset();
					}else{
						position = $(this).closest(".g_cart_item").find(".g_cart_curr_amount").offset();
					}
					$("#g_cart_countLow").css({"display":"block","position":$(".g_cart").css("position")}).offset({"top":position.top-15,"left":position.left-10}).text(message);
					setTimeout(function(){
						$("#g_cart_countLow").css({"display":"none"});
					},1500);
				},
				//interface
				addCart:function(goodsID,bundlingID,count){
					if($(".g_cart_frame").length==0){
						g_login();
					}else{
						var item;
						if(goodsID!=null){
							item=$(".g_cart_item[goodsID='"+goodsID+"']");
						}else{
							item=$(".g_cart_item[bundlingID='"+bundlingID+"']");
						}
						if(item.length==1){
							var $item = item.find(".g_cart_curr_amount");
							$item.attr("count",$item.val());
							$item.val(parseInt($item.val())+parseInt(count));
							$item.focusout.call($item);
							cart.showCart();
						}else{
							$.ajax({
								url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/cart_add.action",
								data:{goodsID:goodsID,count:count,bundlingID:bundlingID},
								error:function(){
									g_mess.alert("增加失败，请刷新后重试");
								},
								success:function(json){
									var data = eval("("+json+")");
									if(data.isLogin!=null){
										g_login();
										return;
									}
									if(data.flag == 'true'){
										cart.addItem(data.add);
										cart.changeCountPirce();
										cart.showCart();
									}else{
										g_mess.alert("增加失败，请刷新后重试");
									}
								}
							});
						}
					}
				},
				addItem:function(json){
					for(var i=0;i<json.length;i++){
						var data = json[i];
						var $Item = $("#g_cart_item_clone").clone(true);
						$Item.css({display:'block'}).attr({cartID:data.cartID,goodsID:data.goodsID,bundlingID:data.bundlingID}).removeAttr("id");
						for(var j=0;j<data.goods.length;j++){
							var $goods = $Item.find(".g_goodsLink_frame:eq(0)").clone("true").css({display:"block"});
							$goods.find("a").attr("href","<s:property value="@com.haozhuoji.mall.util.Constant@goods_p"/>"+data.goods[j].goodsID+".html");
							$goods.find(".g_cart_goodsName a").text(data.goods[j].goodsName);
							$goods.find("img").attr({'src':"<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p" />/"+data.goods[j].goodsID+"/main/main_50x50.jpg"});
							$goods.find(".g_cart_goodsName a").append($("<span> "+data.goods[j].promotion_sentence+"</span>"));
							$Item.find(".g_cart_goodsPrice").before($goods);
						}
						$Item.find(".g_cart_goodsPrice span").text(format(data.price));
						$Item.find(".g_cart_curr_amount").val(data.count).attr("amount",data.amount);
						$(".g_cart_frame").append($Item);
					}
					
				},
				updateItem:function(json){
					for(var i=0;i<json.length;i++){
						var data = json[i];
						var $item = $(".g_cart_item[cartID='"+data.cartID+"']");
						if($item.length>0){
							var pre = parseInt($item.find(".g_cart_curr_amount").val());
							$item.find(".g_cart_curr_amount").val(data.count);
						}
					}
				},
				deleteItem:function(json){
					for(var i=0;i<json.length;i++){
						var data = json[i];
						var $item = $(".g_cart_item[cartID="+data.cartID+"]");
						if($item.length>0){
							$item.remove();
						}
					}
				},
				showCart:function(){
					$(".g_cart_flag").mouseover();
					cart.timer=setTimeout(function(){
						$(".g_cart").slideUp(500);
					},1500);
				},
				updateCart:function(cartID,count){
					if($(this).closest(".g_cart_item").attr("cartID")!=null){
						cartID = $(this).closest(".g_cart_item").attr("cartID");
					}
					$.ajax({
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/cart_update.action",
						data:{cartID:cartID,count:count},
						error:function(){
							g_mess.alert("修改失败，请刷新后重试");
						}
					});
				},
				syncCart:function(){
					var data="";
					$(".g_cart_item[id!=g_cart_item_clone]").each(function(){
						data = data+$(this).attr("cartID")+"-"+$(this).find(".g_cart_curr_amount").val()+"_";
					});
					if(data!=""){
						data = data.substr(0,data.length-1);
					}
					$.ajax({
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/user/cart_checkCart.action",
						data:{checkCartIDs:data},
						error:function(){
							g_mess.alert("购物车同步失败！请检测网络，刷新后重试");
						},
						success:function(json){
							var data = eval("("+json+")");
							if(data.isLogin!=null){
								g_login();
								return;
							}
							if(data.flag == 'true'){
								if(data.add!=null)
									cart.addItem(data.add);
								if(data.update!=null)
									cart.updateItem(data.update);
								if(data.del!=null)
									cart.deleteItem(data.del);
								cart.changeCountPirce();
							}else if(data.flag == 'false'){
								
							}else{
								g_mess.alert("购物车同步失败！请检测网络，刷新后重试");
							};
						}
					});
				}
			};
			//购物车增加商品interface
			addGoods=function(goodsID,count){
				cart.addCart(goodsID,null,count);
			};
			addBundling=function(bundlingID,count){
				cart.addCart(null,bundlingID,count);				
			};
			//登录提示框
			g_login=function(){
				if($("#loginFrame_div").length==0){
					$("body").append($("<div id='loginFrame_div'></div>"));
				}
				$("#loginFrame_div").load("<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/loginRegister_loginFrame.html");
			};
		</script>
		<div class="g_cart g_cart_flag">
			<s:if test="#session.userBean==null">
				<div id="g_cart_noLogin">您尚未登录，请 &nbsp;<a href="javascript:void(0)" onclick="g_login()">登录</a>&nbsp;或&nbsp;<a href='<s:property value="@com.haozhuoji.mall.util.Constan@http_p"/>/register.html'>注册</a></div>
			</s:if>
			<s:else>
				<div id="g_cart_countLow" style="height:14px;width:50px;color:#eb4a3f;background-color:#FFEBEB;font:12px/14px '宋体';position:absolute;display:none"></div>
				<div class="g_cart_frame">
					<s:iterator value="#request.cartList">
						<div class="g_cart_item" goodsID="<s:property value="bundlingID==null?goodsID:''" />" bundlingID="<s:property value="bundlingID" />" cartID='<s:property value="cartID" />' >
							<s:iterator value="goodsList">
								<div class="g_goodsLink_frame">
									<a target="_blank" href='<s:property value="@com.haozhuoji.mall.util.Constant@goods_p+goodsID"/>.html'>
										<img class="g_cart_goodsPic" src="<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p+'/'+goodsID+'/main/main_50x50.jpg'" />" />
									</a>
									<div class="g_cart_goodsName">
										<a target="_blank" href='<s:property value="@com.haozhuoji.mall.util.Constant@goods_p+goodsID"/>.html'>
											<s:property value="brand+' '+goodsName+' '+specification"/>
											<span><s:property value="promotion_sentence" /></span>
										</a>
									</div>
								</div>
							</s:iterator>
							<div class="g_cart_goodsPrice">¥<span><s:property value="@com.haozhuoji.mall.util.Arith@format(price)"/></span></div>
							<div class="g_cart_amount">
								<div class="g_cart_amountCon">
									<div class="g_cart_amount_sub"></div>
									<input class="g_cart_curr_amount" amount="<s:property value="amount" />" value="<s:property value="count" />" autocomplete="off" />
									<div class="g_cart_amount_add"></div>
								</div><br />
								<a href="javascript:void(0)" class="g_cart_del">删除</a>
							</div>
						</div>
					</s:iterator>
					<div class="g_cart_item" id="g_cart_item_clone" style="display:none">
							<div class="g_goodsLink_frame" style="display:none">
								<a target="_blank" href=''>
									<img class="g_cart_goodsPic"/>
								</a>
								<div class="g_cart_goodsName">
								<a target="_blank" href=''>
								<span></span>
								</a>
								</div>
							</div>
							<div class="g_cart_goodsPrice">¥<span>0</span></div>
							<div class="g_cart_amount">
								<div class="g_cart_amountCon">
									<div class="g_cart_amount_sub"></div>
									<input class="g_cart_curr_amount" amount="0" value="0" autocomplete="off" />
									<div class="g_cart_amount_add"></div>
								</div><br />
								<a href="javascript:void(0)" class="g_cart_del">删除</a>
							</div>
					</div>
				</div>
				<div class="g_cart_bottom">
					<div class="g_cart_total_count_frame">共&nbsp;<span class="g_cart_total_count g_cart_total_count_flag">0</span>&nbsp;件商品</div>
					<div class="g_cart_total_price_frame">合计:<span style="color:#EB4A3F">¥</span><span class="g_cart_total_price">0</span></div>
					<a href="javascript:void(0)" class="g_cart_submit">立即结算</a>
				</div>
			</s:else>
		</div>