package com.haozhuoji.mall.service;

import java.util.HashMap;
import java.util.List;

import com.haozhuoji.mall.domain.GoodsType;

/**
 * baseService
 * @author UU
 *
 * @param <T>
 */
public interface BaseService<T> {
	public void insert(String sqlMapId, T t);

	public void update(String sqlMapId, T t);

	public void delete(String sqlMapId, T t);

	public T getObject(String sqlMapId, T t);

	public List<T> getListHashMap(String sqlMapID, HashMap<String, Object> hashMap);
	public List<T> getList(String sqlMapID, T t);

	public Integer getInt(String sqlMapId, T t);
	public Integer getIntHashMap(String sqlMapId, HashMap<String, Object> hashMap);
}
