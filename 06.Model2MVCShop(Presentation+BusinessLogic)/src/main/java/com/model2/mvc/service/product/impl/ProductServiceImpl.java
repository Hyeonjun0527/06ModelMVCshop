package com.model2.mvc.service.product.impl;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{

	///Field
	private ProductDao productDao;

	@Autowired
	public void setProductDao(@Qualifier("productDaoImpl") ProductDao productDao) {
		this.productDao = productDao;
	}

	///Constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public Product addProduct(Product product) throws Exception {
		productDao.insertProduct(product);

		//�Ǹ������� �ٲ����
		product.setProTranCode("a");

		return product;
	}
	public Product getProduct(int prodNo) throws Exception {
		return productDao.findProduct(prodNo);
	}
	public Product updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);//����Ʈ���ڵ嵵 ������ �ֳĸ� �����ִ��Ÿ� �����ٰ� �����ؼ� �ǳ��ֱ⶧��
		return  product;
	}
	public Map<String,Object> getProductList(Search search) throws Exception {
		return productDao.getProductList(search);
	}
}