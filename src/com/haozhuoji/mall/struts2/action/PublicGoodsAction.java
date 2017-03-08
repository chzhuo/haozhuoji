package com.haozhuoji.mall.struts2.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.haozhuoji.mall.domain.BrowseHistory;
import com.haozhuoji.mall.domain.Bundling;
import com.haozhuoji.mall.domain.Comment;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.domain.Promotion;
import com.haozhuoji.mall.domain.Slider;
import com.haozhuoji.mall.domain._Constant;
import com.haozhuoji.mall.service.BrowseHistoryService;
import com.haozhuoji.mall.service.BundlingService;
import com.haozhuoji.mall.service.CommentService;
import com.haozhuoji.mall.service.ConstantService;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.service.KeyWordService;
import com.haozhuoji.mall.service.PromotionService;
import com.haozhuoji.mall.service.SliderService;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.DateUtil;
import com.haozhuoji.mall.util.ValidateUtil;

@Controller("publicGoodsAction")
@Scope("prototype")
public class PublicGoodsAction extends BaseAction<Goods>{
	
	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	@Resource(name="bundlingService")
	private BundlingService bundlingService;
	
	@Resource(name="commentService")
	private CommentService commentService;
	
	@Resource(name="browseHistoryService")
	private BrowseHistoryService browseHistoryService;
	
	@Resource(name="goodsTypeService")
	private GoodsTypeService goodsTypeService;
	
	@Resource(name="keyWordService")
	private KeyWordService keyWordService;
	
	@Resource(name="constantService")
	private ConstantService constantService;
	
	@Resource(name="promotionService")
	private PromotionService promotionService;
	
	@Resource(name="sliderService")
	private SliderService sliderService;
	
	private Page page=new Page();
	//网站首页
	public String index(){
		_Constant c =new _Constant();
		c.setK("indexGoods");
		request.setAttribute("constantList", constantService.getList("Constant.getGoodsByValue2", c));

		//获取促销活动
		Promotion p = new Promotion();
		p.setUpIndex(true);
		request.setAttribute("indexPromotionList", promotionService.getList("Promotion.getList", p));
		
		//获取幻灯片
		request.setAttribute("indexSliderList", sliderService.getList("Slider.getAll", null));
		return "success";
	}
	
