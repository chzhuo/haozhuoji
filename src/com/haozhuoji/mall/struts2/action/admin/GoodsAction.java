package com.haozhuoji.mall.struts2.action.admin;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.ImageUtils;

@Controller("goodsAction")
@Scope("prototype")
/**
 * 用户后台的管理商品
 * @author Chen Zhuo
 *
 */
public class GoodsAction extends BaseAction<Goods>{
	
	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	@Resource(name="goodsTypeService")
	private GoodsTypeService goodsTypeService;
	
	private Page page = new Page();
	
	private String dir;
	
	//转到的jsp页面
	private String jspPage;
	
	private Boolean newGoods=false;
	/**
	 * 查看商品
	 * @return
	 * @throws Exception
	 */
	public String listGoods() throws Exception{
		page.setOptionOfPage(40);
		if(model.getKeyWord()!=null){			
			model.setKeyWord(new String(model.getKeyWord().getBytes("iso8859-1")));
		}
		goodsService.page(model, page);
		List<Goods> goodsList = goodsService.adminSearch(model, page);
		request.setAttribute("goodsList", goodsList);
		
		request.setAttribute("goodsTypeList", goodsTypeService.getAllGoodsType());
		return "listGoods";
	}
	
	/**
	 * 增加商品
	 * @return
	 */
	public String add(){
		Goods goods = new Goods();
		BeanUtils.copyProperties(model, goods);
		goods.setUpdateTimeStamp(System.currentTimeMillis());
		goodsService.insert("Goods.insert", goods);
		BeanUtils.copyProperties(goods,model);
		newGoods=true;
		return "updateProperties";
	}
	/**
	 * 更新商品
	 * @return
	 */
	public String update(){
		if(model.getGoodsID()==null){
			request.setAttribute("errorMessage", "商品ID不能为空");
			return "index";
		}
		Goods goods = new Goods();
		BeanUtils.copyProperties(model, goods);
		goods.setUpdateTimeStamp(System.currentTimeMillis());
		goodsService.update("Goods.update", goods);
		if(newGoods){
			model = goodsService.getObject("Goods.getObject", goods);
			return "updatePage";
		}
		return "redireact_listGoods";
	}
	
	/**
	 * 转到跟新页面
	 * @return
	 */
	public String toUpdate(){
		if(model.getGoodsID()==null){
			request.setAttribute("errorMessage", "商品ID不能为空");
			return "index";
		}
		if(jspPage!=null&&jspPage.equals("addUpdateInfo")){
			request.setAttribute("goodsTypeList", goodsTypeService.getAllGoodsType());
		}
		Goods goods = new Goods();
		goods.setGoodsID(model.getGoodsID());
		model = goodsService.getObject("Goods.getObject", goods);
		return "jspPage";
	}
	
	/**
	 * 转到增加商品
	 * @return
	 */
	public String toAdd(){
		newGoods = true;
		request.setAttribute("goodsTypeList", goodsTypeService.getAllGoodsType());
		return "addUpdateInfo";
	}
	
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
//	//后台根据关键字查询商品
//	private String key;
//	
//	private float quality;
//	
//	//用户ajax交互信息
//	private String message;
//	
	private File upfile;
	
	private String upfileFileName;
	
	//根据商品ID存储商品的图片，
	public void saveImage() throws Exception{
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if(model.getGoodsID()!=null&&upfile!=null&&upfileFileName!=null){
			ImageUtils imageUtils = new ImageUtils();
			//主图片
			String fileNamePre = null;
			if(dir!=null&&dir.equals("main")){				
				String goodsImagePath = Constant.localGoodsImage+"/"+model.getGoodsID()+"/main";
				if(upfileFileName.startsWith("main.")){					
					fileNamePre = "main/"+imageUtils.zipGoodsMain(upfile, goodsImagePath);
				}else{
					fileNamePre = "main/"+imageUtils.zipGoodsSliderImg(upfile, goodsImagePath,upfileFileName.split("\\.")[0]);					
				}
			}else{
				String goodsImagePath = Constant.localGoodsImage+"/"+model.getGoodsID()+"/page";
				fileNamePre = "page/"+imageUtils.saveImg(upfile, goodsImagePath, upfileFileName.split("\\.")[upfileFileName.split("\\.").length-1]);
			}
			
			response.getWriter().write("{'url':'images/goods/"+model.getGoodsID()+"/"+fileNamePre+"','title':'','state':'SUCCESS','original':'"+upfileFileName+"' }");
			
		}else{
			response.getWriter().write("{'title':'','state':'错误'}");			
		}
		
	}
	
