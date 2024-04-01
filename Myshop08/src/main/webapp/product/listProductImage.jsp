<!-- ��ǰ�����ȸ -->
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>��ǰ �����ȸ</title>
    <%--��������--%>
    <script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

    <%--��Ʈ��Ʈ��--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%-- ��Ʈ��Ʈ�� Dropdown Hover CSS JS--%>
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
    <%--�����--%>
    <script
            src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"
            integrity="sha256-6XMVI0zB8cRzfZjqKcD01PBsAy3FlDASrlC8SxCpInY="
            crossorigin="anonymous"></script>
    <script src="/javascript/thumbnailEvent.js"></script>
    <link rel="stylesheet" href="/css/font.css" type="text/css">
    <link rel="stylesheet" href="/css/loading.css" type="text/css">
    <style>
        body {
            padding-top: 50px;
        }
        .no-padding{
            padding: 0;
        }
        .thumbnail .carousel-inner>.imgWrapper.active.item{
            display: inline-block;
            width:300px;
            height:300px;
        }
        .carousel-inner>.item.imgWrapper{
            width: 300px;
            height: 300px;
            position: relative;
            display:none;
        }

        .thumbnail .imgWrapper img.threeD {
            height: 100%;
            width: 100%;
            border-radius: 10px;
        }
        img.threeD{
            position:relative;
        }
        #carousel-example-generic, .custom{
            height:300px;
            width:300px;
        }
        .item ,.carousel-inner{
            height:100%;
            width:100%;
        }
    </style>
    <link href="/css/listProduct.css" rel="stylesheet" type="text/css">

</head>

<body class="default-font">

<jsp:include page="/layout/toolbar.jsp"/>
<script>



</script>
<div class="container main">

    <div class="page-header text-info">
        <h3>${menu=='manage' ? '��ǰ����' :'��ǰ�����ȸ'}</h3>
    </div>

    <div class="row">
        <%--�� ���±׸� �����ϴ� �� 1,2,3,4Ŭ���̳� �˻��Ҷ�����. --%>
            <div class="col-md-6 text-left">
                <p class="text-primary">
                    ��ü ${totalCount} �Ǽ�, ���� ${requestScope.resultPage.currentPage} ������
                </p>
                <div class="col-md-12 no-padding">
                    <button type="button" class="btn btn-primary" data-toTable>���̺�� ����<span aria-hidden="true"> &nbsp&rarr;</span>
                    </button>
                </div>
            </div>
        <form class="form-inline" name="detailForm">

            <div class="col-md-6 text-right">
                <div class="form-group">
                    <select name="searchCondition"
                            class="form-control">
                        <c:choose>
                            <c:when test="${requestScope.search.searchCondition=='0'}">
                                <option value="0" selected>��ǰ��ȣ</option>
                                <option value="1">��ǰ��</option>
                                <option value="2">��ǰ����</option>
                            </c:when>
                            <c:when test="${requestScope.search.searchCondition=='1'}">
                                <option value="0">��ǰ��ȣ</option>
                                <option value="1" selected>��ǰ��</option>
                                <option value="2">��ǰ����</option>
                            </c:when>
                            <c:when test="${requestScope.search.searchCondition=='2'}">
                                <option value="0">��ǰ��ȣ</option>
                                <option value="1">��ǰ��</option>
                                <option value="2" selected>��ǰ����</option>
                            </c:when>
                            <c:otherwise>
                                <option value="0">��ǰ��ȣ</option>
                                <option value="1">��ǰ��</option>
                                <option value="2">��ǰ����</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="searchKeyword">�˻���</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
                           placeholder="�˻���"
                           value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                </div>

                <button type="button" class="btn btn-default">�˻�</button>
                <input type="hidden" id="currentPage" name="currentPage" value=""/>
            </div>
            <div class="col-md-12 text-right">
                <div class="form-group">

                    <input type="radio" id="searchType1" name="searchType" value="1"/>
                    <label for="searchType1" class="button">�Ϲ� �˻�</label>

                    <input type="radio" id="searchType2" name="searchType" value="2"/>
                    <label for="searchType2" class="button">���� ������ �˻�</label>

                    <input type="radio" id="searchType3" name="searchType" value="3"/>
                    <label for="searchType3" class="button">���� ������ �˻�</label>

                    <input type="text" id="searchBoundFirst" name="searchBoundFirst"
                           value='${search.searchBoundFirst}'/>
                    ����
                    <input type="text" id="searchBoundEnd" name="searchBoundEnd" value='${search.searchBoundEnd}'/>
                    ����

                    <button type="button" data-searchBound>�˻�</button>

                </div>
            </div>
        </form>
    </div>


    <div class="row">
        <c:set var="i" value="0"/>
        <c:set var="j" value="0"/>
        <c:forEach var="product" items="${list}">
            <c:set var="i" value="${i+1}"/>
            <div class="col-sm-6 col-md-4">
                <p>No : ${i}</p>
                <div class="thumbnail">

                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner" role="listbox">

                            <c:set var="k" value="0"/>

                    <c:forEach var="fileName" items="${fileNameListList[j]}">
                        <c:if test="${fileName!='null'}">
                            <c:if test="${k==0}">
                            <div class="item active imgWrapper">
                                <img class="threeD" src="${pageContext.request.contextPath}/images/uploadFiles/${fileName}">
                            </div>
                            </c:if>
                            <c:if test="${k!=0}">
                                <div class="item imgWrapper">
                                    <img class="threeD" src="${pageContext.request.contextPath}/images/uploadFiles/${fileName}">
                                </div>
                            </c:if>
                        </c:if>
                        <c:set var="k" value="${k+1}"/>
                    </c:forEach>

                    <c:if test="${fileNameListList[j]==null}">
                        <div class="item active imgWrapper">
                            <img class="threeD" src="${pageContext.request.contextPath}/images/uploadFiles/��ī��.jpg">
                        </div>
                    </c:if>

                        </div>
                    </div>
