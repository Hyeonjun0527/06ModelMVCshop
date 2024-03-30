function makeThumbnail(JsonData) {

    console.log(`JsonData :: ` + JSON.stringify(JsonData) );

    console.log("JsonData.search.currentPage :: " + JsonData.search.currentPage);
    currentPage = JsonData.search.currentPage;

    let i = currentPage;
    let products = 0;
    let returnPage = '';



    returnPage += `
<div class="row">`;

    console.log(`JsonData.products:: ` +JSON.stringify(JsonData.products));



    $.each(JsonData.products, function (index, value) {
            const product = JsonData.products[index];
            console.log(`product :: `+JSON.stringify(product));
            i++;

            returnPage += `
            <div class="col-sm-6 col-md-4">
            <p>No : ${i}</p>
                <div class="thumbnail">
                `;//end of append

            product.fileName?.split(",").forEach(function (fileName) {
                returnPage += `
                        <div class="imgWrapper">
                            <img class="threeD" src="/images/uploadFiles/"+${fileName}/>
                        </div>
                        `;
            });

            returnPage += `
                        <div class="caption">
                        <h3>��ǰ�� : ${product.prodName}</h3>
                        <p>��ǰ���� : </p>
                        <p>���� : ${product.price}</p>
            `;

            if (product.proTranCode != null) {
                let resultA = product.proTranCode.trim() === 'a' ? '�Ǹ���' : '';
                let resultB = product.proTranCode.trim() === 'b' ? '�ǸſϷ�' : '';
                let resultB2 = ``;
                let resultC =``;
                let resultD = ``;
                if (menu === 'manage' || menu === 'ok') {
                    resultB2 = product.proTranCode.trim() === 'b' ? '����ϱ�' : '';

                    resultC = product.proTranCode.trim() === 'c' ? '�����' : '';
                    resultD = product.proTranCode.trim() === 'd' ? '��ۿϷ�' : '';
                }
                returnPage += `
                <p>������� : 
                ${resultA}${resultB}${(resultB) ? `&nbsp;&nbsp;` : ``}
                `;
                if(!(menu == 'manage' || menu == 'ok')&&product.proTranCode.trim()!='a'){
                    returnPage += `�ǸſϷ�`;
                }
                returnPage +=`
                <span class="clickableSpan" data-update
                                  data-prodNo="${product.prodNo}">${resultB2}</span>${resultC}${resultD}
                </p>
                `;
            }//end of if
            if (product.proTranCode == 'a') {
                returnPage += `
                <button type="button" class="btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">��ǰ����
                </button>
                `;
            } else {
                returnPage += `
                <button type="button" class="disabled btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">��ǰ����
                </button>
                `;
            }

            returnPage += `
            <button type="button" class="btn btn-primary" data-setLike data-prodNo="${product.prodNo}">
            ���ϱ�
            </button>
            </div></div></div>
            `;
    });//end of each1

    returnPage += `</div>`;

    console.log(returnPage);
    $(`div.container.main`).append(returnPage);


};//end of function

/*
* {"search" : {"currentPage":1,"searchCondition":null,"searchKeyword":null,"searchType":null,"searchBoundFirst":0,"searchBoundEnd":0,"pageSize":3,"endRowNum":3,"startRowNum":1},
* "navigation":"forward:/product/getProduct.jsp",
* "resultPage":{"currentPage":1,"totalCount":27,"pageUnit":5,"pageSize":3,"maxPage":9,"beginUnitPage":1,"endUnitPage":5},
* "totalCount":27,"menu":null,"products":[{"fileName":"�⼮ť��.jpg","manuDate":"20120514","price":2000000,"prodDetail":"�Ҵ� ���̿� ��Ʈ�� �ŵ�ǰ","prodName":"vaio vgn FS70B","prodNo":10000,"regDate":1710255600000,"proTranCode":"b  "}
* ,{"fileName":"�ٿ�ε�.jpg,�⼮ť��.jpg","manuDate":"20120514","price":10000,"prodDetail":"������ ���ƿ�~","prodName":"������","prodNo":10001,"regDate":1710774000000,"proTranCode":"a"}
* ,{"fileName":null,"manuDate":"20120201","price":1170000,"prodDetail":"�ְ� ������ ��ǰ","prodName":"������","prodNo":10002,"regDate":1710946800000,"proTranCode":"a"}]}
*
* JsonData.products[0].fileName
* */

//���⼭ �Ľ��Ұǵ�, �Ľ��ؼ� ����Ŵ�.
//currentPage�� �ϳ��� ���ؾߵ� ��ũ�� �ѹ��ϸ� ���� ������ �������� ����ž�.


//������ ��� ���ٿ;���. ��ũ���Ҷ�����. �׷��� currentPage�� 1�� �÷��� ��û�ؾߵ�
//���δ����� ���δ�Ʈ�� ���� �迭
//���δ�Ʈ�� ��ü
//JsonData�� ���̽���ü, products�� �迭, product�� ���̽���ü
//{"fileName":"�ٿ�ε�.jpg,�⼮ť��.jpg",
// "manuDate":"20120514",
// "price":2000000,
//
// "prodDetail":"�Ҵ� ���̿� ��Ʈ�� �ŵ�ǰ",
// "prodName":"vaio vgn FS70B",
// "prodNo":10000,
// "regDate":1710255600000,
// "proTranCode":"b  "}
//3���� ���������.