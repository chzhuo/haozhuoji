package ssh;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.UserService;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.DesEncrypt;
import com.haozhuoji.mall.util.ImageUtils;

public class SSH {
	//@Test
	public void t1() throws Exception{
		ImageUtils iutils= new ImageUtils();
		ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		GoodsService service = (GoodsService) ac.getBean("goodsService");
		for(long i=0;i<319;i++){			
			Goods g = new Goods();
			g.setGoodsID(i);
			g=service.getObject("Goods.getObject", g);
			if(g!=null){
				File f = new File("C:/Users/UU/Desktop/haozhuojiSystem/apache-tomcat-7.0.52/webapps/fileSystem/images/goods-1/"+g.getProductNumber().trim());
				if(f.exists()&&f.isDirectory()){					
					for(File f1:f.listFiles()){
						if(f1.getName().startsWith("main.")){
							String imgName = iutils.zipGoodsMain(f1, "C:/Users/UU/Desktop/haozhuojiSystem/apache-tomcat-7.0.52/webapps/fileSystem/images/goods/"+g.getGoodsID()+"/main");
							g.setDescriptionPage(g.getDescriptionPage().replaceAll("/images/goods/"+g.getProductNumber()+"/"+f1.getName(), "filePath_filepath/images/goods/"+g.getGoodsID()+"/main/"+imgName));
						}else if(!f1.getName().startsWith("main-")){
							String imgName = iutils.saveImg(f1, "C:/Users/UU/Desktop/haozhuojiSystem/apache-tomcat-7.0.52/webapps/fileSystem/images/goods/"+g.getGoodsID()+"/page", f1.getName().split("\\.")[f1.getName().split("\\.").length-1]);
							g.setDescriptionPage(g.getDescriptionPage().replaceAll("/images/goods/"+g.getProductNumber()+"/"+f1.getName(), "filePath_filepath/images/goods/"+g.getGoodsID()+"/page/"+imgName));
						}
					}
				}
				Goods goods = new Goods();
				goods.setGoodsID(g.getGoodsID());
				goods.setDescriptionPage(g.getDescriptionPage());
				service.update("Goods.update", goods);
			}
		}
	}
	
	@Test
	public void t2() throws Exception{
		ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		UserService service = (UserService) ac.getBean("userService");
	}
	
	@Test
	public void t3() throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append("{commnet:[");
		sb.deleteCharAt(sb.length()-1);
		System.out.println(sb.toString());
	}
	
	@Test
	public void te(){
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(format1.format(new Date()));
	}
	
	@Test
	public void t4() throws Exception{
		String uploadFileName="ddd.cc";
		String fileName = uploadFileName.split("\\.")[uploadFileName.split("\\.").length-1];
		System.out.println(fileName);
	}

}
