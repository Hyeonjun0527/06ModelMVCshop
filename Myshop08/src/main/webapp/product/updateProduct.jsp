<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- �޴��� ���δ�Ʈ menu product --%>
<html>
<head>
    <title>��ǰ��������</title>

    <link rel="stylesheet" href="/css/admin.css" type="text/css">
    <script type="text/javascript">
        $(document).ready(function () {
            function fncUpdateProduct() {
                console.log("Here");

                // //Form ��ȿ�� ����
                // var name = document.detailForm.prodName.value;
                // var detail = document.detailForm.prodDetail.value;
                // var manuDate = document.detailForm.manuDate.value;
                // var price = document.detailForm.price.value;
                var name = $("form[name='detailForm'] input[name='prodName']").val();
                var detail = $("form[name='detailForm']input[name='prodDetail']").val();
                var manuDate = $("form[name='detailForm']input[name='manuDate']").val();
                var price = $("form[name='detailForm']input[name='price']").val();
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
                const url = '/product/updateProduct';
                document.detailForm.submit();
                $("form[name='detailForm']")
						.attr("method", "POST")
						.attr("action", url)
						.attr("enctype","multipart/form-data")
						.submit();
                <%--���⿡ ${requestScope.product.prodNo} ������? ������? form�±� �ȿ� ��ǲ�ϳ� �������� ���� �Ķ���� ������--%>
            }//end of fncUpdateProduct()

            $("img[data-calendar]").click(function () {
                show_calendar('document.detailForm.manuDate', $("form[name='detailForm']input[name='manuDate']").val());
            });
            $("button[data-update]").click(function () {
                fncUpdateProduct();
            });
            $("button[data-cancel]").click(function () {
                history.go(-1);
            });
        });
    </script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">

    <input type="hidden" name="prodNo" value="${requestScope.product.prodNo}">

    <table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="15" height="37">
                <img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
            </td>
            <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="93%" class="ct_ttl01">��ǰ����</td>
                        <td width="20%" align="right">&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td width="12" height="37">
                <img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                ��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="105">
                            <input type="text" name="prodName" class="ct_input_g"
                                   style="width: 100px; height: 19px" maxLength="20"
                                   value="${requestScope.product.prodName}">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                ��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="prodDetail" value="${requestScope.product.prodDetail}" class="ct_input_g"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6">
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                �������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" readonly="readonly" name="manuDate" value="${requestScope.product.manuDate}"
                       class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6">&nbsp;
                <img src="../images/ct_icon_date.gif" width="15" height="15" data-calendar/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                ���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="price" value="${requestScope.product.price}"
                       class="ct_input_g" style="width: 100px; height: 19px" maxLength="50"/>&nbsp;��
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">��ǰ�̹���</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="file" name="fileList" multiple class="ct_input_g"
                       style="width: 200px; height: 19px" maxLength="13"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
    </table>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
        <tr>
            <td width="53%"></td>
            <td align="right">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="17" height="23">
                            <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                        </td>
                        <button type="button" data-update>
                            ����
                        </button>
                        <td width="14" height="23">
                            <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                        </td>
                        <td width="30"></td>
                        <td width="17" height="23">
                            <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                        </td>
                        <button type="button" data-cancel>
                            ���
                        </button>
                        <td width="14" height="23">
                            <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>

</body>
</html>