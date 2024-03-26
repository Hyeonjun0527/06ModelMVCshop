<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">

    <!-- ���� : http://getbootstrap.com/css/   ���� -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

    <!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= ȸ���������� Event  ó�� =============
        $(function() {
            //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.confirm" ).on("click" , function() {
                self.location = "/user/updateUser?userId=${user.userId}"
            });
        });

    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/layout/toolbar.jsp" />
<!-- ToolBar End /////////////////////////////////////-->

<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">

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



    <c:if test="${menu}!=null">
        <div class="row">
        <c:if test="${menu}=='ok'">

                <div class="col-sm-offset-4  col-sm-4 text-center ">
                    <button type="button" class="btn btn-primary confirm">Ȯ��</button>
                </div>

        </c:if>
        <c:if test="${menu}=='ok'">
            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary buy">����</button>
            </div>
            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary back">����</button>
            </div>
        </c:if>

            <c:if test="${menu}!=null">
                <div class="col-sm-offset-4  col-sm-4 text-center ">
                    <button type="button" class="btn btn-primary confirm">Ȯ��</button>
                </div>
            </c:if>
        </div>
    </c:if>
    <br/>
</div>
<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>