
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
<title>�� ����Ʈ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link href="/css/listProduct.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>

<body bgcolor="#ffffff" text="#000000">
<script>


	let type = '${search.searchType}';//������ ���� �ƹ��͵� ���� ������ ��.''�� ��
	let searchBoundFirst = '${search.searchBoundFirst}';//'0'�� ��
	let searchBoundEnd = '${search.searchBoundEnd}';
	console.log('jsp���� type', type);
	console.log('jsp���� searchBoundFirst',searchBoundFirst);
	console.log('jsp���� searchBoundEnd',searchBoundEnd);

	$(document).ready(function(){

		const td = $("td[data-getProduct]")
		console.log("td :: " + td);
		const prodNo = td.data("getproduct")
		console.log("prodNO :: "+prodNo);
		console.log("menu :: " + "${param.menu}");

		$("div.delete_one:contains('����')").click(function(){
			console.log("1�̴� �̾�");
			self.location = "/cookie/removeLike?count=one&prodNo="+prodNo;
		});
		$("div.delete_all:contains('����')").click(function(){
			console.log("2�̴� �̾�");
			window.location.href = "/cookie/removeLike?count=all&prodNo="+prodNo;
		});
		td.click(function(){
			console.log("3�̴� �̾�");
			window.location.href = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
		});

		$("span.update").click(function(){
			console.log("4�̴� �̾�");
			window.location.href = "/purchase/updateTranCode?prodNo="+prodNo+"&navigationPage=listProduct&menu=manage";
		});

	});

	</script>
	<div style="width: 98%; margin-left: 10px;">
<%--�� ���±׸� �����ϴ� �� 1,2,3,4Ŭ���̳� �˻��Ҷ�����. --%>
		<form name="detailForm">
			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">
								�� ����Ʈ
								</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>
<div class="container">
</div>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">��ü ${products.size()} �Ǽ�
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
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${products}">
				
					<c:set var="i" value="${i+1 }"/>
					<tr class="ct_list_pop">
								<td align="center">		<%--<button style="border: 0px; padding: 0px;">--%>
		<div style="text-align: center;" class="delete_one">
				����
		</div>
	${i}</td>
								<td></td>
								<c:if test="${!(product.proTranCode=='a')}">
									<td align="left" data-getProduct="${product.prodNo}">${product.prodName}</td>
								</c:if>
								<c:if test="${product.proTranCode=='a'}">
									<td align="left">${product.prodName}</td>
								</c:if>
								<td></td>
								<td align="left">${product.price }</td>
								<!-- ���� -->
								<td></td>
								<td align="left">${product.regDate}</td>
								<td></td>
								<c:if test="${product.proTranCode!=null}">

										<c:set var="resultA" value="${product.proTranCode.trim() == 'a' ? '�Ǹ���' : ''}"/>

										<c:set var="resultB" value="${product.proTranCode.trim() == 'b' ? '���ſϷ�' : ''}"/>
										<c:set var="resultB2" value=""/>
							<%--
										<c:if test="${param.menu == 'manage' || param.menu == 'ok'}">

										    <c:set var="resultB2" value="${product.proTranCode.trim() == 'b' ? '����ϱ�' : ''}"/>
										</c:if>
						--%>
										<c:set var="resultC" value="${product.proTranCode.trim() == 'c' ? '�����' : ''}"/>
										<c:set var="resultD" value="${product.proTranCode.trim() == 'd' ? '��ۿϷ�' : ''}"/>
										
								<td align="left">${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}
									<%--<span class="update">${resultB2}</span>--%>
										${resultC}${resultD}</td>
								</c:if>
						<tr/>
						<tr>
								<td colspan="11" bgcolor="D6D7D6" height="1"></td>
						</tr>
						
				</c:forEach>
				
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
			</table>


		</form>

	</div>
		<button style="border: 0px; padding: 0px;">
		<div style="text-align: center;" class="delete_all">
			����
		</div>
	</button>
	<script type="text/javascript"  src="/javascript/variousSearch.js"></script>
<a href="/main.jsp">�������� �̵��ϱ�</a>
</body>
</html>