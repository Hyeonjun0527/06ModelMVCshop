function histories() {
	popWin = window
		.open(
			"/cookie/createHistory",
			"popWin",
			"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
}
//==> jQuery ���� �߰��� �κ�
	$(function() {

		//==> ����������ȸ Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( ".item:contains('����������ȸ')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('����������ȸ')" ).html() );
			const value = "/user/getUser?userId="+userId;
			$(window.parent.frames["rightFrame"].document.location).attr("href",value);
		});


		//==> ȸ��������ȸ Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( ".item:contains('ȸ��������ȸ')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		});

		//�ǸŻ�ǰ���
		$( ".item:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","../product/addProductView.jsp;");
		});
		//�ǸŻ�ǰ����
		$( ".item:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=manage");
		});
		//��ǰ�˻�
		$( ".item:contains('�� ǰ �� ��')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
		});
		//�Ǹ��̷���ȸ
		$( ".item:contains('�Ǹ��̷���ȸ')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase?menu=manage");
		});
		//�����̷���ȸ
		$( ".item:contains('�����̷���ȸ')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase?menu=search");
		});
		//�򸮽�Ʈ
		$( ".item:contains('�� ����Ʈ')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/cookie/createLike?menu=search&from=left.jsp");
		});
		//�ֱٺ���ǰ
		$( ".item:contains('�ֱ� �� ��ǰ')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			histories();
		});
	});