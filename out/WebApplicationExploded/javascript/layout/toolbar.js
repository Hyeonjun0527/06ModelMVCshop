function histories() {
	popWin = window
		.open(
			"/cookie/createHistory",
			"popWin",
			"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
}
//==> jQuery ���� �߰��� �κ�
	$(function() {

		$("a:contains('�α׾ƿ�')").on("click" , function() {
			$(self.location).attr("href","/user/logout");
			//self.location = "/user/logout"
		});

		$("a:contains('ȸ��������ȸ')").on("click" , function() {
			//$(self.location).attr("href","/user/logout");
			self.location = "/user/listUser"
		});

		$( "a:contains('����������ȸ')" ).on("click" , function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId="+userId);
		});
		//�ǸŻ�ǰ���
		$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
			//Debug..
			console.log("����");
			$(self.location).attr("href","../product/addProductView.jsp;");
		});
		//�ǸŻ�ǰ����
		$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
			//Debug..
			self.location = "/product/listProduct?menu=manage";
		});
		//��ǰ�˻�
		$( "a:contains('�� ǰ �� ��')" ).on("click" , function() {
			//Debug..
			self.location = "/product/listProduct?menu=search";
		});
		//�Ǹ��̷���ȸ
		$( "a:contains('�Ǹ��̷���ȸ')" ).on("click" , function() {
			//Debug..
			self.location = "/purchase/listPurchase?menu=manage";
		});
		//�����̷���ȸ
		$( "a:contains('�����̷���ȸ')" ).on("click" , function() {
			//Debug..
			self.location = "/purchase/listPurchase?menu=search";
		});
		//�򸮽�Ʈ
		$( "a:contains('�� ����Ʈ')" ).on("click" , function() {
			//Debug..
			self.location = "/cookie/createLike?menu=search&from=toolbar.jsp";
		});
		//�ֱٺ���ǰ
		$( "a:contains('�ֱ� �� ��ǰ')" ).on("click" , function() {
			//Debug..
			histories();
		});
		// $( ".item:contains('����������ȸ')" ).on("click" , function() {
		// 	//Debug..
		// 	//alert(  $( ".Depth03:contains('����������ȸ')" ).html() );
		// 	const value = "/user/getUser?userId="+userId;
		// 	$(window.parent.frames["rightFrame"].document.location).attr("href",value);
		// });
		//
		// //==> ȸ��������ȸ Event ����ó���κ�
		// //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		// $( ".item:contains('ȸ��������ȸ')" ).on("click" , function() {
		// 	//Debug..
		// 	//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
		// 	$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		// });
	});