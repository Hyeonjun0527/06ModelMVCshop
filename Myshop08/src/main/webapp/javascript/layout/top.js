$(function() {

    //==> ����������ȸ Event ����ó���κ�
    //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
    $(".item:contains('login')").on("click", function () {
        //Debug..
        //alert(  $( ".Depth03:contains('����������ȸ')" ).html() );
        $(window.parent.frames["rightFrame"].document.location).attr("href", "/user/loginView.jsp");
    });

    $(".item:contains('logout')").on("click", function () {
        //Debug..
        //alert(  $( ".Depth03:contains('����������ȸ')" ).html() );
        $(window.parent.frames["_parent"].document.location).attr("href", "/user/logout");
    });
});