
console.log("1��°��")
//console.log(type); // �����κ��� ���� 'type' �� �α� ���

// �������� 'id'�� �����Ͽ� �ش� ��� ����
if(type !== ''){
	// const searchTypeElement = document.getElementById("searchType"+type);
	const searchTypeElement = $("searchType"+type);
	if (searchTypeElement.length > 0) { // ��Ұ� �����ϴ��� Ȯ��
		console.log("����Ǵ��� Ȯ���غ���. 8��° ���� variousSearch.js");
	    // searchTypeElement.style.backgroundColor = "#0056b3";
		searchTypeElement.css({
			backgroundColor : "#0056b3"
		})
	    // searchTypeElement.type = "hidden";
		searchTypeElement.prop("type","hidden");
	}
}

function fncGetList(currentPage) {
	console.log(`fncGetList����`);

	$("#currentPage").val(currentPage)
	//������ ��ǲ�� ������ ������ ó���ϴ� ���� : ������ ������ ó���ϵ��� ������ «. ��� �����κ��� �޾Ҵ��� ��� �ٽ� ����.
	//��ǲ�� ������ ������ ������ �Ⱥ����� ���� : ������ ��ǲ�� ������ ó���ϰ�, ��ǲ�� �������� ���� �ִ��� ������ ������ «.
	// if(��ǲ����){
	// 	��ǲ ��������
	// }else{//��ǲ�� ����
	// 	if(${}����){
	// 		��ǲ ${}��������.
	// 	}else{//��ǲ������ ${}������
	// 		��ǲ �ȳ�������.
	// 	}
	// }
	console.log(`searchBoundFirst��` + searchBoundFirst);
	console.log(`searchBoundEnd��` + searchBoundEnd);
	console.log(typeof(searchBoundFirst));
	console.log(typeof(searchBoundEnd));


	console.log("type���� ������?");
	console.log("type :: ",type);
	if(type===''){
		console.log("type�� undefined");
		type=`1`;
	}
//
	//if(document.getElementById("searchBoundFirst").value !== '' && document.getElementById("searchBoundEnd").value !== ''){
	if($("#searchBoundFirst").val() !== '' && $("#searchBoundEnd").val() !== ''){
		console.log("if 1��° ����");
	}else {
		console.log("else 1��° ����");
		if (searchBoundFirst !== "0" || searchBoundEnd !== "0") {
			console.log("if 2��° ����");
			// document.getElementById("searchBoundFirst").value = searchBoundFirst;
			// document.getElementById("searchBoundEnd").value = searchBoundEnd;
			$("#searchBoundFirst").val() = searchBoundFirst;
		} else {
			console.log("else 2��° ����");
			document.getElementById("searchBoundFirst").value=0;
			document.getElementById("searchBoundEnd").value=0;
			//������ǲ�� ������ �װŷ� ������ �Ǵ��ϵ��� �ϴ� ������ �ſ� ������.
		}
	}
	//if(��ǲ����){
	//��ǲ��������.
	//else{//��ǲ����
	//if(${}����){
	//�� ��찡 ����� ����� ���� 0�̴�. �ֳ��ϸ� ������ �ѹ� ������ ���°� �Ұ����Ͽ� ��ǲ(����)�� ������ ${}(����)�� ����.
	//}
	var radios = document.getElementsByName('searchType');
	console.log("radios",radios);
	var isSelected = Array.from(radios).some(radio => radio.checked);
	if (isSelected) {
		console.log("if 3��° ����");
	}else{
		console.log("else 3��° ����");
		console.log("searchType�� type�� : ",type,"�Ҵ�");
		document.getElementById("searchType"+type).checked = true;

	}

	//�׼ǿ��� �� �ᳪ? �׼��� �޾ҳ�? Ȯ���ϱ�, �׼��� �� �ᳪ? Ȯ���ϱ�
	const url = "/product/listProduct?menu="+menu;
	console.log(url);
	$("form").attr("method" , "POST").attr("action" , url).submit();
}


// function fncGetListNorm(currentPage){
// 	document.getElementById("searchType1").value = "1";
// 	fncGetList(currentPage);
// }
// function fncGetListPriceDesc(currentPage){
// 	document.getElementById("searchType2").value = "2";
// 	fncGetList(currentPage);
// }
// function fncGetListPriceAsc(currentPage){
// 	document.getElementById("searchType3").value = "3";
// 	fncGetList(currentPage);
// }