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

        //�̸��� �����丮�� ��Ű �ִ��� Ȯ��
        boolean checkHistory=false;
        for (Cookie tempCookie : clientCookies) {
            if(tempCookie.getName().equals(cookieKey)){
                checkHistory=true;
            }//end of if
        }//end of for

        //������ ����� ������ �߰��Ѵ�.
        if(checkHistory==false) {
            System.out.println("��Ű�� ����. �׷��� ���ο� ��Ű ����");
            Cookie newCookie = new Cookie(cookieKey, cookieValue);
            newCookie.setPath("/");
            response.addCookie(newCookie);
        }
        else{//��Ű�� �ִ�.
            System.out.println("��Ű�� �ִ�. �׷��� ");
            for (Cookie tempCookie : clientCookies) {
                System.out.println("��Ű��" + tempCookie.getName());
                System.out.println("��Ű��" + URLDecoder.decode(tempCookie.getValue(),"EUC-KR"));
                String decodedTempCookieValue = URLDecoder.decode(tempCookie.getValue(),"EUC-KR");
                //�Ķ������ Ű�� ��Ű���� Ű�� ������ �ְ�, Value�� �޶�? �߰���.
                //�ٵ� Value�� �ٸ��� �Ǵ��Ϸ��� �Ľ��� �ѹ��� �ؾ���.
                if (tempCookie.getName().equals(cookieKey)) {

                    String[] list = decodedTempCookieValue.split(";");
                    boolean result = false;

                    for (String listElement : list) {
                        if (listElement.equals(cookieValue)) {
                            result = true;
                        }
                    }
                    if (!result) {//�Ķ������ Ű�� ��Ű�� Ű�� ���� �����͵� �߿� ������ ������ �߰��Ѵ�.
                        System.out.println("for-if�� ����");
                        String cookieString;
                        //""�� ���ü��� ����...JSESSIONID�� ���������� �׶���.
                        if (tempCookie.getValue().equals("")) {
                            cookieString = cookieValue;
                        } else {
                            System.out.println("history�� prodNo�� �߰��Ͽ����ϴ�.");
                            cookieString = URLDecoder.decode(tempCookie.getValue(), "EUC-KR") + ";" + cookieValue;
                        }
                        Cookie cookie = new Cookie(cookieKey, URLEncoder.encode(cookieString, "EUC-KR"));
                        cookie.setPath("/");
                        response.addCookie(cookie);
                        System.out.println("�߰��� ��Ű : " + cookie.getName() + cookie.getValue());
                        System.out.println("if�� :: ��Ű�� :: " + URLDecoder.decode(tempCookie.getValue()));
                    }
                }
            } // end of for
        }//end of else
    }//end of addValue

}//end of class
