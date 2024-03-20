<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.model2.mvc.service.domain.User" %>

<html>
<head>
    <title>Model2 MVC Shop</title>

    <link href="${pageContext.request.contextPath}/css/layout/top.css" rel="stylesheet" type="text/css">

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/javascript/layout/top.js"></script>

</head>

<body topmargin="0" leftmargin="0">

<div class="container">
    <c:if test="${!empty user}">
        <div class="item button">
        logout
        </div>
    </c:if>

    <c:if test="${empty user}">
        <div class="item button">
        login
        </div>
    </c:if>
</div>
</body>
</html>
