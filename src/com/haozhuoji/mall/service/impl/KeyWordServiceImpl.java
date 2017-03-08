package com.haozhuoji.mall.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.KeyWord;
import com.haozhuoji.mall.service.KeyWordService;

@Service("keyWordService")
public class KeyWordServiceImpl extends BaseServiceImpl<KeyWord> implements	KeyWordService {

	@Override
	public void addKeyWord(String keyWord) {
		KeyWord k = new KeyWord();
		k.setWord(keyWord);
		KeyWord kk = this.getObject("KeyWord.getObject", k);
		if(kk==null){
			this.insert("KeyWord.add", k);
		}else{
			this.update("KeyWord.update", kk);
		}
	}
}
