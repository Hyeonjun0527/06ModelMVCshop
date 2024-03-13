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
    //쿠키 키 밸류 정해서 쿠키에 값을 추가해주는놈 "history" prodName
    //쿠키를 완전히 바꾸려면
    public static void addValue(HttpServletRequest request,HttpServletResponse response,String CookieKey, String CookieValue) throws UnsupportedEncodingException{

        //쿠키 설정
        Cookie clientCookies[] = request.getCookies();
        System.out.println(clientCookies);

        //쿠키 있는지 확인
        boolean checkHistory=false;
        for (Cookie tempCookie : clientCookies) {
            if(tempCookie.getName().equals(CookieKey)){
                checkHistory=true;
            }//end of if
        }//end of for

        //없으면 만들고 있으면 추가한다.
        if(checkHistory==false) {
            Cookie newCookie = new Cookie(CookieKey, CookieValue);
            response.addCookie(newCookie);
        }
        else{//쿠키가 있다.
            for (Cookie tempCookie : clientCookies) {
                //파라미터의 키와 쿠키속의 키가 같은게 있고, Value는 달라? 추가해.
                if (tempCookie.getName().equals(CookieKey) && !tempCookie.getValue().equals(CookieValue)) {

                    System.out.println("for-if문 실행");
                    String cookieString;
                    System.out.println("tempCookie"+tempCookie.getValue());
                    //""이 들어올수도 있음...JSESSIONID만 남았을때가 그때임.
                    if(tempCookie.getValue().equals("")) {
                        cookieString = CookieValue;
                    }else {
                        cookieString = URLDecoder.decode(tempCookie.getValue(), "EUC-KR") + ";" + CookieValue;
                    }
                    Cookie cookie = new Cookie(CookieKey, URLEncoder.encode(cookieString, "EUC-KR"));
                    System.out.println("추가한 쿠키 : " + cookie);
                    response.addCookie(cookie);

                } // end of if
            } // end of for
        }//end of else
    }

}
