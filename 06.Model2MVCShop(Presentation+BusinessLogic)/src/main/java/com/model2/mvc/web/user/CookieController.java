package com.model2.mvc.web.user;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller
public class CookieController {

    ///Field
    private ProductService productService;
    private static final String RESET = "\u001B[0m";
    private static final String RED = "\u001B[91m";
    private static final String ORANGE = "\u001B[38;5;208m";
    private static final String YELLOW = "\u001B[93m";
    private static final String GREEN = "\u001B[92m";
    private static final String BLUE = "\u001B[94m";

    public void setProductService(@Qualifier("productServiceImpl") ProductService productService){
        this.productService = productService;
    }

    ///Constructor

    public CookieController(){
        System.out.println("\n 생성자 :: "+this.getClass()+"\n");
    }

    ///Method
    @RequestMapping("/createHistory.do")
    public ModelAndView createHistory(HttpServletRequest request,
                                      HttpServletResponse response) throws Exception {
        System.out.println("/createHistory.do");
        System.out.println("::: "+GREEN+"CookieController :: createHistory() start"+RESET);

        Cookie[] cookies = request.getCookies();

        String history = null;//히스토리는 prodNo임 지금

        List<Product> products = new ArrayList<Product>();

        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                if (cookie.getName().equals("history")) {
                    history = URLDecoder.decode(cookie.getValue(), "EUC-KR");
                    String[] histories = null;
                    if (history != null) {
                        histories = history.split(";");
                    }
                    for (String historiesElement : histories) {
                        Product product = productService.getProduct(Integer.parseInt(historiesElement));
                        products.add(product);
                    }//FOR
                }//IF
            }//FOR
        }//IF

        System.out.println("::: "+GREEN+"CookieController :: createHistory() end"+RESET);

        return new ModelAndView(
                "forward:/history.jsp",
                Collections.singletonMap("products", products));
    }

//    @RequestMapping("/RemoveHistory.do")
//    public ModelAndView removeHistory

}
