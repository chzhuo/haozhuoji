package com.haozhuoji.mall.service.impl;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.BrowseHistory;
import com.haozhuoji.mall.service.BrowseHistoryService;

@Service("browseHistoryService")
public class BrowseHistoryServiceImpl extends BaseServiceImpl<BrowseHistory> implements BrowseHistoryService {
	
	public void addBH(BrowseHistory bh){
		BrowseHistory b = this.getObject("BrowseHistory.getObject", bh);
		if(b==null){
			this.insert("BrowseHistory.add", bh);
		}else{
			this.update("BrowseHistory.update", b);
		}
	}
}
