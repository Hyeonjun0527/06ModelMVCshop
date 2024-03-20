<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<html>
<head>
<title>�Ǹ�/���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/purchase/listPurchase?menu=${param.menu}"
			method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>${param.menu=='manage' ? '�Ǹ� �����ȸ' :'���� �����ȸ'}
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">��ü ${totalCount} �Ǽ�, ����
						${requestScope.resultPage.currentPage} ������
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">ȸ��ID</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">ȸ����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��ȭ��ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����Ȳ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��������</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${requestScope.list}">
					<c:set var="i" value="${i+1 }" />
					<tr class="ct_list_pop">
						<td align="center">
						<c:if test="${purchase.tranNo!=0 }">
						<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}&menu=${param.menu}">${purchase.tranNo}</a>
						</c:if>
						</td>
						<td></td>
						<td align="left">
						<a href="/user/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a>
						</td>
						<td></td>
						<td align="left">${purchase.receiverName}</td>
						<td></td>
						<td align="left">${purchase.receiverPhone}</td>
						<td></td>
						<c:if test="${purchase.tranCode!=null}">

							<c:set var="resultA"
								value="${purchase.tranCode.trim() == 'a' ? '�Ǹ���' : ''}" />
							<c:set var="resultB"
								value="${purchase.tranCode.trim() == 'b' ? '���ſϷ�' : ''}" />

							<c:if test="${param.menu == 'manage' || param.menu == 'ok'}">
								<c:set var="resultB2"
									value="${purchase.tranCode.trim() == 'b' ? '����ϱ�' : ''}" />
							</c:if>
							<c:set var="resultC"
								value="${purchase.tranCode.trim() == 'c' ? '�����' : ''}" />
							<c:set var="resultD"
								value="${purchase.tranCode.trim() == 'd' ? '��ۿϷ�' : ''}" />

<%--���� ${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''} --%>
							<td align="left">���� ${resultA}${resultB}<a
								href="/purchase/updateTranCode?prodNo=${purchase.purchaseProd.prodNo}">${resultB2}</a>${resultC}${resultD}
								�����Դϴ�.
							</td>
						</c:if>
						<td></td>
						<td align="left"><c:if test="${! empty purchase.tranCode}">
								<c:if test="${purchase.tranCode.trim() == 'c'}">
									<a href="/purchase/updateTranCode?prodNo=${purchase.purchaseProd.prodNo}&navigationPage=listPurchase&menu=search">���ǵ���</a>
									
								</c:if>
							</c:if></td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> <jsp:include
							page="../common/pageNavigator.jsp" /></td>

				</tr>
			</table>
			<!--  ������ Navigator �� -->
		</form>

	</div>

</body>
</html>