	//便于前台查看图片
	public void getImages() throws Exception{
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if(model.getGoodsID()!=null){
			StringBuffer sb = new StringBuffer();
			
			String goodsImagePath = Constant.localGoodsImage+"/"+model.getGoodsID()+"/page";
			File dir =new File(goodsImagePath);
			if(dir.exists()){
				for(File f:dir.listFiles()){
					sb.append("images/goods/"+model.getGoodsID()+"/page/"+f.getName());
					sb.append("ue_separate_ue");
				}
			}
			
			goodsImagePath = Constant.localGoodsImage+"/"+model.getGoodsID()+"/main";
			dir =new File(goodsImagePath);
			if(dir.exists()){
				for(File f:dir.listFiles()){
					if(f.getName().contains("450x450")){						
						sb.append("images/goods/"+model.getGoodsID()+"/main/"+f.getName());
						sb.append("ue_separate_ue");
					}
				}
			}
			response.getWriter().write(sb.toString());
		}else{
			throw new Exception("请求失败，goodsID不能为空");
		}
	}
	
	//根据商品ID和图片名删除图片
	public void deletePageImg() throws Exception{
		if(upfileFileName.contains("450x450")){
			File file = new File(Constant.localGoodsImage+"/"+model.getGoodsID()+"/main");
			String pre = upfileFileName.split("_")[0];
			if(file.exists()&&file.isDirectory()){
				for(File f:file.listFiles()){
					if(f.getName().contains(pre)){
						f.delete();
					}
				}
			}
		}else{
			File file = new File(Constant.localGoodsImage+"/"+model.getGoodsID()+"/page/"+upfileFileName);
			if(file.exists()&&file.isFile()){
				file.delete();
			}
		}
	}
	
	public void deleteGoods(){
		if(model.getGoodsID()==null){
			flushJson("{status:'参数错误'}");
		}else{
			Goods g = new Goods();
			BeanUtils.copyProperties(model, g);
			goodsService.delete("Goods.deleteGoods", g);
			
			File f = new File(Constant.localGoodsImage+"\\"+model.getGoodsID());
			if(f.isDirectory()&&f.exists()){				
				this.delFloder(f);
				f.delete();
			}
			flushJson("{status:'success'}");
		}
	}
	private void delFloder(File file){
		for(File f:file.listFiles()){
			if(f.isDirectory()){
				delFloder(f);
				f.delete();
			}else{
				f.delete();
			}
		}
	}

//	@JSON(serialize=false)
//	public List<Goods> getGoodslist() {
//		return goodslist;
//	}
//	public String getPromotion() {
//		return promotion;
//	}
//	
//	public float getQuality() {
//		return quality;
//	}
//
//	public void setQuality(float quality) {
//		this.quality = quality;
//	}
//
//	public void setPromotion(String promotion) {
//		this.promotion = promotion;
//	}
//	
//	public String getKey() {
//		return key;
//	}
//
//	public void setKey(String key) {
//		this.key = key;
//	}
//
//	public void setGoodslist(List<Goods> goodslist) {
//		this.goodslist = goodslist;
//	}
//	public String getMessage() {
//		return message;
//	}
//	public void setMessage(String message) {
//		this.message = message;
//	}
//	@JSON(serialize=false)
//	public File getUpfile() {
//		return upfile;
//	}
//	
//	public void setUpfile(File upfile) {
//		this.upfile = upfile;
//	}
//	@JSON(serialize=false)
//	public String getUpfileFileName() {
//		return upfileFileName;
//	}
//
//	public void setUpfileFileName(String upfileFileName) {
//		this.upfileFileName = upfileFileName;
//	}
//	
	
	public Boolean getNewGoods() {
		return newGoods;
	}

	public String getDir() {
		return dir;
	}

	public void setDir(String dir) {
		this.dir = dir;
	}

	public void setNewGoods(Boolean newGoods) {
		this.newGoods = newGoods;
	}

	public String getJspPage() {
		return jspPage;
	}

	public void setJspPage(String jspPage) {
		this.jspPage = jspPage;
	}

	public File getUpfile() {
		return upfile;
	}

	public void setUpfile(File upfile) {
		this.upfile = upfile;
	}

	public String getUpfileFileName() {
		return upfileFileName;
	}

	public void setUpfileFileName(String upfileFileName) {
		this.upfileFileName = upfileFileName;
	}
}
