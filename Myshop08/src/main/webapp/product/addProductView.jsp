
<!-- ��ǰ ��� ��ǰ ���� ���� ����-->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
		 pageEncoding="EUC-KR" %>


<html>
<head>
	<title>��ǰ���</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/css/font.css" type="text/css">
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<script type="text/javascript" src="../javascript/calendar.js">
	</script>

	<script type="text/javascript">

		function fncAddProduct() {
			//Form ��ȿ�� ����
			// var name = document.detailForm.prodName.value;
			// var detail = document.detailForm.prodDetail.value;
			// var manuDate = document.detailForm.manuDate.value;
			// var price = document.detailForm.price.value;
			var name = $("input[name='prodName']").val();
			var detail = $("input[name='prodDetail']").val();
			var manuDate = $("input[name='manuDate']").val();
			var price = $("input[name='price']").val();

			if (name == null || name.length < 1) {
				alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if (detail == null || detail.length < 1) {
				alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if (manuDate == null || manuDate.length < 1) {
				alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if (price == null || price.length < 1) {
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}

			$("form[name='detailForm']")
					.attr("method", "post")
					.attr("action", '/product/addProduct')
					.attr("enctype", 'multipart/form-data')
					.submit();
			// document.detailForm.action='/product/addProduct';//������Ʈ�� addProduct���� ��
			// document.detailForm.submit();
		}//end of fncAddProduct()

		function resetData() {
			$("form[name='detailForm']")
					[0]
					.reset();
			// document.detailForm.reset(); �Ϲݰ�ü�� ������ reset() ��밡��
		}//end of resetData()

		$(function () {
			$('.add').bind('click', function () {
				fncAddProduct();
			});
			$('.cancel').bind('click', function () {
				resetData();
			});
			$('.back').bind('click', function () {
				self.location.href = '/';
			});
		});//end of ready

	</script>
</head>

<body>

<form class="form-horizontal default-font" name="detailForm">

	<h1>��ǰ���</h1>
	<div class="form-group">
		<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		<div class="col-sm-4">
			<input type="text" id="prodName" name="prodName" class="form-control" placeholder="��ǰ��"
				   maxLength="20">
<%--			<input type="text" class="form-control" id="userId" name="userId" placeholder="�ߺ�Ȯ���ϼ���" readonly>--%>
<%--			<span id="helpBlock" class="help-block">--%>
<%--		      	<strong class="text-danger">�Է��� �ߺ�Ȯ�� ����..</strong>--%>
<%--		      </span>--%>
		</div>
<%--		<div class="col-sm-3">--%>
<%--			<button type="button" class="btn btn-info">�ߺ�Ȯ��</button>--%>
<%--		</div>--%>
	</div>

	<div class="form-group">
		<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		<div class="col-sm-4">
			<input type="text" id="prodDetail" name="prodDetail" class="form-control" placeholder="��ǰ������"
				   maxLength="50"/>
		</div>
	</div>

	<div class="form-group">
		<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		<div class="col-sm-4">

			<input class="form-control" id="manuDate" type="text" name="manuDate" readonly="readonly"
				   	maxLength="10" minLength="6"/>
			&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"
					   onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
		</div>
	</div>

	<div class="form-group">
		<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		<div class="col-sm-4">
			<input type="text" name="price" 	class="form-control" id="price" placeholder="���ڸ� �Է�"
				    maxLength="10">
		</div>
	</div>

	<div class="form-group">
		<label for="fileList" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>

		<div class="col-sm-4">
			<input		type="file" name="fileList" multiple class="form-control" id="fileList"/>
		</div>
	</div>


	<div class="form-group">
		<div class="col-sm-offset-4  col-sm-4 text-center">
			<button type="button" class="btn btn-primary add">��&nbsp;��</button>
			<button type="button" class="btn btn-primary cancel">��&nbsp;��</button>
			<button type="button" class="btn btn-primary back">�ڷΰ���</button>
		</div>
	</div>
</form>
</body>
</html>