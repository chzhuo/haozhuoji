package com.haozhuoji.mall.util;

public class Constant {
	public final static String xmlPath = "";
	//链接前缀地址
	public final static String domain = "www.haozhuoji.com";
	public final static String http_p = "http://"+domain;
	public final static String admin_p = "http://"+domain+"/admin";
	public final static String user_p = "http://"+domain+"/user"; 
	public final static String goodsType_p = http_p+"/t_";
	public final static String goods_p = http_p+"/g_";
	
	//文件路径地址
	public final static String file_p = "http://file.haozhuoji.com";
	public final static String goodsImage_p = file_p+"/images/goods";
	public final static String promotionImg_p = file_p+"/images/promotion";
	public final static String sliderImg_p = file_p+"/images/slider";
	
	//本地文件路径
	public final static String localFile_p = "/mnt/fileSystem";   //Linux 商品图片路径
	//public final static String localFile_p = "G:/haozhuji/haozhuojiSystem/fileSystem";
	public final static String localGoodsImage = localFile_p + "/images/goods";   //开发 商品图片路径	
	public final static String localSlider_p = localFile_p + "/images/slider";   //开发 商品图片路径	
	
	//UserID 加密解密密钥
	public final static String userCookieEncryptKey = "$^&dsg--848omwjd|ss\"|sg``13--=23";
	public final static String emailEncryptKey = "j8ls%8)*(_+1~/,\"df844))))+++!!~``sdufhweufljfeio";//此密码短期内不要改，不然不能解码

	//初始化参数
	public final static Integer maxOfAddress = 10;	
	public final static Double rechSendPrice = 7d;
	public final static Double addSendPrice = 1d;
	public final static Long orderDelayed = 6*60*60*1000L;
	
	//email
	public final static String emailUserName = "";
	public final static String emailPassword = "";
	public final static String emailHostServer = "smtp.163.com";
}