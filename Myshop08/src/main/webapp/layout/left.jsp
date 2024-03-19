<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.model2.mvc.service.domain.User"%>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="${pageContext.request.contextPath}/css/layout/left.css" rel="stylesheet" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script>
		const userId = "${user.userId}";
		console.log("userId"+userId);
	</script>
	<script src="${pageContext.request.contextPath}/javascript/layout/left.js">
	</script>
</head>

<body leftmargin="0"
	topmargin="0" marginwidth="0" marginheight="0">


	<div class="container">
		<c:if test="${user != null}">
			<div class="item button">
				����������ȸ
			</div>
		</c:if>

		<c:if test="${user.role == 'admin'}">
			<div class="item button">
				ȸ��������ȸ
			</div>
		</c:if>

		<c:if test="${user.role == 'admin'}">
			<div class="item button">
				�ǸŻ�ǰ���
			</div>
			<div class="item button">
				�ǸŻ�ǰ����
			</div>
		</c:if>
		<div class="item button">
			�� ǰ �� ��
		</div>

		<c:if test="${user != null && user.role == 'admin'}">
			<div class="item button">
				�Ǹ��̷���ȸ
			</div>
		</c:if>

		<c:if test="${user != null && user.role == 'user'}">
			<div class="item button">
				�����̷���ȸ
			</div>

		</c:if>

		<c:if test="${user != null && user.role == 'user'}">
		<div class="item button">
			�� ����Ʈ
		</div>
		</c:if>
		<div class="item button">
			�ֱ� �� ��ǰ
		</div>
	</div>





</body>

</html>
