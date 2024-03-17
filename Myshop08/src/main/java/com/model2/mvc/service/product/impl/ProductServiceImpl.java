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

		//판매중으로 바꿔야함
		product.setProTranCode("a");

		return product;
	}
	public Product getProduct(int prodNo) throws Exception {
		return productDao.findProduct(prodNo);
	}
	public Product updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);//원래트랜코드도 유지해 왜냐면 원래있던거를 가져다가 수정해서 건내주기때문
		return  product;
	}
	public Map<String,Object> getProductList(Search search) throws Exception {
		return productDao.getProductList(search);
	}
}