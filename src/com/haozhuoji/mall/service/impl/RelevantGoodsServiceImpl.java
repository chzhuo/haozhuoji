package com.haozhuoji.mall.service.impl;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Goods;
import com.haozhuoji.mall.domain.RelevantGoods;
import com.haozhuoji.mall.service.GoodsService;
import com.haozhuoji.mall.service.RelevantGoodsService;

@Service("relevantGoodsService")
public class RelevantGoodsServiceImpl extends BaseServiceImpl<RelevantGoods> implements RelevantGoodsService{

	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	/**
	 * ret 字符串重复"re"开头，不存在商品'-'开头，数据库已有直接返回该商品ID
	 */
	public String checkGoodsIDs(RelevantGoods re) {
		String ret=null;
		//检测是否重复
		String[] s = re.getGoodsIDs().split("-");
		for(int i=0;i<s.length-1;i++){
			for(int j=i+1;j<s.length;j++){
				if(s[i].equals(s[j])){
					return "re"+s[i];
				}
			}
		}
		//检测是否存在该商品
		Goods g = new Goods();
		for(String goodsID:re.getGoodsIDs().split("-")){
			g.setGoodsID(Long.parseLong(goodsID));
			if(goodsService.getObject("Goods.getObject", g)==null){
				return "-"+goodsID;
			}
		}
		//检测数据库是否重复
		RelevantGoods rg = new RelevantGoods();
		rg.setNotInID(re.getNotInID());
		for(String goodsID:re.getGoodsIDs().split("-")){
			rg.setGoodsIDs(goodsID);
			List<RelevantGoods> rl = this.getList("RelevantGoods.checkGoodsID", rg);
			if(rl.size()>0){
				ret=goodsID;
				return ret;
			}
		}
		return ret;
	}
}
