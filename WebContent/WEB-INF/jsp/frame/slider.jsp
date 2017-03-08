<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
	ul,li {list-style:none;}
	img {border:0;}
	.wrapper {width:1000px; margin:0 auto;height:240px}
	#focus {width:1000px;height:240px; overflow:hidden; position:relative;}
	#focus ul {height:380px; position:absolute;}
	#focus ul li {float:left; width:1000px; height:240px; overflow:hidden; position:relative; background:#000;}
	#focus ul li div {position:absolute; overflow:hidden;}
	#focus .btnBg {position:absolute; width:1190px; height:20px; left:0; bottom:0; background:#000;}
	#focus .btn {position:absolute; width:780px; height:10px; padding:5px 10px; right:0; bottom:0; text-align:right;}
	#focus .btn span {display:inline-block; _display:inline; _zoom:1; width:25px; height:10px; _font-size:0; margin-left:5px; cursor:pointer; background:#fff;}
	#focus .btn span.on {background:#fff;}
</style>
<script type="text/javascript">
$(function() {
	var sWidth = 1000;
	var len = $("#focus ul li").length; 
	var index = 0;
	var picTimer;
	
	
	var btn = "<div class='btnBg'></div><div class='btn'>";
	for(var i=0; i < len; i++) {
		btn += "<span></span>";
	}
	$("#focus").append(btn);
	$("#focus .btnBg").css("opacity",0.5);

	$("#focus .btn span").css("opacity",0.4).mouseenter(function() {
		index = $("#focus .btn span").index(this);
		showPics(index);
	}).eq(0).trigger("mouseenter");
	$("#focus ul").css("width",sWidth * (len));
	

	$("#focus").hover(function() {
		clearInterval(picTimer);
	},function() {
		picTimer = setInterval(function() {
			showPics(index);
			index++;
			if(index == len) {index = 0;}
		},4000); 
	}).trigger("mouseleave");
	

	function showPics(index) {
		var nowLeft = -index*sWidth; 
		$("#focus ul").stop(true,false).animate({"left":nowLeft},100); 

		$("#focus .btn span").stop(true,false).animate({"opacity":"0.4"},300).eq(index).stop(true,false).animate({"opacity":"1"},300); 
	}
});
</script>
<div class="wrapper">
	<div id="focus">
		<ul>
			<s:iterator value="#request.indexSliderList">
				<li><a href="<s:property value="href" />"><img src="<s:property value="@com.haozhuoji.mall.util.Constant@sliderImg_p+'/'+imgName" />"/></a></li>
			</s:iterator>
		</ul>
	</div>

</div>