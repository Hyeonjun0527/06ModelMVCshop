package com.model2.mvc.service.mapper;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface PurchaseMapper {

    public void addPurchase(Purchase purchase) throws Exception;
    public Purchase getPurchase(int tranNo) throws Exception;
    public List<Map<String,Object>> getPurchaseList(@Param("map") Map<String,Object> map) throws Exception;
    public Map<String,Object> getSaleList(Search search) throws Exception;
    public void updatePurchase(Purchase purchase) throws Exception;
    public void updateTranCode(Purchase purchase) throws Exception;
}
