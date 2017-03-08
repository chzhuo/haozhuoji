<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
		<s:if test="goodsID==null">
			<title>您所查看的商品不存在或已下架 - 好捉急校园便利店</title>
		</s:if>
		<s:else>
			<title><s:property value="brand+' '+goodsName+' '+specification+' - 好捉急校园便利店'" /></title>
			<style type="text/css">
				body{font:12px/18px Arial,'宋体'}
				a{font:12px/12px Arial,'宋体';color:#3377FF;text-decoration:none}
				a:hover{text-decoration:underline}
				.classGoodsNameBar{height:20;padding:20px 0;width:1200px;margin:0 auto;font:14px/20px '宋体';}
				.classGoodsNameBar a{font:14px/20px '宋体';text-decoration:none;color:#777777}
				.classGoodsNameBar a:hover{color:#EB4A3F;text-decoration:underline}
				.classGoodsNameBar .topClass{font:600 20px/20px 'microsoft yahei';color:#666666}
				.goodsCenter{width:1200px;margin:0 auto;overflow:hidden}
				.goodsCenter .goodsImgSlider{float:left;overflow:hidden;margin-right:20px}
				
				.goodsCenter .goodsImgSlider .goodsImgFrame{width:450px;height:450px;border:1px solid #dddddd;text-align:center;vertical-align:center}
				.goodsCenter .goodsImgSlider .navGoodsImg{width:450px;border:1px solid #FFFFFF;overflow:hidden;margin:10px 0}
				.goodsCenter .goodsImgSlider .navGoodsImg .imgContent{float:left;width:390px;height:62px;overflow:hidden;position:relative}
				.goodsCenter .goodsImgSlider .navGoodsImg .imgItem{width:60px;height:60px;border:1px solid #DDDDDD;margin:0 8px;background-color:#EEEEEE;float:left}
				.goodsCenter .goodsImgSlider .navGoodsImg .preNext{width:20px;height:60px;border:1px solid #DDDDDD;float:left;border-radius:2px}
				.goodsCenter .goodsImgSlider .navGoodsImg .pre{margin-right:8px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat -294px -30px}
				.goodsCenter .goodsImgSlider .navGoodsImg .next{margin-left:8px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat -314px -30px;}
				.goodsCenter .rightContent .share{overflow:hidden;padding:10px 0;font:12px/16px '宋体'}
				.goodsCenter .rightContent .shareTitle{float:left;color:#999999;padding:6px 0}
				.goodsCenter .rightContent .bshare-custom{float:left}
				.goodsCenter .rightContent{float:left;overflow:hidden;width:718px}
				.goodsCenter .rightContent h1{font:600 18px/30px Arial,'microsoft yahei';color:#666666;width:718px}
				.goodsCenter .rightContent strong div{font:600 15px/30px Arial,'microsoft yahei';color:#eb4a3f;padding-bottom:20px;border-bottom:1px dashed #dddddd;margin-bottom:10px}
				.goodsCenter .rightContent .itemFrame{padding:6px 0;font:12px/20px '宋体';color:#444444;overflow:hidden}
				.goodsCenter .rightContent .option{width:70px;float:left;text-align:right}
				.goodsCenter .rightContent .value{float:left}
				.goodsCenter .rightContent .amountFrame .sub{float:left;width:15px;height:15px;margin:4px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat 0 -200px }
				.goodsCenter .rightContent .amountFrame .sub:hover{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat 0 -216px;outline:0}
				.goodsCenter .rightContent .amountFrame input{padding:2px 0;height:13px;float:left;border:1px solid #999999;margin:2px;width:30px;text-align:center;font:13px/13px '宋体';}
				.goodsCenter .rightContent .amountFrame .add{float:left;width:15px;height:15px;margin:4px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat -16px -200px}
				.goodsCenter .rightContent .amountFrame .add:hover{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat -16px -216px }
				.goodsCenter .rightContent .enter_cart{cursor:pointer;width:170px;float:left;height:35px;font:600 18px/35px Arial,'microsoft yahei';color:#ffffff;text-align:cnter;border-radius:3px;background-color:#eb4a3f;border:1px solid #eb4a3f;margin-right:20px}
				.goodsCenter .rightContent .enter_cart:hover{background-color:#E85F55}
				.goodsCenter .rightContent .enter_coll{cursor:pointer;width:80px;float:left;height:35px;font:14px/35px Arial,'microsoft yahei';color:#999999;text-align:cnter;background-color:#ffffff;border:1px solid #dddddd;border-radius:3px}
				.goodsCenter .rightContent .enter_coll:hover{background-color:#eeeeee}
				.goodsCenter .rightContent .cartColl{padding:30px 0;border-bottom:1px dashed #dddddd;border-top:1px dashed #dddddd}
				.goodsCenter .rightContent .price{color:#eb4a3f;font:600 20px/20px Arial}
				.goodsCenter .rightContent .comment{height:15px;width:75px;float:left;margin-right:20px}
				.goodsCenter .rightContent .speciImg{border:1px solid #dddddd;float:left;padding:2px;margin:3px;width:50px;heigth:50px}
				.goodsCenter .rightContent .speciName{line-height:52px}
				.goodsCenter .rightContent .speciFrame{padding:10px 0;}
				.goodsCenter .rightContent .commentTotal{color:#3377ff;text-decoration:none}
				.goodsCenter .rightContent .commentTotal:hover{text-decoration:underline}
				
				.goodsClassContent{width:1200px;overflow:hidden;margin:0 auto;margin-top:20px}
				
				.goodsClassContent .leftContent{width:200px;float:left;}
				.goodsClassContent .leftContent .itemFrame{width:198px;border:1px solid #eeeeee}
				.goodsClassContent .leftContent .itemFrame .title{height:28px;background-color:#f9f9f9;color:#666666;font:14px/28px Arial,'microsoft yahei';text-indent:5px}
				.goodsClassContent .leftContent .itemFrame .goodsItem{border-top:1px solid #EEEEEE;padding:5px}
				.goodsClassContent .leftContent .itemFrame .goodsImg{width:100px;height:100px;border:1px solid #DDDDDD;display:block;margin:0 auto}
				.goodsClassContent .leftContent .itemFrame .goodsName{color:#666666;text-decoration:none;}
				.goodsClassContent .leftContent .itemFrame .goodsName span{font:12px/18px '宋体';height:36px;overflow:hidden}
				.goodsClassContent .leftContent .itemFrame .goodsName:hover{color:#EB4A3F;text-decoration:underline}
				.goodsClassContent .leftContent .itemFrame .price_cart{overflow:hidden;padding:5px 0}
				.goodsClassContent .leftContent .itemFrame .goodsPrice{float:left;color:#EB4A3F;font-weight:600}
				.goodsClassContent .leftContent .itemFrame .enter_cart{color:#666666;float:right}
				.goodsClassContent .leftContent .itemFrame .enter_cart:hover{color:#EB4A3F;text-decoration:underline;cursor:pointer}
				
				
				
				.goodsClassContent .rightContent{float:left;margin-left:20px}
				.goodsClassContent .rightContent .itemFrame{border:1px solid #EEEEEE;width:978px;margin-bottom:20px}
				.goodsClassContent .rightContent .titil{font:14px/28px Arial,'microsoft yahei';text-indent:5px;color:#666666;background-color:#f9f9f9;border-bottom:1px solid #EEEEEE}
				.goodsClassContent .rightContent .package{overflow:hidden;padding-bottom:5px}
				.goodsClassContent .rightContent .packSelecter{font:12px/12px Arial,'宋体';color:#333333;text-decoration:none}
				.goodsClassContent .rightContent .goodsFrame{height:146px;float:left;width:726px;height:146px}
				.goodsClassContent .rightContent .goodsName{color:#666666;text-decoration:none;width:100px;float:left;padding:5px}
				.goodsClassContent .rightContent .goodsName:hover{color:#EB4A3F;text-decoration:underline}
				.goodsClassContent .rightContent .goodsName div{height:36px;overflow:hidden;display:block;line-height:18px}
				.goodsClassContent .rightContent .goodsName .goodsImg{width:100px;height:100px}
				.goodsClassContent .rightContent .space{width:24px;font:600 40px/110px Arial;float:left;color:#DDDDDD;padding:0 10px;margin-bottom:36px}
				.goodsClassContent .rightContent .right{float:left;padding:30px 10px;color:#666666}
				.goodsClassContent .rightContent .right span{color:#EB4A3F}
				.goodsClassContent .rightContent .right .enter_cart{background-color:#EB4A3F;color:#FFFFFF;width:80px;text-align:center;border-radius:2px;margin-top:10px;cursor:pointer}
				
				.goodsClassContent .rightContent .speci{overflow:hidden;padding:6px}
				.goodsClassContent .rightContent .speci .item{width:322px;float:left;overflow:hidden;padding:2px 0;color:#666666}
				.goodsClassContent .rightContent .goodsDetail{overflow:hidden;padding:6px}
				.goodsClassContent .rightContent .comment{overflow:hidden;padding:6px}
				.goodsClassContent .rightContent .comment .item{overflow:hidden;color:#666666;padding:10px 0}
				.goodsClassContent .rightContent .comment .option{height:18px;width:100px;float:left;font-weight:600;color:#555555;overflow:hidden;padding:10px 0;white-space:nowrap;text-align:right}
				.goodsClassContent .rightContent .comment .value{width:764px;border:1px solid #EEEEEE;float:left;padding:10px}
				.goodsClassContent .rightContent .comment .reply{margin-left:10px;width:612px;border:1px solid #EEEEEE;padding:10px;margin-top:10px}
			</style>
		</s:else>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp"></s:include>
		<s:if test="goodsID==null">
			<div style="width:1200px;margin:30px auto">
				<h1>对不起，该商品不存在或已下架！</h1>
			</div>
		</s:if>
		<s:else>
			<div class="classGoodsNameBar">
				<s:iterator value="fullTypeID.split('-')" status="sta">
					<s:if test="#sta.index==0">
						<s:a cssClass="topClass" href="%{@com.haozhuoji.mall.util.Constant@goodsType_p+fullTypeID.split('-')[#sta.index]+'.html'}"><s:property value="fullTypeName.split('-')[#sta.index]" /></s:a><span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;</span>
					</s:if>
					<s:else>
						<s:a cssClass="#" href="%{@com.haozhuoji.mall.util.Constant@goodsType_p+fullTypeID.split('-')[#sta.index]+'.html'}"><s:property value="fullTypeName.split('-')[#sta.index]" /></s:a><span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;</span>
					</s:else>
				</s:iterator>
				<s:a href="%{@com.haozhuoji.mall.util.Constant@http_p+'/search.html?keyWord='+brand}"><s:property value="brand" /></s:a>
			</div>
			<script type="text/javascript">
			$(function(){			
				var itemWidth = 78;
				var preAble = false;
				var nextAble = false;
				$(".goodsCenter .goodsImgSlider .navGoodsImg .imgItem").hover(function() {
					$(".goodsCenter .goodsImgSlider .navGoodsImg .imgItem").css({"border-color":"#dddddd"});
					$(this).css({"border-color":"#eb4a3f"});
					$(".goodsCenter .goodsImgSlider .goodsImg").attr("src",$(this).find("img").attr("bigImg"));
				});
				var total = $(".goodsCenter .goodsImgSlider .navGoodsImg .imgItem").length;
				$(".goodsCenter .goodsImgSlider .navGoodsImg .slideDiv").css({"width":itemWidth*total});
				$(".goodsCenter .goodsImgSlider .navGoodsImg .pre").css({"cursor":"auto"});
				if(total>5){
					nextAble=true;
					$(".goodsCenter .goodsImgSlider .navGoodsImg .next").css({"cursor":"cursor","background-position-x":"264px"});
				}
				
				$(".goodsCenter .goodsImgSlider .navGoodsImg .preNext").click(function(){
					var first = $(this).closest(".navGoodsImg").attr("curr");
					if(first==null){
						first = 1;
					}else{
						first = parseInt(first);
					}
					var $slider = $(".goodsCenter .goodsImgSlider .navGoodsImg .slideDiv");
					var left = parseInt($slider.css("left"));	
					if($(this).attr("preNext")=="pre"){
						if(first>1){
							$(this).closest(".navGoodsImg").attr("curr",first-1);
							$slider.stop(true,false).animate({"left":left+itemWidth},300)
							changeBG();
						}
					}else{
						if(total-first>4){
							$(this).closest(".navGoodsImg").attr("curr",first+1);
							$slider.stop(true,false).animate({"left":left-itemWidth},100)
							changeBG();			
						}
					}
				});
				
				var changeBG = function(){
					var first = parseInt($(".goodsCenter .goodsImgSlider .navGoodsImg").attr("curr"));
					if(first==1){
						preAble=false;
						$(".goodsCenter .goodsImgSlider .navGoodsImg .pre").css({"background-position-x":"294px","cursor":"auto"});
					}else{
						preAble=true;
						$(".goodsCenter .goodsImgSlider .navGoodsImg .pre").css({"background-position-x":"244px","cursor":"pointer"});
					}
					
					if(total-first<5){
						nextAble=false;
						$(".goodsCenter .goodsImgSlider .navGoodsImg .next").css({"background-position-x":"314px","cursor":"auto"});
					}else{
						nextAble=true;
						$(".goodsCenter .goodsImgSlider .navGoodsImg .next").css({"background-position-x":"264px","cursor":"pointer"});							
					}
				}
			});
			</script>
			<div class="goodsCenter">
				<div class="goodsImgSlider">
					<div class="goodsImgFrame">
						<img class="goodsImg" src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID+'/main/main_450x450.jpg'" />" />
					</div>
					<div class="navGoodsImg">
						<div class="pre preNext" preNext="pre"></div>
						<div class="imgContent">
							<div class="slideDiv" style="position:absolute;">
								<div class="imgItem">
									<img src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID+'/main/main_60x60.jpg'" />" bigImg="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID+'/main/main_450x450.jpg'" />" ></img>
								</div>
								<s:iterator value="#request.sliderGoods" var="silderItem">
									<div class="imgItem">
										<img src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID+'/main/'+#silderItem+'_60x60.jpg'" />" bigImg="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID+'/main/'+#silderItem+'_450x450.jpg'" />"></img>
									</div>
								</s:iterator>
							</div>
						</div>
						<div class="next preNext" preNext="next"></div>
					</div>
				</div>
				<div class="rightContent">
					<h1><s:property value="brand+' '+goodsName+''+specification" /></h1>
					<strong>
						<div><s:property value="promotion_sentence" /></div>
					</strong>
					<div class="itemFrame">
						<div class="option">商品编号：</div>					
						<div class="value"><s:property value="goodsID" /></div>					
					</div>
					<div class="itemFrame">
						<div class="option">月销量：</div>					
						<div class="value"><s:property value="purchase_count" /></div>					
					</div>
					<div class="itemFrame">
						<div class="option">商品评分：</div>					
						<div class="value">
							<s:div cssClass="comment" cssStyle="background:url(%{@com.haozhuoji.mall.util.Constant@file_p}/images/g_image.png) no-repeat -%{#request.comment.point==null?0:(75-15*#request.comment.point)}px -231px"></s:div>
							<a href="javascript:void(0)" style="line-height:15px" class="commentTotal">(已有人<s:property value="#request.comment.count" />评价)</a>
						</div>					
					</div>
					<div class="itemFrame">
						<div class="option">商品价格：</div>					
						<div class="value price">¥<s:property value="@com.haozhuoji.mall.util.Arith@format(product_price)" /></div>					
					</div>
					<s:set value="goodsID" var="g_goodsID" />
					<div class="itemFrame speciFrame">
						<s:if test="#request.relevantGoodsList.size()>0">
							<div class="speciName option">选择规格：</div>
						</s:if>
						<s:iterator value="#request.relevantGoodsList">
							<s:a href="%{@com.haozhuoji.mall.util.Constant@goods_p+goodsID+'.html'}" cssStyle="%{goodsID==#g_goodsID?'border:2px solid #eb4a3f':''}" cssClass="speciImg" title="%{specification}">
								<img src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID" />/main/main_50x50.jpg"/>
							</s:a>					
						</s:iterator>
					</div>
					<div class="itemFrame">
						<div class="option">购买数量：</div>
						<script type="text/javascript">
						$(function(){
							//商品数量加减
							$("#classPageCon a").click(function(){
								$("#classPageCon input").attr("pre",$("#classPageCon input").val());
								classPageConC(parseInt($("#classPageCon input").val())+parseInt($(this).attr("count")));
							});
							$("#classPageCon input").focus(function(){
								$(this).attr("pre",$(this).val());
							});
							$("#classPageCon input").focusout(function(){
								classPageConC(parseInt($(this).val()));
							});
							classPageConC=function(count){
								var amount = parseInt( $("#classPageCon input").attr("amount"));
								var pre = $("#classPageCon input").attr("pre");
								if(count<1){
									$("#classPageCon input").val(pre);
								}else if(amount<count){
									$("#classPageCon input").val(pre);
									$("#classPageCon div").css({display:'block'});
									setTimeout(function(){$("#classPageCon div").css({display:'none'});},2000);
								}else{
									$("#classPageCon input").val(count);
								}
							};
							//加收藏
							$(".enter_coll").click(function(){
								$.ajax({
									type:'post',
									url:'<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/goods_addCollection.action',
									data:{goodsID:$(this).attr("goodsID")},
									success:function(data){
										data = eval("("+data+")");
										if(data.isLogin!=null){
											g_login();
										}else{
											g_mess.alert(data.status);
										}
									},
									error:function(){
										g_mess.alert("收藏失败，请刷新后再试！");
									}
								});
							});
							g_login=function(){
								if($("#loginFrame_div").length==0){
									$("body").append($("<div id='loginFrame_div'></div>"));
								}
								$("#loginFrame_div").load("<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/loginRegister_loginFrame.html");
							};
						});
						</script>					
						<div class="amountFrame" id="classPageCon">
							<s:if test="amount>0">
								<a href="javascript:void(0)" class="sub" count="-1"></a>
								<input autocomplete="off" amount="<s:property value="amount" />" value="1" id="d_goods_amount" />
								<a href="javascript:void(0)" class="add" count="1"></a>
								<div style="float:left;color:#eb4a3f;display:none">&nbsp;库存不足</div>
							</s:if>
							<s:else>
								对不起，该商品无货
							</s:else>
						</div>					
					</div>
					<div class="itemFrame cartColl">
						<s:if test="amount>0">
							<input type="button" onclick="addGoods(<s:property value="goodsID"/>,document.getElementById('d_goods_amount').value)" class="enter_cart" value="加入购物车" />
						</s:if>
						<s:else>
							<input type="button" style="width:170px;float:left;height:35px;font:600 18px/35px Arial,'microsoft yahei';color:#999999;text-align:cnter;border-radius:3px;background-color:#eeeeee;border:1px solid #cccccc;margin-right:20px" value="暂时缺货" />
						</s:else>
						<input type="button" goodsID="<s:property value="goodsID"/>" class="enter_coll" value="+加收藏" />
					</div>
					<div class="share">
						<div class="shareTitle">分享到：</div>
						<div class="bdsharebuttonbox bshare-custom"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tqf" data-cmd="tqf" title="分享到腾讯朋友"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_tieba" data-cmd="tieba" title="分享到百度贴吧"></a><a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a><a href="#" class="bds_copy" data-cmd="copy" title="分享到复制网址"></a></div>
					</div>
				</div>
			</div>
			
		
			
			<div class="goodsClassContent">
				<div class="leftContent">
					<div class="itemFrame">
						<div class="title">相关商品</div>
						<div class="content">
							<s:iterator value="#request.relatedGoods">
								<div class="goodsItem">
									<s:a href="%{@com.haozhuoji.mall.util.Constant@goods_p+goodsID}.html" cssClass="goodsName">
										<div class="goodsImg">
											<img src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID+'/main/main_100x100.jpg'" />" />
										</div>
										<span><s:property value="brand+' '+goodsName+' '+specification" /></span>
									</s:a>
									<div class="price_cart" >
										<div class="goodsPrice">¥<s:property value="@com.haozhuoji.mall.util.Arith@format(product_price)" /></div>
										<s:if test="amount>0">
											<s:div cssClass="enter_cart" onclick="addGoods(%{goodsID},1)">加入购物车</s:div>
										</s:if>
										<s:else>
											<div class='enter_cart' style="color:#999999">暂时无货</div>
										</s:else>
									</div>
								</div>
							</s:iterator>
						</div>
					</div>
				</div>
				
				<div class="rightContent" >
					<s:if test="#request.bundlingList.size()>0">
						<script type="text/javascript">
							$(function(){
								$(".packSelecter").hover(function(){
									$(".packSelecter").css({color:'#333333'});
									$(this).css({'color':'#3377FF'});
									$(".package").css({display:'none'}).eq($(this).index()).css({display:'block'});
								});
							});
						</script>
						<div class="itemFrame">
							<div class="titil">优惠套装</div>
							<div style="padding:5px 0 0 30px">
								<s:iterator value="#request.bundlingList" status="sta">
									<s:if test="#sta.index==0">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="packSelecter" style="color:#3377ff" href="javascript:void(0)">套餐<s:property value="#sta.index+1" /></a>
									</s:if>
									<s:else>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="packSelecter" href="javascript:void(0)">套餐<s:property value="#sta.index+1" /></a>
									</s:else>
								</s:iterator>
							</div>
							<s:iterator value="#request.bundlingList" status="topSta">
								<s:set value="0" var="prePrice" />
								<s:div cssClass="package" cssStyle="%{#topSta.index>0?'display:none':''}">
									<div class="goodsFrame" >
										<s:iterator value="goodsList" status="sta">
											<s:a href="%{@com.haozhuoji.mall.util.Constant@goods_p+goodsID+'.html'}" cssClass="goodsName">
												<div class="goodsImg">
													<img src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/images/goods/'+goodsID" />/main/main_100x100.jpg" />
												</div>
												<div><s:property value="brand+' '+goodsName+' '+specification" /></div>
											</s:a>
											
											<s:if test="(#prePrice=@com.haozhuoji.mall.util.Arith@add(#prePrice,product_price))==-1||#sta.index!=goodsList.size()-1">
												<div class="space">+</div>
											</s:if>
										</s:iterator>
									</div>
									<div class="space" style="padding:0 30px">=</div>
									<div class="right">
										<div>套&nbsp;&nbsp;装&nbsp;&nbsp;价：<span>¥<s:property value="@com.haozhuoji.mall.util.Arith@format(price)" /></span></div>
										<div>原&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：¥<s:property value="@com.haozhuoji.mall.util.Arith@format(#prePrice)" /></div>
										<div>立即节省：¥<s:property value="@com.haozhuoji.mall.util.Arith@format(#prePrice-price)" /></div>
										<s:if test="amount>0">
											<s:div cssClass="enter_cart" onclick="addBundling(%{bundlingID},1)">购买套餐</s:div>
										</s:if>
										<s:else>
											<div class="enter_cart" style="background-color:#999999">暂时缺货</div>
										</s:else>
									</div>
								</s:div>
							</s:iterator>
						</div>
					</s:if>
					<div class="itemFrame">
						<div class="titil">规格参数</div>
						<div class="speci">
							<div class="item">商品名称：<s:property value="goodsName" /></div>
							<div class="item">商品品牌：<s:property value="brand" /></div>
							<div class="item">商品编号：<s:property value="goodsID" /></div>
							<s:if test="productNumber!=null&&!productNumber.equal('')">
								<div class="item">商品条码：<s:property value="productNumber" /></div>
							</s:if>
							<s:iterator value="properties==''?null:properties.split('\r\n')" var="pros">
								<div class="item"><s:property value="#pros" /></div>
							</s:iterator>
						</div>
					</div>
					<div class="itemFrame">
						<div class="titil">商品介绍</div>
						<div class="goodsDetail">
							<s:property value="descriptionPage" escape="false" />
						</div>
					</div>
					<div class="itemFrame">
						<div class="titil">商品评论</div>
						<script type="text/javascript">
							$(function(){
								$(".nextPre").click(function(){
									getComment(parseInt($(this).attr("currentPage")));
								});
								function getComment(currentPage){
									$.ajax({
										type:"post",
										url:"<s:property value="@com.haozhuoji.mall.util.Constant@http_p+'/getComment.html?goodsID='+goodsID"/>&page.currentPage="+currentPage,
										success:function(data){
											data = eval("("+data+")");
											if(data.comment.length>0){
												$("#commentContent").html("");
											}
											for(var i = 0;i<data.comment.length;i++){
												var d = data.comment[i];
												var c = $("#cloneCommentFrmae").clone(true).css({display:'block'}).removeAttr("id");
												c.find(".option").text(d.nickName+"：");
												c.find(".value>span").text(d.content);
												if(d.reply=='null'){
													c.find(".reply").remove();
												}else{
													c.find(".reply").text("管理员回复："+d.reply);
												}
												
												$("#commentContent").append(c);
											};
											if(data.next!=null){
												var c=$("#c_nextPre").clone(true).css({display:'block'}).removeAttr("id").text('下一页').attr("currentPage",currentPage+1);
												$("#commentContent").append(c);
											}
											if(data.pre!=null){
												var c=$("#c_nextPre").clone(true).css({display:'block'}).removeAttr("id").text('上一页').attr("currentPage",currentPage-1);
												$("#commentContent").append(c);
											};
										}
									});
								}
								getComment(1);
							});
						</script>
						<div class="item" id="cloneCommentFrmae" style="display:none">
							<div class="option"></div>
							<div class="value">
								<span></span>
								<div class="reply"></div>
							</div>
						</div>
						<div class="nextPre" id="c_nextPre" style="margin-right:30px;float:right;width:50px;border:1px solid #dddddd;background-color:#eeeeee;text-align:center;color:#666666;cursor:pointer;display:none"></div>
						<div class="comment" id="commentContent">
						</div>
					</div>
				</div>
			</div>
		</s:else>
		<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"1","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","weixin","tqf","renren","tieba","sqq","copy"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","weixin","tqf","renren","tieba","sqq","copy"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp" />
	</body>
</html>
