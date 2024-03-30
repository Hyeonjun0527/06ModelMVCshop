<!-- ��ǰ�����ȸ -->
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>��ǰ �����ȸ</title>
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
    <style>
        body {
            padding-top: 50px;
        }

        .max-size {
            max-width: 100px !important;
            max-height: 100px !important;
        }
    </style>
    <link href="/css/listProduct.css" rel="stylesheet" type="text/css">

</head>
<body class="default-font">

<jsp:include page="/layout/toolbar.jsp" />
<script>

    let type = '${search.searchType}';//������ ���� �ƹ��͵� ���� ������ ��.''�� ��
    let searchBoundFirst = '${search.searchBoundFirst}';//'0'�� ��
    let searchBoundEnd = '${search.searchBoundEnd}';

    let menu = '${menu}';
    console.log(menu);
    console.log('jsp���� searchBoundFirst', searchBoundFirst);
    console.log('jsp���� searchBoundEnd', searchBoundEnd);
    console.log('jsp���� type', type);

</script>
<div class="container">
    <div class="page-header text-info">
        <h3>${menu=='manage' ? '��ǰ����' :'��ǰ�����ȸ'}</h3>
    </div>

    <div class="row">
        <%--�� ���±׸� �����ϴ� �� 1,2,3,4Ŭ���̳� �˻��Ҷ�����. --%>
        <div class="col-md-6 text-left">
            <p class="text-primary">
                ��ü ${totalCount} �Ǽ�, ���� ${requestScope.resultPage.currentPage} ������
            </p>
        </div>
        <form class="form-inline" name="detailForm">

            <div class="col-md-6 text-right">
                <div class="form-group">
                    <select name="searchCondition"
                            class="form-control">
                        <c:choose>
                            <c:when test="${requestScope.search.searchCondition=='0'}">
                                <option value="0" selected>��ǰ��ȣ</option>
                                <option value="1">��ǰ��</option>
                                <option value="2">��ǰ����</option>
                            </c:when>
                            <c:when test="${requestScope.search.searchCondition=='1'}">
                                <option value="0">��ǰ��ȣ</option>
                                <option value="1" selected>��ǰ��</option>
                                <option value="2">��ǰ����</option>
                            </c:when>
                            <c:when test="${requestScope.search.searchCondition=='2'}">
                                <option value="0">��ǰ��ȣ</option>
                                <option value="1">��ǰ��</option>
                                <option value="2" selected>��ǰ����</option>
                            </c:when>
                            <c:otherwise>
                                <option value="0">��ǰ��ȣ</option>
                                <option value="1">��ǰ��</option>
                                <option value="2">��ǰ����</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="searchKeyword">�˻���</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
                           placeholder="�˻���"
                           value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                </div>

                <button type="button" class="btn btn-default" data-search>�˻�</button>
                <input type="hidden" id="currentPage" name="currentPage" value=""/>

            </div>

            <div class="col-md-12 text-right">
                <div class="form-group">

                    <input type="radio" id="searchType1" name="searchType" value="1"/>
                    <label for="searchType1" class="button">�Ϲ� �˻�</label>

                    <input type="radio" id="searchType2" name="searchType" value="2"/>
                    <label for="searchType2" class="button">���� ������ �˻�</label>

                    <input type="radio" id="searchType3" name="searchType" value="3"/>
                    <label for="searchType3" class="button">���� ������ �˻�</label>

                    <input type="text" id="searchBoundFirst" name="searchBoundFirst"
                           value='${search.searchBoundFirst}'/>
                    ����

                    <input type="text" id="searchBoundEnd" name="searchBoundEnd" value='${search.searchBoundEnd}'/>
                    ����

                    <button type="button" data-searchBound>�˻�</button>

                </div>
            </div>
        </form>

        <table class="table table-hover table-striped">
            <thead>
            <tr>
                <td>No</td>
                <td>��ǰ��</td>
                <td>����</td>
                <td>�����</td>
                <td>�������</td>
                <td>���ϱ�</td>
            </tr>
            </thead>

            <tbody>
            <c:set var="i" value="0"/>
            <c:forEach var="product" items="${list}">
                <c:set var="i" value="${i+1 }"/>
                <tr>
                    <td align="center">${i}</td>
                    <c:if test="${!(product.proTranCode=='a')}">
                    <td align="left">${product.prodName}</td>
                    </c:if>
                    <c:if test="${product.proTranCode=='a'}">
                    <td align="left">
                        <button type="button" data-getProduct data-prodNo="${product.prodNo}">
                                ${product.prodName}
                        </button>
                    </td>
                    </c:if>
                    <td align="left">${product.price}</td>
                    <!-- ���� -->
                    <td align="left">${product.regDate}</td>
                    <c:if test="${product.proTranCode!=null}">

                        <c:set var="resultA" value="${product.proTranCode.trim() == 'a' ? '�Ǹ���' : ''}"/>

                    <c:if test="${menu == 'manage' || menu == 'ok'}">
                        <c:set var="resultB" value="${product.proTranCode.trim() == 'b' ? '�ǸſϷ�' : ''}"/>
                        <c:set var="resultB2" value="${product.proTranCode.trim() == 'b' ? '����ϱ�' : ''}"/>
                        <c:set var="resultC" value="${product.proTranCode.trim() == 'c' ? '�����' : ''}"/>
                        <c:set var="resultD" value="${product.proTranCode.trim() == 'd' ? '��ۿϷ�' : ''}"/>
                    </c:if>
                    <td align="left">
                            ${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}
                    <c:if test="${!(menu == 'manage' || menu == 'ok')}">
                        <c:if test="${!(menu == 'manage' || menu == 'ok')&&product.proTranCode.trim()!='a'}">
                            �ǸſϷ�
                        </c:if>
                    </c:if>
                        <span class="clickableSpan" data-update
                              data-prodNo="${product.prodNo}">${resultB2}</span>${resultC}${resultD}
                    </td>
                    </c:if>
                    <td>
                        <button type="button" data-setLike data-prodNo="${product.prodNo}">
                            ���ϱ�
                        </button>
                    </td>
                <tr/>
            </c:forEach>
            </tbody>
        </table>

        <jsp:include page="${pageContext.request.contextPath}/common/pageNavigator_new.jsp"/>

            <div class="col-md-10"></div>
            <div class="col-md-2 "><button type="button" class="btn btn-primary" data-toImage>�̹����� ����<span aria-hidden="true"> &nbsp&rarr;</span></button></div>


        <!--  ������ Navigator �� -->


    </div>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/variousSearch.js"></script>
