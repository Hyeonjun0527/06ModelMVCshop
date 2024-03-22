
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 상품 상세 조회-->
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-kr" %>

<%--
<%
Product productVO=(Product)request.getAttribute("productVO");
	session.setAttribute("purchaseProd", productVO);
	//System.out.println(request.getParameter("menu"));
%>
--%>

<html>
<head>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styling.css" type="text/css">
    <title>상품상세조회</title>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script>

		$(document).ready(function(){
			$("td.ct_btn01:contains('확인')").bind('click',function(){
				self.location = "/product/listProduct?menu=manage";
			});
            $("td.ct_btn01:contains('구매')").bind('click',function(){
                self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
            })
            $("td.ctbtn01:contains('이전')").bind('click',function(){
                history.go(-1);
            })

		});//end of ready

	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post" enctype="multipart/form-data">

    <table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
            <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="93%" class="ct_ttl01">상품상세조회</td>
                        <td width="20%" align="right">&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td width="12" height="37">
                <img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="105">${product.prodNo}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.prodName}</td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                상품이미지 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <c:forEach var="fileName" items="${fileNameList}">
                <td class="ct_write01">
                    <img class="max-size" src="${pageContext.request.contextPath}/images/uploadFiles/${fileName}"/>
                </td>
            </c:forEach>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.prodDetail}</td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">제조일자</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.manuDate}</td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">가격</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.price}</td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">등록일자</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.regDate}</td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
    </table>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
        <tr>
            <td width="53%"></td>
            <td align="right">

                <table border="0" cellspacing="0" cellpadding="0">
                    <c:if test="${menu}!=null">
                        <c:if test="${menu}=='ok'">
                            <tr>
                                <td width="17" height="23">
                                    <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                                </td>
                                <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
                                    확인
                                </td>
                                <td width="14" height="23">
                                    <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${menu}=='ok'">
                            <tr>
                                <td width="17" height="23">
                                    <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                                </td>
                                <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
                                    구매
                                </td>
                                <td width="14" height="23">
                                    <img src="/images/ct_btnbg03.gif" width="14" height="23">
                                </td>
                                <td width="30"></td>

                                <td width="17" height="23">
                                    <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                                </td>
                                <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
                                    이전
                                </td>
                                <td width="14" height="23">
                                    <img src="/images/ct_btnbg03.gif" width="14" height="23">
                                </td>
                            </tr>
                        </c:if>
                    </c:if>
                    <c:if test="${menu}!=null">
                    <tr>
                        <td width="17" height="23">
                            <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                        </td>
                        <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">


                            확인
                        </td>
                        <td width="14" height="23">
                            <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                        </td>
                    </tr>
                    </c:if>
                </table>

            </td>
        </tr>
    </table>
</form>

</body>
</html>