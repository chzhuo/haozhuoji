package ssh;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.util.ImageUtils;

public class Dao{
	public Connection con;
	public PreparedStatement pst;
	public ResultSet rs;
	//获得数据库连接
	public void getConnection() throws Exception{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://115.29.36.135:3306/aitoday", "root","hello@today159");	
	}
	//关闭连接
	public void close() throws Exception{
		if(rs!=null){
			rs.close();
		}
		if(pst!=null){
			pst.close();
		}
		if(con!=null){
			con.close();
		}
	}
	public void dd() throws Exception{
		String sql="select goodsID,descriptionPage,productNumber from goods ";
		pst=con.prepareStatement(sql);
		rs = pst.executeQuery();
		while(rs.next()){
			Goods g = new Goods();
			g.setGoodsID(rs.getLong(1));
			g.setDescriptionPage(rs.getString(2));
			g.setProductNumber(rs.getString(3));
			d(g);
		}
	}
	public void d(Goods g) throws Exception{
		
			ImageUtils iutils= new ImageUtils();
				File f = new File("D:/goods-1/"+g.getProductNumber().trim());
				if(f.exists()&&f.isDirectory()){					
					for(File f1:f.listFiles()){
						if(f1.getName().startsWith("main.")){
							String imgName = iutils.zipGoodsMain(f1, "D:/goods/"+g.getGoodsID()+"/main");
							g.setDescriptionPage(g.getDescriptionPage().replaceAll("/images/goods/"+g.getProductNumber()+"/"+f1.getName(), "http://file.haozhuoji.com/images/goods/"+g.getGoodsID()+"/main/"+imgName));
						}else if(!f1.getName().startsWith("main-")){
							String imgName = iutils.saveImg(f1, "D:/goods/"+g.getGoodsID()+"/page", f1.getName().split("\\.")[f1.getName().split("\\.").length-1]);
							g.setDescriptionPage(g.getDescriptionPage().replaceAll("/images/goods/"+g.getProductNumber()+"/"+f1.getName(), "http://file.haozhuoji.com/images/goods/"+g.getGoodsID()+"/page/"+imgName));
						}
					}
				}
				Goods goods = new Goods();
				goods.setGoodsID(g.getGoodsID());
				goods.setDescriptionPage(g.getDescriptionPage());
		
		
		String sql="update goods set descriptionPage = ? where goodsID = ?";
		PreparedStatement pst=con.prepareStatement(sql);
		pst.setString(1, goods.getDescriptionPage());
		pst.setLong(2, goods.getGoodsID());
		pst.executeUpdate();
	}
	//主函数
	public static void main(String[] args) throws Exception {
		Dao dao = new Dao();
		dao.getConnection();
		dao.dd();
		dao.close();
	}
}
