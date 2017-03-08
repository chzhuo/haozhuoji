package com.haozhuoji.mall.struts2.action.user;

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
import com.haozhuoji.mall.domain.Collection;
import com.haozhuoji.mall.domain.Comment;
import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.domain.Page;
import com.haozhuoji.mall.service.BrowseHistoryService;
import com.haozhuoji.mall.service.BundlingService;
import com.haozhuoji.mall.service.CollectionService;
import com.haozhuoji.mall.service.CommentService;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.GoodsTypeService;
import com.haozhuoji.mall.struts2.action.BaseAction;
import com.haozhuoji.mall.util.Constant;
import com.haozhuoji.mall.util.DateUtil;
import com.haozhuoji.mall.util.ValidateUtil;

@Controller("userGoodsAction")
@Scope("prototype")
public class UserGoodsAction extends BaseAction<Goods>{
	
	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	private Page page=new Page();
	
	@Resource(name="collectionService")
	private CollectionService cs;
	
	@Resource(name="browseHistoryService")
	private BrowseHistoryService bs;
	
	//增加收藏
	public void addCollection(){
		if(model.getGoodsID()==null){
			flushJson("{status:'参数异常'}");
		}else{
			Goods g =new Goods();
			g.setGoodsID(model.getGoodsID());
			g = goodsService.getObject("Goods.getObject", g);
			if(g==null||!g.getSell()){
				flushJson("{status:'该商品不存在或已下架'}");
				return;
			}
			Collection c = new Collection();
			c.setUserID(user.getUserID());
			c.setGoodsID(model.getGoodsID());
			cs.insert(c);
			flushJson("{status:'收藏成功'}");
		}
	}
	
	//查看收藏
	public String collectionList(){
		Collection c = new Collection();
		c.setUserID(user.getUserID());
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		page.setOptionOfPage(20);
		hashMap.put("Page", page);
		hashMap.put("Collection", c);
		page.setTotalOption(cs.getIntHashMap("Collection.getOptionCount", hashMap));
		request.setAttribute("collectionList", cs.getListHashMap("Collection.getPageList", hashMap));
		return "collectionList";
	}
	
	//删除收藏
	public void deleteCollection(){
		if(model.getGoodsID()==null){
			flushJson("{status:'参数错误'}");
		}else{
			Collection c = new Collection();
			c.setUserID(user.getUserID());
			c.setGoodsID(model.getGoodsID());
			cs.delete("Collection.delete", c);
			flushJson("{status:'success'}");
		}
	}
	//查看浏览记录
	public String BHList(){
		BrowseHistory b = new BrowseHistory();
		b.setUserID(user.getUserID());
		HashMap<String,Object> hashMap = new HashMap<String,Object>();
		page.setOptionOfPage(20);
		hashMap.put("Page", page);
		hashMap.put("BrowseHistory", b);
		page.setTotalOption(bs.getIntHashMap("BrowseHistory.getOptionCount", hashMap));
		request.setAttribute("collectionList", bs.getListHashMap("BrowseHistory.getPageList", hashMap));
		return "BHList";
	}
	
	//删除收藏
	public void deleteBH(){
		if(model.getGoodsID()==null){
			flushJson("{status:'参数错误'}");
		}else{
			BrowseHistory b = new BrowseHistory();
			b.setUserID(user.getUserID());
			b.setGoodsID(model.getGoodsID());
			bs.delete("BrowseHistory.delete", b);
			flushJson("{status:'success'}");
		}
	}
	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
}
