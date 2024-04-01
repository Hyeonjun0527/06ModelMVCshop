<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>

<html>
<head>
    <title>�Ǹ�/���� �����ȸ</title>
    <%--��������--%>
    <script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

    <%--��Ʈ��Ʈ��--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%-- ��Ʈ��Ʈ�� Dropdown Hover CSS JS--%>
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
    <script
            src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"
            integrity="sha256-6XMVI0zB8cRzfZjqKcD01PBsAy3FlDASrlC8SxCpInY="
            crossorigin="anonymous"></script>
    <%--�����--%>
    <link rel="stylesheet" href="/css/font.css" type="text/css">
    <%--	<link rel="stylesheet" href="/css/listPurchase.css" type="text/css">--%>

</head>
<body class="default-font">
<form class="form-inline" name="detailForm">
    <jsp:include page="/layout/toolbar.jsp"/>
    <div class="container">
        <div class="page-header text-info">
            <h3>${param.menu=='manage' ? '�Ǹ� �����ȸ' :'���� �����ȸ'}</h3>
        </div>

        <div class="row">
            <%--�� ���±׸� �����ϴ� �� 1,2,3,4Ŭ���̳� �˻��Ҷ�����. --%>
            <div class="col-md-6 text-left">
                <p class="text-primary">
                    ��ü ${totalCount} �Ǽ�, ���� ${requestScope.resultPage.currentPage} ������
                </p>
            </div>

            <table class="table table-hover table-striped size-set">
                <thead>
                <tr>
                    <td>No</td>
                    <td>ȸ��ID</td>
                    <td>ȸ����</td>
                    <td>��ȭ��ȣ</td>
                    <td>�����Ȳ</td>
                    <td>��������</td>
                </tr>
                </thead>


                <tbody>
                <c:set var="i" value="0"/>
                <c:forEach var="purchase" items="${list}">
                    <c:set var="i" value="${i+1 }"/>
                <tr>
                    <td align="center">${i}</td>
                    <td>
                        <c:if test="${purchase.purchaseProd.prodNo!=0 }">
                            <button class="btn btn-primary click-event" type="button" data-getPurchase
                                    data-prodNo="${purchase.purchaseProd.prodNo}">${purchase.purchaseProd.prodNo}</button>
                        </c:if>
                    </td>
                    <td align="left">
                        <button class="btn btn-primary click-event" type="button" data-getUser
                                data-userId="${purchase.buyer.userId}">${purchase.buyer.userId}</button>
                    </td>
                    <td align="left">${purchase.receiverName}</td>
                    <td align="left">${purchase.receiverPhone}</td>


                    <c:if test="${purchase.tranCode!=null}">

                        <c:set var="resultA" value="${purchase.tranCode.trim() == 'a' ? '�̱���' : ''}"/>

                        <c:if test="${menu == 'manage' || menu == 'ok'}">
                            <c:set var="resultB" value="${purchase.tranCode.trim() == 'b' ? '�ǸſϷ�' : ''}"/>
                            <c:set var="resultB2" value="${purchase.tranCode.trim() == 'b' ? '����ϱ�' : ''}"/>
                        </c:if>

                        <c:if test="${menu != 'manage' && menu != 'ok'}">
                            <c:set var="resultB" value="${purchase.tranCode.trim() == 'b' ? '���ſϷ�' : ''}"/>
                        </c:if>

                        <c:set var="resultC" value="${purchase.tranCode.trim() == 'c' ? '�����' : ''}"/>
                        <c:set var="resultD" value="${purchase.tranCode.trim() == 'd' ? '��ۿϷ�' : ''}"/>

                        <td align="left">
                                ${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}

                            <c:if test="${menu == 'manage' || menu == 'ok'}">
								<span class="click-event clickableSpan" data-update
                                      data-prodNo="${purchase.purchaseProd.prodNo}">${resultB2}</span>
                            </c:if>

                                ${resultC}${resultD}
                        </td>
                    </c:if>


                    <td align="left">

                        <c:if test="${menu != 'manage' && menu != 'ok'}">
                            <c:if test="${! empty purchase.tranCode}">
                                <c:if test="${purchase.tranCode.trim() == 'c'}">
										<span class="click-event clickableSpan" data-update
                                              data-prodNo="${purchase.purchaseProd.prodNo}">
											���ǵ���
										</span>
                                </c:if>
                            </c:if>
                        </c:if>
                    </td>
                </tr>
                </c:forEach>
            </table>

            <table width="100%" border="0" cellspacing="0" cellpadding="0"
                   style="margin-top: 10px;">
                <tr>
                    <td align="center"><input type="hidden" id="currentPage"
                                              name="currentPage" value="1"/>
                        <jsp:include
                                page="../common/pageNavigator.jsp"/>
                    </td>

                </tr>
            </table>
            <!--  ������ Navigator �� -->

        </div>
	</div>
</form>

<script type="text/javascript">
    function fncGetList(currentPage) {
        if (currentPage === undefined) {
            currentPage = 1;
        }
        $("#currentPage").val(currentPage);
        $("form[name='detailForm']")
            .attr("method", "post")
            .attr("action", "/purchase/listPurchase?menu=${param.menu}")
            .submit();
    }//end of fncGetList

    $(document).ready(function () {
        $("span.click-event").click(function () {
            console.log("Ŭ���߾��");
            //Ŭ���̺�Ʈ 1
            if (typeof $(this).data("getpurchase") !== "undefined") {
                console.log("getPurchase");
                let prodNo = $(this).data("prodno");
                $("form[name='detailForm']")
                    .attr("method", "post")
                    .attr("action", "/product/getProduct?prodNo=" + prodNo + "&menu=${param.menu}")
                    .submit();

                //Ŭ���̺�Ʈ2
            } else if (typeof $(this).data("getuser") !== "undefined") {
                console.log("getUser");
                let userId = $(this).data("userid");
                console.log(userId);
                window.location.href = "/user/getUser" + "?userId=" + userId;
                //Ŭ���̺�Ʈ3
            } else if (typeof $(this).data("update") !== "undefined") {
                console.log("update");
                let prodNo = $(this).data("prodno");
                $("form[name='detailForm']")
                    .attr("method", "post")
                    .attr("action", "/purchase/updatePurchase?prodNo=" + prodNo + "&menu=${param.menu}" + "&navigationPage=listPurchase")
                    .submit();
            }
        });
    })//end of ready

</script>
</body>
</html>