<%--                    ���⼭ carousel�� �� --%>
                    <c:set var="j" value="${j+1}"/>


                    <div class="caption">

                        <h3>��ǰ�� : ${product.prodName}</h3>
                        <p>��ǰ���� : </p>
                        <p>���� : ${product.price}</p>

                        <p>������� :
                        <c:if test="${product.proTranCode!=null}">
                            <c:set var="resultA" value="${product.proTranCode.trim() == 'a' ? '�Ǹ���' : ''}"/>

                            <c:if test="${menu == 'manage' || menu == 'ok'}">
                                <c:set var="resultB" value="${product.proTranCode.trim() == 'b' ? '�ǸſϷ�' : ''}"/>
                                <c:set var="resultB2" value="${product.proTranCode.trim() == 'b' ? '����ϱ�' : ''}"/>
                                <c:set var="resultC" value="${product.proTranCode.trim() == 'c' ? '�����' : ''}"/>
                                <c:set var="resultD" value="${product.proTranCode.trim() == 'd' ? '��ۿϷ�' : ''}"/>
                            </c:if>
                                    ${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}
                                <c:if test="${!(menu == 'manage' || menu == 'ok')&&product.proTranCode.trim()!='a'}">
                                    �ǸſϷ�
                                </c:if>
                                <span class="clickableSpan" data-update
                                      data-prodNo="${product.prodNo}">${resultB2}</span>${resultC}${resultD}
                        </c:if>
                        </p>

                        <c:if test="${product.proTranCode=='a'}">
                            <button type="button" class="abled btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">��ǰ����
                            </button>
                        </c:if>
                        <c:if test="${!(product.proTranCode=='a')}">
                            <button type="button" class="disabled btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">��ǰ����
                            </button>
                        </c:if>
                        <button type="button" class="btn btn-primary" data-setLike data-prodNo="${product.prodNo}">
                            ���ϱ�
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>



</div>

<div class="loading-container" style="display: none">
    <div class="loading"></div>
    <div id="loading-text">loading</div>
</div>