	/**
	 * 静态页面
	 * @return
	 */
	public String html(){
		String uri = request.getRequestURI().toString();
		String filePath = request.getServletContext().getRealPath(uri);
		File f = new File(filePath);
		if(f.isFile()&&f.exists()){			
			try {
				response.setContentType("text/html");
				InputStream is = new FileInputStream(f);
				OutputStream os = response.getOutputStream();
				byte[] bytes = new byte[1024];
				int length = 0;
				while((length = is.read(bytes))>0){
					os.write(bytes, 0, length);
				}
				is.close();
				os.flush();
				os.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}else{
			return "404";
		}
	}
	

	/**
	 * 查询商品
	 * @return
	 * @throws Exception
	 */
	public String search() throws Exception{
		String keyWord = model.getKeyWord();
		if(!ValidateUtil.validateString(keyWord)){
			return null;			
		}else{
			keyWord = new String(keyWord.getBytes("iso-8859-1"),"utf-8");
			model.setKeyWord(keyWord);
			model.setSell(false);
			this.search2Type();
			
			//搜索词写入数据库
			keyWordService.addKeyWord(model.getKeyWord());
			
			return "classPage";
		}
	}
	private void search2Type() throws Exception{
		if(model.getTypeID()==null){
			model.setTypeID(0L);
		}
		Goods g = new Goods();
		BeanUtils.copyProperties(model, g);
		g.setSell(true);
		page.setOptionOfPage(28);
		goodsService.page(g, page);
		
		//获取商品
		List<Goods> goodsList = goodsService.search(g, page);
		request.setAttribute("goodsList", goodsList);
		
		//获取商品对应类
		request.setAttribute("goodsTypeList", goodsTypeService.getTypeByGoods(g));
		
		//获取单类
		GoodsType gt = new GoodsType();
		gt.setTypeID(model.getTypeID());
		gt=goodsTypeService.getObject("GoodsType.getList", gt);
		model.setFullTypeID(gt.getFullTypeID());
		model.setFullTypeName(gt.getFullTypeName());
	}
	/**
	 * 根据商品类型查找商品
	 * @return
	 * @throws Exception
	 */
	public String goodsType() throws Exception{
		if(model.getTypeID()==null){			
			//得到商品类型
			String goodsTypeID = request.getRequestURI().replaceAll("/t_(\\d+)\\.html", "$1");
			model.setTypeID(Long.parseLong(goodsTypeID));
		}
		this.search2Type();
		return "classPage";
	}
	
	/**
	 * 商品详情页
	 * @return
	 */
	public String detailPage(){
		String goodsID = request.getRequestURI().replaceAll("/g_(\\d+)\\.html", "$1");
		if(goodsID.matches("\\d+")){
			Goods g = new Goods();
			g.setGoodsID(Long.parseLong(goodsID));
			g.setSell(true);
			model = goodsService.getObject("Goods.getObject", g);
			if(model!=null){
				File dir = new File(Constant.localGoodsImage+"/"+model.getGoodsID()+"/main");
				if(dir.exists()&&dir.isDirectory()){
					List<String> list = new ArrayList<String>();
					for(File f:dir.listFiles()){
						if(f.getName().matches("\\d+_450x450\\.jpg")){
							list.add(f.getName().replaceAll("(\\d+)_450x450\\.jpg", "$1"));
						}
					}
					Object[] objects = list.toArray();
					Arrays.sort(objects);
					request.setAttribute("sliderGoods", objects);
				}
				request.setAttribute("relatedGoods", goodsService.getList("Goods.getRelatedGoods", model));
				request.setAttribute("relevantGoodsList", goodsService.getList("Goods.getRelevantGoodsList", model));
				//查询优惠套餐
				Bundling b = new Bundling();
				b.setGoodsID(Long.parseLong(goodsID));
				List<Bundling> bundlingList = bundlingService.getList("Bundling.getBundlingGoodsList", b);
				request.setAttribute("bundlingList", bundlingList);
				
				//商品评价评分
				Comment c = new Comment();
				c.setGoodsID(model.getGoodsID());
				c = commentService.getObject("Comment.getCeilAvgPointCount", c);
				request.setAttribute("comment",c );
				
				//如果用户登陆，写入浏览记录
				if(user!=null){
					BrowseHistory bh = new BrowseHistory();
					bh.setUserID(user.getUserID());
					bh.setGoodsID(model.getGoodsID());
					browseHistoryService.addBH(bh);
				}
				
				//为商品增加浏览次数
				Goods g1 = new Goods();
				g1.setGoodsID(model.getGoodsID());
				g1.setBrowse_count(1);
				goodsService.update("Goods.update", g1);
			}
		}else{
			model=null;
		}
		return "detailPage";
	}
	
	/**
	 * 得到商品评论
	 */
	public void getComment(){
		StringBuffer sb = new StringBuffer();
		sb.append("{comment:[");
		if(model.getGoodsID()!=null){
			Comment c = new Comment();
			c.setShowFlag(true);
			c.setDelFlag(false);
			c.setGoodsID(model.getGoodsID());
			page.setOptionOfPage(15); //设置评论每页显示数目
			page.setTotalOption(commentService.getInt("Comment.getCount", c));
			HashMap<String,Object> hashMap = new HashMap<String,Object>();
			hashMap.put("Page", page);
			hashMap.put("Comment", c);
			for(Comment co:commentService.getListHashMap("Comment.getList", hashMap)){
				sb.append("{nickName:'"+co.getNickName().replaceAll("(.{1,2}).*", "$1**")+"',content:'"+co.getContent()+"',reply:'"+co.getReply()+"',createDateTime:'"+DateUtil.format(co.getCreateDateTime())+"'},");
			}
			if(sb.charAt(sb.length()-1)==','){
				sb.deleteCharAt(sb.length()-1);
			}
			sb.append("]");
			if(page.getCurrentPage()<page.getTotalPage()){
				sb.append(",next:true");
			}
			if(page.getCurrentPage()!=1){
				sb.append(",pre:true");
			}
		}
		sb.append("}");
		flushJson(sb.toString());
	}
	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
}
