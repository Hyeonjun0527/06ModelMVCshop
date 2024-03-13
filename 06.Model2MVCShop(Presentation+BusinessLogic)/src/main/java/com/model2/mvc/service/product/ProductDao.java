package com.model2.mvc.service.product;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

import java.util.Map;


//==> ȸ���������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
public interface ProductDao {

	void insertProduct(Product product) throws Exception;
	public Product findProduct(int prodNo) throws Exception;
	public Map<String,Object> getProductList(Search search) throws Exception;
	public void updateProduct(Product productVO) throws Exception;

}