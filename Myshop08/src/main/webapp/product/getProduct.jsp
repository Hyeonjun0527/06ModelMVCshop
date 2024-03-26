<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ��ǰ �� ��ȸ-->
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%--
<%
Product productVO=(Product)request.getAttribute("productVO");
	session.setAttribute("purchaseProd", productVO);
	//System.out.println(request.getParameter("menu"));
%>
--%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <%--    ��Ʈ��Ʈ��--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%-- ��Ʈ��Ʈ�� Dropdown Hover CSS JS--%>
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

    <%--    �����--%>
    <link rel="stylesheet" href="/css/font.css" type="text/css">
    <style>
        body {
            padding-top: 50px;
        }

        .max-size {
            max-width: 100px !important;
            max-height: 100px !important;
        }
    </style>
    <%--    <title>��ǰ����ȸ</title>--%>
</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/layout/toolbar.jsp"/>
<!-- ToolBar End /////////////////////////////////////-->
<%-- method="post" enctype="multipart/form-data"--%>
<div class="container default-font">

    <div class="page-header">
        <h3 class=" text-info">��ǰ����ȸ</h3>
        <h5 class="text-muted">��ǰ ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
        <div class="col-xs-8 col-md-4">${product.prodNo}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
        <div class="col-xs-8 col-md-4">${product.prodName}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
        <c:forEach var="fileName" items="${fileNameList}">
            <div class="col-xs-8 col-md-4">
                <img class="max-size" src="${pageContext.request.contextPath}/images/uploadFiles/${fileName}"/>
            </div>
        </c:forEach>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
        <div class="col-xs-8 col-md-4">${product.prodDetail}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>��������</strong></div>
        <div class="col-xs-8 col-md-4">${product.manuDate}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>����</strong></div>
        <div class="col-xs-8 col-md-4">${product.price}</div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
        <div class="col-xs-8 col-md-4">${product.regDate}</div>
    </div>

    <hr/>


    <div class="row">
    <c:if test="${menu}!=null">
        <c:if test="${menu}=='ok'">

            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary confirm">Ȯ��</button>
            </div>

        </c:if>
        <c:if test="${menu}!='ok'">
            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary buy">����</button>
            </div>
            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary back">����</button>
            </div>
        </c:if>
        </c:if>
        <c:if test="${menu}==null">
            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary confirm">Ȯ��</button>
            </div>
        </c:if>
    </div>


    <div class="row">
                <div class="col-sm-offset-8  col-sm-4 text-center ">
                    <button type="button" class="btn btn-primary buy">�����ϱ�</button>
                    <button type="button" class="btn btn-primary confirm">��ǰ�������..</button>
                    <button type="button" class="btn btn-primary back">����</button>
                </div>
    </div>

    <br/>
</div>


<%--<div class="col-sm-offset-4  col-sm-4 text-center">--%>
<%--    <button type="button" class="btn btn-primary add">��&nbsp;��</button>--%>
<%--    <button type="button" class="btn btn-primary cancel">��&nbsp;��</button>--%>
<%--    <button type="button" class="btn btn-primary back">�ڷΰ���</button>--%>
<%--</div>--%>
<script type="text/javascript">

    $(document).ready(function () {
        $("button.confirm").bind('click', function () {
            self.location = "/product/listProduct?menu=manage";
        });
        $("button.buy").bind('click', function () {
            self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
        })
        $("button.back").bind('click', function () {
            history.go(-1);
        })

        //���ΰ������� ���� X
        if('${user.role}'=='admin'){
            $("button.buy").prop('disabled', true);
        }

    });//end of ready
</script>
</body>

</html>