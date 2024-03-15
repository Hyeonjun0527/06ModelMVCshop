package com.model2.mvc.web.user;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.Arrays;
import java.util.Collections;

@Controller
@RequestMapping("/cookie/*")
public class CookieController {

    ///Field

    private ProductService productService;
    private static final String RESET = "\u001B[0m";
    private static final String RED = "\u001B[91m";
    private static final String ORANGE = "\u001B[38;5;208m";
    private static final String YELLOW = "\u001B[93m";
    private static final String GREEN = "\u001B[92m";
    private static final String BLUE = "\u001B[94m";

    @Autowired
    public void setProductService(@Qualifier("productServiceImpl") ProductService productService){
        this.productService = productService;
    }

    ///Constructor

    public CookieController(){
        System.out.println("\n 생성자 :: "+this.getClass()+"\n");
    }

    ///Method
    @RequestMapping("/createHistory")
    public ModelAndView createHistory(HttpServletRequest request,
                                      HttpServletResponse response) throws Exception {
        System.out.println("/createHistory");
        System.out.println("::: "+GREEN+"CookieController :: createHistory() start"+RESET);

        Cookie[] cookies = request.getCookies();

        String history = null;//히스토리는 prodNo임 지금

        ArrayList<Product> products = new ArrayList<Product>();

        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                if (cookie.getName().equals("history")) {
                    System.out.println("쿠키명이 history인 쿠키를 찾았습니다.");
                    System.out.println("쿠키값1::"+cookie.getValue());
                    System.out.println("디코딩한 쿠키값1:: " + URLDecoder.decode(cookie.getValue(), "EUC-KR"));
                    history = URLDecoder.decode(cookie.getValue(), "EUC-KR");
                    System.out.println("history :: " + history);
                    String[] histories = null;
                    if (history != null) {
                        System.out.println("history :: " + history);
                        histories = history.split(";");
                        System.out.println("histories [] :: " + Arrays.toString(histories));
                    }
                    for (String historiesElement : histories) {
                        System.out.println("historiesElement :: " + historiesElement);
                        Product product = productService.getProduct(Integer.parseInt(historiesElement));


                        products.add(product);
                    }//FOR
                }//IF
            }//FOR
        }//IF

        System.out.println(products.toString());

        System.out.println("::: "+GREEN+"CookieController :: createHistory() end"+RESET);

        return new ModelAndView(
                "forward:/history.jsp",
                Collections.singletonMap("products", products));
    }

    @RequestMapping("/removeHistory")
    public ModelAndView removeHistory(@RequestParam("navigationPage") String navigationPage,
                                      HttpServletRequest request,
                                      HttpServletResponse response) throws Exception{

        System.out.println("removeHistory가 시작됩니다.");
        Cookie clientCookies[] = request.getCookies();

        if (clientCookies != null) {
            for (Cookie cookie : clientCookies) {
                System.out.println(cookie.getName());
                // 삭제하고자 하는 쿠키를 찾습니다.
                if ("history".equals(cookie.getName())) {
                    System.out.println("history쿠키가 있습니다. 삭제합니다.");
                    // 해당 쿠키의 유효 기간을 0으로 설정합니다.
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    // 수정된 쿠키를 클라이언트에게 전송하여 삭제하도록 합니다.
                    response.addCookie(cookie);
                }//if
            }//for
        }//if
        if(navigationPage.equals("history.jsp")) {
            return new ModelAndView("redirect:/history.jsp");
        }

        return null;
    }

    @RequestMapping("removeLike")
    public ModelAndView removeLike(@RequestParam("count") String count,
                                   @RequestParam("navigationPage") String navigationPage,
                                   @RequestParam("prodNo") String prodNo,
                                   HttpServletRequest request,
                                   HttpServletResponse response) throws Exception {
        Cookie clientCookies[] = request.getCookies();

        String like = null;
        String[] likes = null;
        String newLike = null;
        List<String> newLikes = new ArrayList<String>();
        //쿠키를 하나만 삭제
        if (clientCookies != null) {
            if (count.equals("one")) {

                for (Cookie cookie : clientCookies) {
                    if ("like".equals(cookie.getName())) {
                        like = cookie.getValue();
                        //이 밸류를 ;로 파싱한다.
                        if (like != null) {
                            likes = like.split("%3B");
                            System.out.println("likes ::: " + Arrays.toString(likes));
                        }//IF
                        //likes리스트를 만들어냈다. 그 중에 prodNo와 같은거 찾아서 삭제하면 댐
                        for (String likesElement : likes) {
                            if (!likesElement.equals(prodNo)) {
                                newLikes.add(likesElement);
                            }
                        }
                        //쿠키 가져와서 삭제버튼누른거 쏙 빼고 다시 쿠키 덮어쓰기.
                        System.out.println(newLikes);
                        newLike = String.join(";", newLikes);
                        System.out.println("newLike" + newLike);
                        Cookie newCookie = new Cookie("like", URLEncoder.encode(newLike, "EUC-KR"));
                        cookie.setPath("/");
                        response.addCookie(newCookie);
                    }//IF
                }//FOR

            } else {

                for (Cookie cookie : clientCookies) {
                    // 삭제하고자 하는 쿠키를 찾습니다.
                    if ("like".equals(cookie.getName())) {
                        // 해당 쿠키의 유효 기간을 0으로 설정합니다.
                        System.out.println("쿠키의 값 : " + cookie.getValue());
                        cookie.setMaxAge(0);
                        cookie.setPath("/");
                        // 수정된 쿠키를 클라이언트에게 전송하여 삭제하도록 합니다.
                        response.addCookie(cookie);
                    }//if
                }//for

            }//else

        }//if

        Map<String,Object> model = new HashMap<>();
        model.put("menu","search");
        model.put("from",navigationPage);
//		if(navigationPage.equals("createLike.do")) {
        return new ModelAndView("redirect:/cookie/createLike",
                model);
//    }//end of if
    }//end of removeLike

    @RequestMapping("createLike")
    public ModelAndView createLike(@RequestParam("menu") String menu,
                                   @RequestParam(value= "from",required = false) String from,
                                   @RequestParam(value="currentPage",required = false) String currentPage,
                                   HttpServletRequest request) throws Exception {
        //얘는 왜있나 할 수 있는데, 얘는 쿠키를 Product로 만드는 놈이다.
        //CreateHisotry도 쿠키를 Product로 만드는 놈이다.
        //LikeProduct에다가 여기있는 로직을 다 넣으면 일관성이 떨어질 것 같았다.
        System.out.println("/createLike 시작!!!!");

        if(currentPage==null){
            currentPage="1";
        }

        Cookie[] cookies = request.getCookies();

        System.out.println("1");
        String like = null;
        ArrayList<Product> products = new ArrayList<Product>();

        System.out.println("2");
        //쿠키 있으면 쿠키이름이 like면 스콥에 담아. like=10000;10000;10001;
        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                System.out.println("쿠키이름"+cookie.getName());
                if (cookie.getName().equals("like")) {
                    System.out.println("쿠키를 디코딩합니다.");
                    like = URLDecoder.decode(cookie.getValue(), "EUC-KR");
                    System.out.println("쿠키밸류 "+like);
                    String[] likes = null;

                    if (like != null) {
                        likes = like.split(";");

                        for (String likesElement : likes) {
                            if (!likesElement.equals("")) {
                                Product product = productService.getProduct(Integer.parseInt(likesElement));
                                products.add(product);
                            } // IF
                        } // FOR

                    }//IF
                }//If
                System.out.println("like가 없습니다");
            }//FOR
        }//IF
//		String[] likes = null;
//		//히스토리 있으면 파싱해서 리스트로 만들어 스콥에 담아.
//		if (like != null) {
//			likes = like.split(";");
//		}

        System.out.println("3");
        if(!products.isEmpty()) {
            request.setAttribute("products", products);
        }
        System.out.println("products가 비었습니다." + products);
        System.out.println("4");


        Map<String,Object> model = new HashMap<String,Object>();
        model.put("menu",menu);
        model.put("currentPage",currentPage);
        System.out.println("5");
        System.out.println("model"+model);
//		from = "SetLikeProduct.do"
        if(from!=null) {
            if(from.equals("setLikeProduct")) {
                return new ModelAndView("forward:/product/listProduct",model);
            }else {
//		from = "removeLike.do"
                return new ModelAndView("forward:/product/likeProduct", model);
            }//else
        }//if
        System.out.println("6");
        return new ModelAndView("forward:/product/likeProduct", model);
    }//end of createLike

}
