<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!-- ��û������ <= ����������� ������ ��. ����  3  <= 5 �̸� ���̻� ���� �������� ��!-->
	<c:if test="${resultPage.currentPage <= resultPage.pageUnit	}">
			�� ����
	</c:if>
	<!-- ��û������ <= ����������� ������ ��. ����  6 > 5 �̸� ���� �� �ְ� ��!-->
	<c:if test="${resultPage.currentPage > resultPage.pageUnit }">
	<!--   [[[6-5 = 1]]]    [[[11-5 = 6]]]  !-->
			<a href="javascript:fncGetList('${resultPage.beginUnitPage-resultPage.pageUnit}')">�� ����</a>
	</c:if>
	<!--   6���� 11    !-->
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
		<a href="javascript:fncGetList('${ i }')">${ i }</a>
	</c:forEach>
	
	<!--  11 >= 8 �������� 11���� ���Դµ� 8�� �ִ������������ �ȳ��;��� -->
	<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
			���� ��
	</c:if>
	<!-- ���� �ݴ��� ������ �ؾ��� -->
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
			<a href="javascript:fncGetList('${resultPage.endUnitPage+1}')">���� ��</a>
	</c:if>