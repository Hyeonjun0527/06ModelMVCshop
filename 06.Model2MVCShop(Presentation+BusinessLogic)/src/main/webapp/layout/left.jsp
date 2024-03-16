<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model2.mvc.service.domain.User"%>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function history() {
		popWin = window
				.open(
						"/cookie/createHistory",
						"popWin",
						"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}
</script>

</head>

<body leftmargin="0"
	topmargin="0" marginwidth="0" marginheight="0">


	<div class="container">
		<c:if test="${user != null}">
			<div class="item button">
				<a href="/user/getUser?userId=${user.userId }" target="rightFrame">개인정보조회</a>
			</div>
		</c:if>

		<c:if test="${user.role == 'admin'}">
			<div class="item button">
				<a href="/user/listUser" target="rightFrame">회원정보조회</a>
			</div>
		</c:if>

		<c:if test="${user.role == 'admin'}">
			<div class="item button">
				<a href="../product/addProductView.jsp;" target="rightFrame">판매상품등록</a>
			</div>
			<div class="item button">
				<a href="/product/listProduct?menu=manage" target="rightFrame">판매상품관리</a>
			</div>
		</c:if>
		<div class="item button">
			<a href="/product/listProduct?menu=search" target="rightFrame">상 품 검 색</a>
		</div>

		<c:if test="${user != null && user.role == 'admin'}">
			<div class="item button">
				<a href="/purchase/listPurchase?menu=manage" target="rightFrame">판매이력조회</a>
			</div>
		</c:if>

		<c:if test="${user != null && user.role == 'user'}">
			<div class="item button">
				<a href="/purchase/listPurchase?menu=search" target="rightFrame">구매이력조회</a>
			</div>

		</c:if>

		<c:if test="${user != null && user.role == 'user'}">
		<div class="item button">
			<a href="/cookie/createLike?menu=search&from=left.jsp" target="rightFrame">찜 리스트</a>
		</div>
		</c:if>
		<div class="item button">
			<a href="javascript:history()">최근 본 상품</a>
		</div>
	</div>
</body>

</html>
