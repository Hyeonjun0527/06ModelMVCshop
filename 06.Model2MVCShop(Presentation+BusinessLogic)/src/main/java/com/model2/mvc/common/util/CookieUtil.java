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
    public static void addValue(HttpServletRequest request,HttpServletResponse response,String cookieKey, String cookieValue) throws UnsupportedEncodingException{

        //��Ű ����
        Cookie clientCookies[] = request.getCookies();
        System.out.println(clientCookies);

        //�̸��� @@�� ��Ű �ִ��� Ȯ��
        boolean checkHistory=false;
        for (Cookie tempCookie : clientCookies) {
            if(tempCookie.getName().equals(cookieKey)){
                checkHistory=true;
            }//end of if
        }//end of for

        //[������ �����] [������ �߰��Ѵ�]
        if(checkHistory==false) {
            System.out.println("��Ű�� ����. �׷��� ���ο� ��Ű ����");
            Cookie newCookie = new Cookie(cookieKey, cookieValue);
            newCookie.setPath("/");
            response.addCookie(newCookie);
        }
        else{//��Ű�� ������ �߰�����
            System.out.println("��Ű�� �ִ�. �׷��� �߰��ϰڴ�.");
            for (Cookie tempCookie : clientCookies) {
                System.out.println("��Ű��" + tempCookie.getName());
                String decodedTempCookieValue = URLDecoder.decode(tempCookie.getValue(),"EUC-KR");
                System.out.println("��Ű��" + decodedTempCookieValue);
                //�Ķ������ Key�� ��Ű���� Key�� ������? ��, like�� �ֳ�? history�� �ֳ�?
                if (tempCookie.getName().equals(cookieKey)) {

                    if (decodedTempCookieValue.startsWith(";")) {
                        decodedTempCookieValue = decodedTempCookieValue.substring(1);
                    }
                    String[] list = decodedTempCookieValue.split(";");

                    boolean result = false;//[������ �־� > true] [���� > false]

                    for (String listElement : list) {
                        if (listElement.equals(cookieValue)) {
                            result = true;
                        }
                    }
                    //��Ű�� Value�� �Ľ��ϰ� �Ķ���� value�� ������ �ִ°�?
                    if (!result) {//�Ķ������ Ű�� ��Ű�� Ű�� ���� �����͵� �߿� ������ ������ �߰��Ѵ�. ��, �ߺ��� �ƴϸ� �߰��Ѵ�.

                        String cookieString;
                        if (tempCookie.getValue().equals("")) {//ó���̸� 10000
                            cookieString = cookieValue;
                        } else {//ó���� �ƴϸ� 10000;10001
                            cookieString = decodedTempCookieValue + ";" + cookieValue;
                            System.out.println(cookieValue+"�� prodNo�� �߰��Ͽ����ϴ�.");
                        }
                        Cookie cookie = new Cookie(cookieKey, URLEncoder.encode(cookieString, "EUC-KR"));
                        cookie.setPath("/");
                        response.addCookie(cookie);
                        System.out.println("�߰��� ��Ű : " + URLEncoder.encode(cookieString, "EUC-KR"));
                    }
                }
            } // end of for
        }//end of else
    }//end of addValue

}//end of class
