package com.model2.mvc.common.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {

    ///Field
    //Constructor
    //Method
    //��Ű Ű ��� ���ؼ� ��Ű�� ���� �߰����ִ³� "history" prodName
    //��Ű�� ������ �ٲٷ���
    public static void addValue(HttpServletRequest request,HttpServletResponse response,String CookieKey, String CookieValue) throws UnsupportedEncodingException{

        //��Ű ����
        Cookie clientCookies[] = request.getCookies();
        System.out.println(clientCookies);

        //��Ű �ִ��� Ȯ��
        boolean checkHistory=false;
        for (Cookie tempCookie : clientCookies) {
            if(tempCookie.getName().equals(CookieKey)){
                checkHistory=true;
            }//end of if
        }//end of for

        //������ ����� ������ �߰��Ѵ�.
        if(checkHistory==false) {
            Cookie newCookie = new Cookie(CookieKey, CookieValue);
            response.addCookie(newCookie);
        }
        else{//��Ű�� �ִ�.
            for (Cookie tempCookie : clientCookies) {
                //�Ķ������ Ű�� ��Ű���� Ű�� ������ �ְ�, Value�� �޶�? �߰���.
                if (tempCookie.getName().equals(CookieKey) && !tempCookie.getValue().equals(CookieValue)) {

                    System.out.println("for-if�� ����");
                    String cookieString;
                    System.out.println("tempCookie"+tempCookie.getValue());
                    //""�� ���ü��� ����...JSESSIONID�� ���������� �׶���.
                    if(tempCookie.getValue().equals("")) {
                        cookieString = CookieValue;
                    }else {
                        cookieString = URLDecoder.decode(tempCookie.getValue(), "EUC-KR") + ";" + CookieValue;
                    }
                    Cookie cookie = new Cookie(CookieKey, URLEncoder.encode(cookieString, "EUC-KR"));
                    System.out.println("�߰��� ��Ű : " + cookie);
                    response.addCookie(cookie);

                } // end of if
            } // end of for
        }//end of else
    }

}