<script>

    if ('scrollRestoration' in history) {
        history.scrollRestoration = 'manual';
    }

    $(document).ready(function() {
        $(window).scrollTop(0);
    });
    // $(window).on('beforeunload', function() {
    //     $(window).scrollTop(0);
    // });

    let menu = '${param.menu}';
    let currentPage = +`${search.currentPage}`;
    let searchKeyword = '${search.searchKeyword}';
    let searchCondition = '${search.searchCondition}';
    let searchType = `${search.searchType}`;
    let searchBoundFirst = '${param.searchBoundFirst}';
    let searchBoundEnd = '${param.searchBoundEnd}';
    let type = '${search.searchType}';//������ ���� �ƹ��͵� ���� ������ ��.''�� ��

    console.log(menu);
    console.log('jsp���� searchBoundFirst', searchBoundFirst);
    console.log('jsp���� searchBoundEnd', searchBoundEnd);
    console.log('jsp���� type', type);

    $(document).ready(function () {


        $(document).on('click', 'td.ct_btn01[data-search] button:contains("�˻�")', function () {
            fncGetList('1');
        });

        $(document).on('click', 'button[data-searchBound]:contains("�˻�")', function () {
            fncGetList('${resultPage.currentPage}');
        });

        $(document).on('click', 'button[data-getProduct].abled', function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/getProduct?prodNo=" + prodNo + "&menu=${menu}";
        });

        $(document).on('click', 'button[data-update]', function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/purchase/updateTranCode?prodNo=" + prodNo + "&navigationPage=listProduct&menu=manage";
        });

        $(document).on('click', 'button[data-setLike]', function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/setLikeProduct?prodNo=" + prodNo + "&menu=${menu}&currentPage=${resultPage.currentPage}";
        });

        $(document).on('click', 'input[name=searchType]', function () {
            fncGetList('1');
        });

        $(document).on('click', 'button[data-toTable]', function () {
            window.location.href = "/product/listProduct?menu=${menu}";
        });


        $('input[name="searchKeyword"]').autocomplete({
            source: function (request, response) {

                function createLabelValueMapper(Prop) {
                    return function (object) {
                        return {
                            label: object[Prop],
                            value: object[Prop]
                        }
                    }
                };
                let searchCondition = $('select[name=searchCondition]').val()

                console.log("�ҽ��� ȣ��˴ϴ�.");
                console.log("�� ������ : request.term : " + request.term);

                console.log("�� ������ : Condition : " + searchCondition);
                console.log(JSON.stringify({
                    searchKeyword: request.term,
                    searchCondition: searchCondition
                }));
                $.ajax({
                    url: '/product/json/autoComplete',
                    type: 'post',
                    dataType: 'json',
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    data: JSON.stringify({
                        searchKeyword: request.term,
                        searchCondition: searchCondition
                    }),
                }).done(function (rawData, textStatus, jqXHR) {
                    console.log('���� ������ : ' + rawData);
                    if (rawData.length !== 0) {
                        // �����κ��� ���� ������ (Product ��ü�� ����Ʈ)�� ó��
                        console.log('�����Ͱ� ���� data : ' + rawData);
                        //��ȣ, ��, ���� $.map�� ��ҿ� function �� �����Ű�� �迭 ��ȯ
                        //�� function�� ����� function�� ����� �� ���ϰڴ�. �װ� mapper����

                        switch (searchCondition) {
                            case '0':
                                mapper = createLabelValueMapper("prodNo");
                                break;
                            case "1":
                                mapper = createLabelValueMapper("prodName");
                                break;
                            case "2":
                                mapper = createLabelValueMapper("price");
                                break;
                        }

                        let data = $.map(rawData, mapper);
                        console.log('data : ' + data);
                        $.each(data, function (index, obj) {
                            console.log(obj);
                        })
                        console.log("data[0] : " + JSON.stringify(data[0]));
                        let matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(request.term), "i");
                        console.log($.grep(data, function (item) {
                            return matcher.test(item.label);
                        }));
                        response($.grep(data, function (item) {
                            return matcher.test(item.label);
                        }).slice(0, 5));
                        //.slice(0,7)
                        //response(data); // ó���� �����͸� �ڵ��ϼ� ������� ǥ��
                    } else {
                        // �����κ��� ���� �����Ͱ� ���� ���� �� �迭�� �����Ͽ� �ڵ��ϼ��� �������� ����
                        response([]);
                    }

                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log('����');
                    console.log(jqXHR);
                    console.log(textStatus);
                    console.log(errorThrown);
                });
            },//end of source
            select: function (event, ui) {
                // �ɼ��� �������� ��, ���ϴ� ������ ������ �� ����
                // ���� ���, ���õ� Product�� id�� ��򰡿� �����ϰų� �ٸ� �۾��� ����
                console.log("Selected: " + ui.item.label + ", id: " + ui.item.value);
                let $element = $('input[name="searchKeyword"]');

                $element.addClass('flash-effect');
                $element.one('animationed', function () {
                    $element.removeClass('flash-effect');
                });
            },//end of select event
            classes: {
                "ui-autocomplete": "custom-ui-autocomplete",
            },

            autoFocus: true,//end of autoFocus

        });//end of autocomplete

        let imgWrapper = $("div.imgWrapper");
        let oneTime = true;

        // imgWrapper.on('mouseIn', function (e) {
        //     console.log("��� ���ö� �ѹ��� ����Ǿ�� ��.");
        //     //  imgWrapper.css('transition', 'transform 0.5s');
        // });
        //
        // imgWrapper.on('mousemove', function (e) {
        //     let num = 10;
        //     let x = e.offsetX//0~240  0�϶� rotateY(20deg) 240�϶� rotateY(-20deg)
        //     // 20 = 0*a + b  -20 = 240*a + b
        //     // b= 20 a = -20*2/240
        //
        //     let y = e.offsetY//0~300 0�϶� rotateX(-20deg) 300�϶� rotateX(20deg)
        //     // -20 = 0*a + b  20 = 300*a + b
        //     // b = -20 a= 40*2/240
        //
        //     console.log(x, y);
        //
        //     let rotateY = -num*2 / 240 * x + num
        //     let rotateX = num*2 / 300 * y - num
        //     console.log(rotateY, rotateX);
        //
        //     $(this).css('transform', 'perspective(350px) rotateX(' + rotateX + 'deg) rotateY(' + rotateY + 'deg)');
        //
        //     if (oneTime) {
        //         $(this).css('transition', 'transform 0.3s');
        //         oneTime = false;
        //     }
        //     console.log($(this)[0].style.transform);
        // });
        //
        // imgWrapper.on('mouseout', function (e) {
        //     oneTime = true;
        //     $(this).css('transition', 'transform 0.5s');
        //     $(this).css('transform', 'perspective(350px) rotateX(' + 0 + 'deg) rotateY(' + 0 + 'deg)');
        //     console.log($(this)[0].style.transform);
        // });
        // imgWrapper.on('transitionend', function () {
        //     // transition ȿ���� ������ transition �Ӽ� ����
        //     $(this).css('transition', '');
        // });

        let isLoading = false;
        $(window).scroll(function() {
            if (isLoading) return;

            console.log("��ť��Ʈ ����Ʈ"+$(document).height());
            // console.log("�ٵ� ��ũ������Ʈ :: " + document.body.scrollHeight);
            console.log("������ ����Ʈ"+$(window).height());
            // console.log("�̳�����Ʈ" + window.innerHeight);
            console.log("��ũ��ž :: "+$(window).scrollTop());
            console.log("=========================");
            var scrollTop = $(window).scrollTop();
            var windowHeight = $(window).height();
            var documentHeight = $(document).height();
            var offset = 5; // ���ο� �������� �ε��� ��ũ�� ��ġ�� ������, �긦 �ø��� �ϴܹ� ������ �Ȱ��� ����
            var offsetReposition = 100;
            // ��ũ���� ������ �ϴܿ� �����ߴ��� Ȯ��
            if (scrollTop + windowHeight >= documentHeight - offset) {
                isLoading = true;
                // ���⼭ ���ο� �������� �ҷ����� ������ �����մϴ�.
                // ����: ���ο� �������� �������� �߰�
                console.log('�̺�Ʈ�߻�');
                console.log("currentPage �� ���� ���������� ����. :: " + currentPage);

                $('.loading-container').show();

                //���������� ������ ���ٿ��µ� �װ͵� ���ο� HTTP��û, ���ο� �������̴�.
                //�������� currentPage�� 1�� ���ϸ� �ȴ�.

                $.ajax(
                    {
                        url:"json/listProductImg",
                        method:"POST",
                        dataType:"json",
                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json"
                        },
                        data: JSON.stringify({
                            currentPage : currentPage,
                            searchKeyword: searchKeyword,
                            searchCondition: searchCondition,
                            searchType:searchType,
                            searchBoundFirst:searchBoundFirst,
                            searchBoundEnd:searchBoundEnd,
                            menu:menu
                        }),
                    }).done(function (data) {
                    console.log("���� ������" + JSON.stringify(data));

                    setTimeout(function() {
                            $('.loading-container').hide();
                    },800);
                    if (data.products && data.products.length > 0) {
                        setTimeout(function () {
                            window.scrollTo(0, scrollTop - offsetReposition)
                            makeThumbnail(data);
                            console.log("currentPage :: " + currentPage);
                            isLoading = false;
                        }, 800);
                    }
                    }).fail(function(jqXHR, textStatus, errorThrown){
                        console.log('����');
                        console.log(jqXHR);
                        console.log(textStatus);
                        console.log(errorThrown);
                    });



            };//end of if
        });//end of scroll



        // $.ui.autocomplete.prototype._close = function(event) {
        //     // �˻��� ���� ������ �����ϰų� ���ǿ� ���� ó��
        // };
    });//end of ready
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/variousSearch.js"></script>
</body>

</html>