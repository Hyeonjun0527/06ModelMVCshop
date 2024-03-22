<!-- ��ǰ�����ȸ -->
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>��ǰ �����ȸ</title>

    <link rel="stylesheet" href="/css/admin.css" type="text/css">
    <link href="/css/listProduct.css" rel="stylesheet" type="text/css">

</head>

<body bgcolor="#ffffff" text="#000000">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
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
<script type="text/javascript" src="/javascript/variousSearch.js"></script>

<div style="width: 98%; margin-left: 10px;">
    <%--�� ���±׸� �����ϴ� �� 1,2,3,4Ŭ���̳� �˻��Ҷ�����. --%>
    <form id="detailForm" name="detailForm">

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
                            <td width="17" height="23"><img
                                    src="/images/ct_btnbg01.gif" width="17" height="23"></td>
                            <td background="/images/ct_btnbg02.gif" class="ct_btn01"
                                style="padding-top: 3px;"><a
                                    href="javascript:fncGetList('1');">�˻�</a></td>
                            <%--���Ⱑ 1�� ������ �˻������� �������� 1�̱� �����̴�. --%>
                            <td width="14" height="23"><img
                                    src="/images/ct_btnbg03.gif" width="14" height="23"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="container">

            <input type="radio" id="searchType1" name="searchType" value="1" onclick="javascript:fncGetList('1');"/>
            <label for="searchType1" class="button">�Ϲ� �˻�</label>

            <input type="radio" id="searchType2" name="searchType" value="2" onclick="javascript:fncGetList('1');"/>
            <label for="searchType2" class="button">���� ������ �˻�</label>

            <input type="radio" id="searchType3" name="searchType" value="3" onclick="javascript:fncGetList('1');"/>
            <label for="searchType3" class="button">���� ������ �˻�</label>

            <input type="text" id="searchBoundFirst" name="searchBoundFirst" value='${search.searchBoundFirst}'/>
            ����

            <input type="text" id="searchBoundEnd" name="searchBoundEnd" value='${search.searchBoundEnd}'/>
            ����

            <a id="searchBound" href="javascript:fncGetList('${resultPage.currentPage}');">�˻�</a>

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
                    <td align="left"><a
                            href="/product/getProduct?prodNo=${product.prodNo}&menu=${menu}">${product.prodName}</a>
                    </td>
                    </c:if>
                    <td></td>
                    <td align="left">${product.price }</td>
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

                    <td align="left">${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}<a
                            href="/purchase/updateTranCode?prodNo=${product.prodNo}&navigationPage=listProduct&menu=manage">${resultB2}</a>${resultC}${resultD}
                    </td>
                    </c:if>
                    <td></td>
                    <td>
                        <a href="/product/setLikeProduct?prodNo=${product.prodNo}&menu=${menu}&currentPage=${resultPage.currentPage}">���ϱ�</a>
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

                    <jsp:include page="../common/pageNavigator.jsp"/>

                </td>

            </tr>
        </table>
        <!--  ������ Navigator �� -->
    </form>

</div>





</body>
</html>