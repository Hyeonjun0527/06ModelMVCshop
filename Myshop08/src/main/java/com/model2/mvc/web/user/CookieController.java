package com.model2.mvc.web.user;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
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
        System.out.println("\n ������ :: "+this.getClass()+"\n");
    }

    ///Method
    @RequestMapping("createHistory")
    public ModelAndView createHistory(HttpServletRequest request,
                                      HttpServletResponse response) throws Exception {
        System.out.println("/createHistory");
        System.out.println("::: "+GREEN+"CookieController :: createHistory() start"+RESET);

        Cookie[] cookies = request.getCookies();

        String history = null;//�����丮�� prodNo�� ����

        ArrayList<Product> products = new ArrayList<Product>();

        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                if (cookie.getName().equals("history")) {
                    System.out.println("��Ű���� history�� ��Ű�� ã�ҽ��ϴ�.");
                    System.out.println("��Ű��1::"+cookie.getValue());
                    System.out.println("���ڵ��� ��Ű��1:: " + URLDecoder.decode(cookie.getValue(), "EUC-KR"));
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

    @RequestMapping("removeHistory")
    public ModelAndView removeHistory(@RequestParam("navigationPage") String navigationPage,
                                      HttpServletRequest request,
                                      HttpServletResponse response) throws Exception{

        System.out.println("removeHistory�� ���۵˴ϴ�.");
        Cookie clientCookies[] = request.getCookies();

        if (clientCookies != null) {
            for (Cookie cookie : clientCookies) {
                System.out.println(cookie.getName());
                // �����ϰ��� �ϴ� ��Ű�� ã���ϴ�.
                if ("history".equals(cookie.getName())) {
                    System.out.println("history��Ű�� �ֽ��ϴ�. �����մϴ�.");
                    // �ش� ��Ű�� ��ȿ �Ⱓ�� 0���� �����մϴ�.
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    // ������ ��Ű�� Ŭ���̾�Ʈ���� �����Ͽ� �����ϵ��� �մϴ�.
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
    public String removeLike(@RequestParam("count") String count,
                                   @RequestParam(value="prodNo", required= false) String prodNo,
                                   HttpServletRequest request,
                                   HttpServletResponse response) throws Exception {
        System.out.println("[[[removeLike ����]]]");
        Cookie clientCookies[] = request.getCookies();

        String like = null;
        String[] likes = null;
        String newLike = null;
        List<String> newLikes = new ArrayList<String>();
        if (clientCookies != null) {
            //��Ű�� �ϳ��� ����
            if (count.equals("one")) {
                System.out.println("���� �ϳ��� �����մϴ�");
                for (Cookie cookie : clientCookies) {
                    System.out.println("@@@@@@@@@@@@cookie ::: " + cookie.getName());

                    if ("like".equals(cookie.getName())) {
                        like = URLDecoder.decode(cookie.getValue(),"EUC-KR");
                        if(like.startsWith(";")){
                            like = like.substring(1);
                        }
                        //�� ����� ;�� �Ľ��Ѵ�.
                        if (like != null) {
                            System.out.println("like ::: " + like);
                            likes = like.split(";");
                            System.out.println("likes ::: " + Arrays.toString(likes));
                        }//IF
                        //likes����Ʈ�� �����´�. �� �߿� prodNo�� ������ ã�Ƽ� �����ϸ� ��.
                        for (String likesElement : likes) {
                            if (!likesElement.equals(prodNo)&& !likesElement.isEmpty()) {
                                System.out.print("  ::  "+likesElement);
                                newLikes.add(likesElement);
                            }
                            System.out.println();
                        }
                        //��Ű �����ͼ� ������ư������ �� ���� �ٽ� ��Ű �����.
                        System.out.println("newLikes :: "+newLikes);
                        newLike = String.join(";", newLikes);
                        System.out.println("newLike :: " + newLike);
                        Cookie newCookie = new Cookie("like", URLEncoder.encode(newLike, "EUC-KR"));
                        newCookie.setPath("/");
                        response.addCookie(newCookie);
                    }//IF

                }//FOR
            //��Ű�� ���� ����
            } else {
                System.out.println("���� ���� �����մϴ�");
                for (Cookie cookie : clientCookies) {
                    // �����ϰ��� �ϴ� ��Ű�� ã���ϴ�.
                    System.out.println("��Ű�� ���� ::" +cookie.getName());
                    System.out.println("��Ű �н� :: " +cookie.getPath() );
                    System.out.println("��Ű ������ :: " + cookie.getDomain());
                    if ("like".equals(cookie.getName())) {
                        // �ش� ��Ű�� ��ȿ �Ⱓ�� 0���� �����մϴ�.
                        System.out.println("��Ű�� �� : " + cookie.getValue());
                        cookie.setPath("/");
                        cookie.setMaxAge(0);
                        // ������ ��Ű�� Ŭ���̾�Ʈ���� �����Ͽ� �����ϵ��� �մϴ�.
                        response.addCookie(cookie);
                    }//if
                }//for

                for(Cookie cookie : clientCookies){
                    System.out.println("��Ű �� ����?�� �ٽ� ���� :: " + cookie.getName());
                }

            }//else

        }//if

//		if(navigationPage.equals("createLike.do")) {??? �� �ּ��� ���� �ʹ�. �̻��ϴ�.
        //left.jsp�� �ϴ� �Ͱ� ���� URL�� �̵��Ѵ�.
        return "redirect:/cookie/createLike?menu=search&from=removeLike";
//        return null;
//    }//end of if
    }//end of removeLike

    @RequestMapping("createLike")
    public String createLike(
                             HttpServletRequest request) throws Exception {
        //��� ���ֳ� �� �� �ִµ�, ��� ��Ű�� Product�� ����� ���̴�.
        //CreateHisotry�� ��Ű�� Product�� ����� ���̴�.
        //LikeProduct���ٰ� �����ִ� ������ �� ������ �ϰ����� ������ �� ���Ҵ�.
        //currentPage�� �������ٲٴ� ����������,
        System.out.println("[[[createLike ����]]]");
        String from = request.getParameter("from");
        String menu = request.getParameter("menu");


//        if(currentPage==null){
//            currentPage="1";
//        }

        Cookie[] cookies = request.getCookies();

        String like = null;
        List<Product> products = new ArrayList<Product>();

            //��Ű ������ ��Ű�̸��� like��, ��Ű����� ������ products�� �����. like=10000;10000;10001;
            if ( cookies != null && cookies.length > 0) {
                for (int i = 0; i < cookies.length; i++) {
                    Cookie cookie = cookies[i];
                    System.out.println("��Ű�̸�" + cookie.getName());
                    if (cookie.getName().equals("like")) {
                        System.out.println("��Ű�� ���ڵ��մϴ�.");
                        like = URLDecoder.decode(cookie.getValue(), "EUC-KR");
                        System.out.println("��Ű��� " + like);
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
                }//FOR
            }//IF
//		String[] likes = null;
//		//�����丮 ������ �Ľ��ؼ� ����Ʈ�� ����� ���߿� ���.
//		if (like != null) {
//			likes = like.split(";");
//		}

        Map<String,Object> createLikeData = new HashMap<String,Object>();


        if(!products.isEmpty()) {
            createLikeData.put("products", products);
        }
        System.out.println("products : " + products);
        System.out.println("createLikeData" + createLikeData);
        System.out.println("[[[createLike ��]]]");

        //likeProduct�� ������.
        request.setAttribute("createLikeData", createLikeData);

        if (from.equals("removeLike")) {
            return "forward:/product/likeProduct";
        } else {
            //from = left.jsp
            return "forward:/product/likeProduct";
        }
    }//end of createLike

}
