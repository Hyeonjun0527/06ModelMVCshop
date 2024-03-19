<!-- 상품목록조회 -->
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 오브젝트스콥 REQUEST :: list,resultPage,search,   PARAM :: menu -- -->
<%-- ${param.menu}

${requestScope.list}
${requestScope.resultPage}
${requestScope.search} --%>
<html>
<head>
<title>찜 리스트</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link href="/css/listProduct.css" rel="stylesheet" type="text/css">

</head>

<body bgcolor="#ffffff" text="#000000">
<script>
	let type = '${search.searchType}';//없으면 정말 아무것도 없는 공백이 됨.''가 됨
	let searchBoundFirst = '${search.searchBoundFirst}';//'0'이 됨
	let searchBoundEnd = '${search.searchBoundEnd}';
	console.log('jsp에서 searchBoundFirst',searchBoundFirst);
	console.log('jsp에서 searchBoundEnd',searchBoundEnd);
	console.log('jsp에서 type', type);
	</script>
	
	<div style="width: 98%; margin-left: 10px;">
<%--이 폼태그를 전달하는 건 1,2,3,4클릭이나 검색할때만임. --%>
		<form id="detailForm" name="detailForm" action="/cookie/createLike?menu=${param.menu}"  method="post">

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
								찜 리스트
								</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>
<div class="container">
<%--
<input type="radio"  id="searchType1"  name="searchType"  onclick="javascript:fncGetListNorm('${resultPage.currentPage}');"/>
<label for="searchType1"  class="button">일반 검색</label>

<input type="radio"  id="searchType2"  name="searchType"  onclick="javascript:fncGetListPriceDesc('${resultPage.currentPage}');"/>
<label for="searchType2"  class="button">가격 높은순 검색</label>

<input type="radio"  id="searchType3"  name="searchType"  onclick="javascript:fncGetListPriceAsc('${resultPage.currentPage}');"/>
<label for="searchType3"  class="button">가격 낮은순 검색</label>

<input type="text"  id="searchBound1"  name="searchBoundFirst"/>
부터

<input type="text"  id="searchBound2"  name="searchBoundEnd" />
까지

<a id="searchBoundLink" href="javascript:fncGetList('${resultPage.currentPage}');">검색</a>
 --%>
</div>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${products.size()} 건수
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재상태</td>
					<td class="ct_line02"></td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${products}">
				
				
					<c:set var="i" value="${i+1 }"/>
					<tr class="ct_list_pop">
								<td align="center">		<button style="border: 0px; padding: 0px;">
		<div style="text-align: center;">
			<a href="/cookie/removeLike?count=one&prodNo=${product.prodNo}"
				style="display: inline-block; background-color: #4CAF50; color: white; padding: 7px 10px; text-align: center; text-decoration: none; font-size: 8px; border-radius: 5px; cursor: pointer;">
				삭제</a>
		</div>
	</button>${i}</td>
								<td></td>
								<c:if test="${!(product.proTranCode=='a')}">
									<td align="left">${product.prodName}</td>
								</c:if>
								<c:if test="${product.proTranCode=='a'}">
									<td align="left"><a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
								</c:if>
								<td></td>
								<td align="left">${product.price }</td>
								<!-- 가격 -->
								<td></td>
								<td align="left">${product.regDate}</td>
								<td></td>
								<c:if test="${product.proTranCode!=null}">

										<c:set var="resultA" value="${product.proTranCode.trim() == 'a' ? '판매중' : ''}"/>

										<c:set var="resultB" value="${product.proTranCode.trim() == 'b' ? '구매완료' : ''}"/>
										<c:set var="resultB2" value=""/>
										<c:if test="${param.menu == 'manage' || param.menu == 'ok'}">
										    <c:set var="resultB2" value="${product.proTranCode.trim() == 'b' ? '배송하기' : ''}"/>
										</c:if>
										<c:set var="resultC" value="${product.proTranCode.trim() == 'c' ? '배송중' : ''}"/>
										<c:set var="resultD" value="${product.proTranCode.trim() == 'd' ? '배송완료' : ''}"/>
										
								<td align="left">${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}<a href="/purchase/updateTranCode?prodNo=${product.prodNo}&navigationPage=listProduct&menu=manage">${resultB2}</a>${resultC}${resultD}</td>
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
		<div style="text-align: center;">
			<a href="/cookie/removeLike?count=all"
				style="display: inline-block; background-color: #4CAF50; color: white; padding: 7px 10px; text-align: center; text-decoration: none; font-size: 16px; border-radius: 5px; cursor: pointer;">전체
				삭제</a>
		</div>
	</button>
	<script type="text/javascript"  src="/javascript/variousSearch.js"></script>
	
</body>
</html>