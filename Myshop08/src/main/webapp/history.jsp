<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--�����丮 ������ �ݺ��ϴµ� , ��ũ �ݺ��ؼ� ����µ� �����丮=prodNo --%>
<html>
<head>
<title>��� ��ǰ ����</title>
</head>
<link rel="stylesheet" href="/css/font.css" type="text/css">
<body class="default-font">
	����� ��� ��ǰ�� �˰� �ִ�
	<br>
	<br>

	<c:if test="${!empty products}">
		<c:forEach var="product" items="${products}">
			<c:if test="${!empty product}">
				<a href="/product/getProduct?prodNo=${product.prodNo}&menu=search"
					target="rightFrame">${product.prodName}</a>
				<br />
			</c:if>
		</c:forEach>
	</c:if>


	<button style="border: 0px; padding: 0px;">
		<div style="text-align: center;">
			<a href="/cookie/removeHistory?navigationPage=history.jsp"
				style="display: inline-block; background-color: #4CAF50; color: white; padding: 7px 10px; text-align: center; text-decoration: none; font-size: 16px; border-radius: 5px; cursor: pointer;">��Ű
				����</a>
		</div>
	</button>

</body>
</html>