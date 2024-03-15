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
    public static void addValue(HttpServletRequest request,HttpServletResponse response,String cookieKey, String cookieValue) throws UnsupportedEncodingException{

        //쿠키 설정
        Cookie clientCookies[] = request.getCookies();
        System.out.println(clientCookies);

        //이름이 히스토리인 쿠키 있는지 확인
        boolean checkHistory=false;
        for (Cookie tempCookie : clientCookies) {
            if(tempCookie.getName().equals(cookieKey)){
                checkHistory=true;
            }//end of if
        }//end of for

        //없으면 만들고 있으면 추가한다.
        if(checkHistory==false) {
            System.out.println("쿠키가 없다. 그러니 새로운 쿠키 생성");
            Cookie newCookie = new Cookie(cookieKey, cookieValue);
            newCookie.setPath("/");
            response.addCookie(newCookie);
        }
        else{//쿠키가 있다.
            System.out.println("쿠키가 있다. 그러니 ");
            for (Cookie tempCookie : clientCookies) {
                System.out.println("쿠키명" + tempCookie.getName());
                System.out.println("쿠키값" + URLDecoder.decode(tempCookie.getValue(),"EUC-KR"));
                String decodedTempCookieValue = URLDecoder.decode(tempCookie.getValue(),"EUC-KR");
                //파라미터의 키와 쿠키속의 키가 같은게 있고, Value는 달라? 추가해.
                //근데 Value가 다른걸 판단하려면 파싱을 한번더 해야해.
                if (tempCookie.getName().equals(cookieKey)) {

                    String[] list = decodedTempCookieValue.split(";");
                    boolean result = false;

                    for (String listElement : list) {
                        if (listElement.equals(cookieValue)) {
                            result = true;
                        }
                    }
                    if (!result) {//파라미터의 키와 쿠키의 키에 따른 데이터들 중에 같은게 없으면 추가한다.
                        System.out.println("for-if문 실행");
                        String cookieString;
                        //""이 들어올수도 있음...JSESSIONID만 남았을때가 그때임.
                        if (tempCookie.getValue().equals("")) {
                            cookieString = cookieValue;
                        } else {
                            System.out.println("history에 prodNo를 추가하였습니다.");
                            cookieString = URLDecoder.decode(tempCookie.getValue(), "EUC-KR") + ";" + cookieValue;
                        }
                        Cookie cookie = new Cookie(cookieKey, URLEncoder.encode(cookieString, "EUC-KR"));
                        cookie.setPath("/");
                        response.addCookie(cookie);
                        System.out.println("추가한 쿠키 : " + cookie.getName() + cookie.getValue());
                        System.out.println("if문 :: 쿠키값 :: " + URLDecoder.decode(tempCookie.getValue()));
                    }
                }
            } // end of for
        }//end of else
    }//end of addValue

}//end of class
