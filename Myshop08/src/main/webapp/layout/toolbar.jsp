<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">

<%--		navbar-brand�� ��ҵǵ� ���δ�.--%>
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>

<%--		navbar-toggle�� ��ҵɶ��� ���̰�, ������	�� ��۹�ư ������--%>
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
<%--		navbar-collapse�� ����ϴ� ��ҵ���. --%>
	<%--fadeInDown fadeInRight fadeInUp fadeInLeft ��Ʈ��Ʈ�� ��Ӵٿ�ȣ����� api ���۸�--%>
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInUp">
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  ȸ������ DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >ȸ������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">����������ȸ</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">ȸ��������ȸ</a></li>
	                         </c:if>
	                         
	                         <li class="divider"></li>
	                         <li><a href="#">etc...</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >��ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�� ǰ �� ��</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">�����̷���ȸ</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">�ֱ� �� ��ǰ</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">�� ����Ʈ</a></li>
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">�α׾ƿ�</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->


<script>
	const userId = "${user.userId}";
	console.log("userId"+userId);
</script>
<script src="${pageContext.request.contextPath}/javascript/layout/toolbar.js"></script>