<script>
    $(document).ready(function () {
        $('button.btn[data-search]:contains("�˻�")').click(function () {
            console.log('����̳�����.')
            fncGetList('1');
        });
        $('button[data-searchBound]:contains("�˻�")').click(function () {
            fncGetList('${resultPage.currentPage}');
        });
        $('button[data-getProduct]').click(function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/getProduct?prodNo=" + prodNo + "&menu=${menu}";
        });
        $('span.clickableSpan').click(function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/purchase/updateTranCode?prodNo=" + prodNo + "&navigationPage=listProduct&menu=manage";
        })
        $('button[data-setLike]').click(function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/setLikeProduct?prodNo=" + prodNo + "&menu=${menu}&currentPage=${resultPage.currentPage}";
        })
        $('input[name=searchType]').click(function () {
            fncGetList('1');
        })
        $('button[data-toImage]').click(function () {
            window.location.href = "/product/listProduct?menu=${menu}&image=ok";
        })

        $('input[name="searchKeyword"]').autocomplete({
            source: function (request, response) {

                function createLabelValueMapper(Prop) {
                    return function (object) {
                        return {
                            label: object[Prop],
                            value: object[Prop]
                        }
                    }
                };
                let searchCondition = $('select[name=searchCondition]').val()

                console.log("�ҽ��� ȣ��˴ϴ�.");
                console.log("�� ������ : request.term : " + request.term);

                console.log("�� ������ : Condition : " + searchCondition);
                console.log(JSON.stringify({
                    searchKeyword: request.term,
                    searchCondition: searchCondition
                }));
                $.ajax({
                    url: '/product/json/autoComplete',
                    type: 'post',
                    dataType: 'json',
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    data: JSON.stringify({
                        searchKeyword: request.term,
                        searchCondition: searchCondition
                    }),
                }).done(function (rawData, textStatus, jqXHR) {
                    console.log('���� ������ : ' + rawData);
                    if (rawData.length !== 0) {
                        // �����κ��� ���� ������ (Product ��ü�� ����Ʈ)�� ó��
                        console.log('�����Ͱ� ���� data : ' + rawData);
                        //��ȣ, ��, ���� $.map�� ��ҿ� function �� �����Ű�� �迭 ��ȯ
                        //�� function�� ����� function�� ����� �� ���ϰڴ�. �װ� mapper����

                        switch (searchCondition) {
                            case '0':
                                mapper = createLabelValueMapper("prodNo");
                                break;
                            case "1":
                                mapper = createLabelValueMapper("prodName");
                                break;
                            case "2":
                                mapper = createLabelValueMapper("price");
                                break;
                        }

                        let data = $.map(rawData, mapper);
                        console.log('data : ' + data);
                        //������ �� �׸񸶴� �ݹ��Լ� ȣ���Ѵ�.
                        $.each(data, function (index, obj) {
                            console.log(obj);
                        })
                        console.log("data[0] : " + JSON.stringify(data[0]));
                        //RegExp ����ǥ����. ^�� ������ �ǹ�. i�� ��ҹ��� ���о��� escapeRegex�� Ư�����ڸ� �̽�������
                        //.test�� ����ǥ���Ŀ� �´��� Ȯ���ϰ� true��ȯ, $.grep�� true�� ��Ƽ� �� �迭
                        let matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(request.term), "i");
                        console.log($.grep(data, function (item) {
                            return matcher.test(item.label);
                        }));
                        response($.grep(data, function (item) {
                            return matcher.test(item.label);
                        }).slice(0, 5));
                        //.slice(0,7)
                        //response(data); // ó���� �����͸� �ڵ��ϼ� ������� ǥ��
                    } else {
                        // �����κ��� ���� �����Ͱ� ���� ���� �� �迭�� �����Ͽ� �ڵ��ϼ��� �������� ����
                        response([]);
                    }

                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log('����');
                    console.log(jqXHR);
                    console.log(textStatus);
                    console.log(errorThrown);
                });
            },//end of source
            select: function (event, ui) {
                // �ɼ��� �������� ��, ���ϴ� ������ ������ �� ����
                // ���� ���, ���õ� Product�� id�� ��򰡿� �����ϰų� �ٸ� �۾��� ����
                console.log("Selected: " + ui.item.label + ", id: " + ui.item.value);
                let $element = $('input[name="searchKeyword"]');

                $element.addClass('flash-effect');
                $element.one('animationed', function () {
                    $element.removeClass('flash-effect');
                });
            },//end of select event
            classes: {
                "ui-autocomplete": "custom-ui-autocomplete",
            },

            autoFocus: true,//end of autoFocus

        });//end of autocomplete

        // $.ui.autocomplete.prototype._close = function(event) {
        //     // ���� ������ �����ϰų� ���ǿ� ���� ó��
        // };
    });//end of ready
</script>

</body>
</html>