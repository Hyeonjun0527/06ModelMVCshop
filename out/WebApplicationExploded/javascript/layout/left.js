function histories() {
	popWin = window
		.open(
			"/cookie/createHistory",
			"popWin",
			"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
}
//==> jQuery 적용 추가된 부분
	$(function() {

		//==> 개인정보조회 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( ".item:contains('개인정보조회')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('개인정보조회')" ).html() );
			const value = "/user/getUser?userId="+userId;
			$(window.parent.frames["rightFrame"].document.location).attr("href",value);
		});


		//==> 회원정보조회 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( ".item:contains('회원정보조회')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		});

		//판매상품등록
		$( ".item:contains('판매상품등록')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","../product/addProductView.jsp;");
		});
		//판매상품관리
		$( ".item:contains('판매상품관리')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=manage");
		});
		//상품검색
		$( ".item:contains('상 품 검 색')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
		});
		//판매이력조회
		$( ".item:contains('판매이력조회')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase?menu=manage");
		});
		//구매이력조회
		$( ".item:contains('구매이력조회')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase?menu=search");
		});
		//찜리스트
		$( ".item:contains('찜 리스트')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/cookie/createLike?menu=search&from=left.jsp");
		});
		//최근본상품
		$( ".item:contains('최근 본 상품')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			histories();
		});
	});