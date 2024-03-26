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
    <%--�����--%>
    <script
            src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"
            integrity="sha256-6XMVI0zB8cRzfZjqKcD01PBsAy3FlDASrlC8SxCpInY="
            crossorigin="anonymous"></script>
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

<div style="width: 98%; margin-left: 10px;">
    <%--�� ���±׸� �����ϴ� �� 1,2,3,4Ŭ���̳� �˻��Ҷ�����. --%>
    <form name="detailForm">

        <table width="100%" height="37" border="0" cellpadding="0"
               cellspacing="0">
            <tr>
                <td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
                                                width="15" height="37"/></td>
                <td background="/images/ct_ttl_img02.gif" width="100%"
                    style="padding-left: 10px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="93%" class="ct_ttl01">
                                ${menu=='manage' ? '��ǰ����' :'��ǰ�����ȸ'}
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
                                                width="12" height="37"/></td>
            </tr>
        </table>


        <table width="100%" border="0" cellspacing="0" cellpadding="0"
               style="margin-top: 10px;">
            <tr>
                <!-- searchCondition�� value 0 1 2 -->
                <td align="right"><select name="searchCondition"
                                          class="ct_input_g" style="width: 80px">

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

                </select> <input type="text" name="searchKeyword" value="${search.searchKeyword}" class="ct_input_g"
                                 style="width: 200px; height: 19px"/></td>

                <td align="right" width="70">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="ct_btn01" data-search
                                style="padding-top: 1px;"><button class="button keyword" type="button">�˻�</button></td>
                            <%--���Ⱑ 1�� ������ �˻������� �������� 1�̱� �����̴�. --%>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="container">

            <input type="radio" id="searchType1" name="searchType" value="1"/>
            <label for="searchType1" class="button">�Ϲ� �˻�</label>

            <input type="radio" id="searchType2" name="searchType" value="2"/>
            <label for="searchType2" class="button">���� ������ �˻�</label>

            <input type="radio" id="searchType3" name="searchType" value="3"/>
            <label for="searchType3" class="button">���� ������ �˻�</label>

            <input type="text" id="searchBoundFirst" name="searchBoundFirst" value='${search.searchBoundFirst}'/>
            ����

            <input type="text" id="searchBoundEnd" name="searchBoundEnd" value='${search.searchBoundEnd}'/>
            ����

            <button type="button" data-searchBound>�˻�</button>

        </div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"
               style="margin-top: 10px;">
            <tr>
                <td colspan="11">��ü ${totalCount} �Ǽ�, ���� ${requestScope.resultPage.currentPage} ������
                </td>
            </tr>
            <tr>
                <td class="ct_list_b" width="100">No</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">��ǰ��</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">����</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b">�����</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b">�������</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">���ϱ�</td>
            </tr>
            <tr>
                <td colspan="11" bgcolor="808285" height="1"></td>
            </tr>

            <c:set var="i" value="0"/>
            <c:forEach var="product" items="${list}">
                <c:set var="i" value="${i+1 }"/>
                <tr class="ct_list_pop">
                    <td align="center">${i}</td>
                    <td></td>
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
                    <td></td>
                    <td align="left">${product.price}</td>
                    <!-- ���� -->
                    <td></td>
                    <td align="left">${product.regDate}</td>
                    <td></td>
                    <c:if test="${product.proTranCode!=null}">

                        <c:set var="resultA" value="${product.proTranCode.trim() == 'a' ? '�Ǹ���' : ''}"/>

                        <c:set var="resultB" value="${product.proTranCode.trim() == 'b' ? '�ǸſϷ�' : ''}"/>
                        <c:set var="resultB2" value=""/>
                    <c:if test="${menu == 'manage' || menu == 'ok'}">
                        <c:set var="resultB2" value="${product.proTranCode.trim() == 'b' ? '����ϱ�' : ''}"/>
                    </c:if>
                        <c:set var="resultC" value="${product.proTranCode.trim() == 'c' ? '�����' : ''}"/>
                        <c:set var="resultD" value="${product.proTranCode.trim() == 'd' ? '��ۿϷ�' : ''}"/>

                    <td align="left">${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}
                        <span class="clickableSpan" data-update
                      data-prodNo="${product.prodNo}">${resultB2}</span>${resultC}${resultD}
                    </td>
                    </c:if>
                    <td></td>
                    <td>
                        <button type="button" data-setLike data-prodNo="${product.prodNo}">
                        ���ϱ�
                        </button>
                    </td>
                <tr/>
                <tr>
                    <td colspan="11" bgcolor="D6D7D6" height="1"></td>
                </tr>
            </c:forEach>

        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"
               style="margin-top: 10px;">
            <tr>
                <td align="center">

                    <input type="hidden" id="currentPage" name="currentPage" value=""/>

                    <jsp:include page="${pageContext.request.contextPath}/common/pageNavigator.jsp"/>

                </td>

            </tr>
        </table>
        <!--  ������ Navigator �� -->
    </form>

</div>



<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/variousSearch.js"></script>
<script>
    $(document).ready(function () {
        $('td.ct_btn01[data-search] button:contains("�˻�")').click(function () {
            fncGetList('1');
        });
        $('button[data-searchBound]:contains("�˻�")').click(function () {
            fncGetList('${resultPage.currentPage}');
        });
        $('button[data-getProduct]').click(function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/getProduct?prodNo=" + prodNo + "&menu=${menu}";
        });
        $('button[data-update]').click(function () {
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

        $('input[name="searchKeyword"]').autocomplete({
            source: function (request, response) {

                function createLabelValueMapper(Prop){
                    return function(object){
                        return {
                            label:object[Prop],
                            value:object[Prop]
                        }
                    }
                };
                let searchCondition = $('select[name=searchCondition]').val()

                console.log("�ҽ��� ȣ��˴ϴ�.");
                console.log("�� ������ : request.term : " + request.term);

                console.log("�� ������ : Condition : " + searchCondition);
                console.log(JSON.stringify({
                    searchKeyword : request.term,
                    searchCondition : searchCondition
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
                        searchKeyword : request.term,
                        searchCondition : searchCondition
                    }),
                }).done(function (rawData, textStatus, jqXHR) {
                    console.log('���� ������ : '  + rawData );
                    if (rawData.length !== 0) {
                        // �����κ��� ���� ������ (Product ��ü�� ����Ʈ)�� ó��
                        console.log('�����Ͱ� ���� data : ' + rawData);
                        //��ȣ, ��, ���� $.map�� ��ҿ� function �� �����Ű�� �迭 ��ȯ
                        //�� function�� ����� function�� ����� �� ���ϰڴ�. �װ� mapper����

                        switch(searchCondition) {
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
                        $.each(data,function(index,obj){
                            console.log(obj);
                        })
                        console.log("data[0] : " + JSON.stringify(data[0]));
                        let matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex(request.term), "i" );
                        console.log($.grep( data, function(item){
                            return matcher.test(item.label);
                        }) );
                        response( $.grep( data, function(item){
                            return matcher.test(item.label);
                        }).slice(0,5));
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
            select: function(event, ui) {
                // �ɼ��� �������� ��, ���ϴ� ������ ������ �� ����
                // ���� ���, ���õ� Product�� id�� ��򰡿� �����ϰų� �ٸ� �۾��� ����
                console.log("Selected: " + ui.item.label + ", id: " + ui.item.value);
                let $element = $('input[name="searchKeyword"]');

                $element.addClass('flash-effect');
                $element.one('animationed',function(){
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