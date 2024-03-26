<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
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

        //============= 회원정보수정 Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">상품상세조회</h3>
        <h5 class="text-muted">상품 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
        <div class="col-xs-8 col-md-4">${product.prodNo}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
        <div class="col-xs-8 col-md-4">${product.prodName}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
        <c:forEach var="fileName" items="${fileNameList}">
        <div class="col-xs-8 col-md-4">
            <img class="max-size" src="${pageContext.request.contextPath}/images/uploadFiles/${fileName}"/>
        </div>
        </c:forEach>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
        <div class="col-xs-8 col-md-4">${product.prodDetail}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
        <div class="col-xs-8 col-md-4">${product.manuDate}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
        <div class="col-xs-8 col-md-4">${product.price}</div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
        <div class="col-xs-8 col-md-4">${product.regDate}</div>
    </div>

    <hr/>



    <c:if test="${menu}!=null">
        <div class="row">
        <c:if test="${menu}=='ok'">

                <div class="col-sm-offset-4  col-sm-4 text-center ">
                    <button type="button" class="btn btn-primary confirm">확인</button>
                </div>

        </c:if>
        <c:if test="${menu}=='ok'">
            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary buy">구매</button>
            </div>
            <div class="col-sm-offset-4  col-sm-4 text-center ">
                <button type="button" class="btn btn-primary back">이전</button>
            </div>
        </c:if>

            <c:if test="${menu}!=null">
                <div class="col-sm-offset-4  col-sm-4 text-center ">
                    <button type="button" class="btn btn-primary confirm">확인</button>
                </div>
            </c:if>
        </div>
    </c:if>
    <br/>
</div>
<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>