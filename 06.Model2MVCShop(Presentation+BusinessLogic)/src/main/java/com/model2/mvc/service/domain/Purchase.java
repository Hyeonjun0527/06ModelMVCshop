package com.model2.mvc.service.domain;

import java.sql.Date;

//has a �Ѱ� �ν��Ͻ�ȭ �ؼ� ����
//����ȭ������ �߻��Ѵٴ°� has a ���ִ� �ڱ��ʵ带 �ڱ� �޼��忡�� ������ 
//�̱���?

public class Purchase {//�ʵ�� �ͽ������޸� ����޸� use���� �ν��Ͻ�ȭ�ؼ� ���� ����� �ν��ϴ� ������ 
	
	private User buyer;//PK
	private String divyAddr;//����ּ�receiverAddr
	private String divyDate;//����������
	private String divyRequest;//���ſ�û����
	private Date orderDate;//�ֹ��� sysdate
	private String paymentOption;
	//"���ݱ���" "�ſ뱸��" 
	private Product purchaseProd;//PK
	private String receiverName;//�������̸�
	private String receiverPhone;//�����ڿ���ó
	private String tranCode;
	//TRAN_STATUS_CODE��
	// �Ǹ���/���ſϷ� ����ϱ�/ ����� / ��ۿϷ�
	private int tranNo;//PK
	
	public Purchase(){
	}
	
	public User getBuyer() {
		return buyer;
	}
	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}
	public String getDivyAddr() {
		return divyAddr;
	}
	public void setDivyAddr(String divyAddr) {
		this.divyAddr = divyAddr;
	}
	public String getDivyDate() {
		return divyDate;
	}
	public void setDivyDate(String divyDate) {
		this.divyDate = divyDate;
	}
	public String getDivyRequest() {
		return divyRequest;
	}
	public void setDivyRequest(String divyRequest) {
		this.divyRequest = divyRequest;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getPaymentOption() {
		return paymentOption;
	}
	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}
	public Product getPurchaseProd() {
		return purchaseProd;
	}
	public void setPurchaseProd(Product purchaseProd) {
		this.purchaseProd = purchaseProd;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverPhone() {
		return receiverPhone;
	}
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}
	public String getTranCode() {
		return tranCode;
	}
	public void setTranCode(String tranCode) {
		this.tranCode = tranCode;
	}
	public int getTranNo() {
		return tranNo;
	}
	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}
	
	@Override
	public String toString() {
		return "Purchase [buyer=" + buyer + ", divyAddr=" + divyAddr + ", divyDate=" + divyDate + ", divyRequest="
				+ divyRequest + ", orderDate=" + orderDate + ", paymentOption=" + paymentOption + ", purchaseProd="
				+ purchaseProd + ", receiverName=" + receiverName + ", receiverPhone=" + receiverPhone + ", tranCode="
				+ tranCode + ", tranNo=" + tranNo + "]";
	}
}