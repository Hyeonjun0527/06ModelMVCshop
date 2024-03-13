package com.model2.mvc.web.user;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CookieUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

@Controller
public class ProductController {
    ///Field
    private ProductService productService;
    private static final String RESET = "\u001B[0m";
    private static final String RED = "\u001B[91m";
    private static final String ORANGE = "\u001B[38;5;208m";
    private static final String YELLOW = "\u001B[93m";
    private static final String GREEN = "\u001B[92m";
    private static final String BLUE = "\u001B[94m";

    @Autowired
    public void setProductService(@Qualifier("productServiceImpl") ProductService productService) {
        this.productService = productService;
    }

    @Value("#{commonProperties['pageUnit']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("#{commonProperties['pageSize']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;

    ///Constructor
    public ProductController() {
        System.out.println(YELLOW);
        System.out.println("생성자 :: " + this.getClass());
    }

    ///Method
    @RequestMapping("/addProduct.do")
    public String addProduct(@ModelAttribute("product") Product product) throws Exception {

        System.out.println("/addProduct.do이 시작됩니다..");
        //원래 이렇게 a넣으면 안될거 같은데..?
        product.setProTranCode("a");
        //Business Logic
        productService.addProduct(product);
        //Model 과 View 연결 - 이 부분은 @RequestParam + Model 전략을 쓰면 해야됨
        //model.addAttribute("product", product);
        System.out.println("/addProduct.do이 끝났습니다..");
        System.out.println("forward:/product/addProductView.jsp" + "합니다.");
        return "forward:/product/addProductView.jsp";
    }//end of addProduct

    @RequestMapping("/getProduct.do")
    public String getProduct(HttpServletRequest request,
                             HttpServletResponse response,
                             @ModelAttribute("product") Product product,
                             @RequestParam("menu") String menu,
                             Model model) throws Exception {

        System.out.println("/getProduct.do이 시작됩니다..");
        //Business Logic
        product = productService.getProduct(product.getProdNo());
        //Model 과 View 연결
        //도메인를 메서드내에서 재할당해버린 경우에는 model.addAttribute를 써야한다.
        model.addAttribute("menu", menu);
        model.addAttribute("product", product);

        CookieUtil.addValue(request, response, "history", String.valueOf(product.getProdNo()));

        System.out.println("/getProduct.do이 끝났습니다..");

        if (menu.equals("manage")) {
            System.out.println("forward:/updateProductView.jsp" + "합니다.");
            return "forward:/product/updateProductView.jsp";
        } else {//search, ok
            return "forward:/product/getProduct.jsp";
        }//end of else
    }//end of getProduct

    //클라-searchBoundFirst,searchBoundEnd,currentPage,search,menu,products,page
    //currentPage의
    @RequestMapping("/likeProduct.do")
    public String likeProduct(@ModelAttribute("products") List<Product> products,
                              @ModelAttribute("search") Search search,
                              @RequestParam(value = "searchBoundFirst", required = false) Integer searchBoundFirst,
                              @RequestParam(value = "searchBoundEnd", required = false) Integer searchBoundEnd,
                              @RequestParam("menu") String menu,
                              Model model) throws Exception {
        System.out.println("/likeProduct.do이 시작됩니다..");

        //바인딩 : 클라-searchBoundFirst, searchBoundEnd > search도메인

        if(searchBoundFirst == null || searchBoundEnd == null) {
            searchBoundFirst = 0;
            searchBoundEnd = 0;
        }
        //바인딩 : 클라-searchBoundFirst, searchBoundEnd > search도메인
        if (!(searchBoundFirst == 0) || !(searchBoundEnd == 0)) {
            search.setSearchBoundFirst(searchBoundFirst);
            search.setSearchBoundEnd(searchBoundEnd);
//                System.out.println("searchBound[0]"+searchBound[0]);
//                System.out.println("searchBound[1]"+searchBound[1]);
        }

        //바인딩 : 클라-currentPage > search도메인 > page도메인
        int currentPage = 1;
        //경로 1,2,3,4로 들어왔을경우
        if (search.getCurrentPage() != 0) {
            currentPage = search.getCurrentPage();
        }

        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);

        Page page = new Page(
                currentPage,
                products.size(),
                pageUnit,
                pageSize);

        System.out.println("ListProductAction ::" + page);
        System.out.println("products :: " + products);

        //Model 과 View 연결
        model.addAttribute("totalCount", products.size());
//        model.addAttribute("products",products);
//        model.addAttribute("search",search);
        model.addAttribute("resultPage", page);
        model.addAttribute("menu", menu);

        System.out.println("/likeProduct.do이 끝났습니다..");

        //네비게이션
        if (menu != null) {
            return "forward:/product/likeProduct.jsp";
        } else {
            System.out.println("forward:/product/getProduct.jsp" + "합니다.");
            return "forward:/product/getProduct.jsp";
        }//end of else
    }//end of likeProduct

    //클라-searchBoundFirst,searchBoundEnd,search,menu,products,page
    @RequestMapping("/listProduct.do")
    public String listProduct(@ModelAttribute(value = "search") Search search,
                              @RequestParam(value = "searchBoundFirst", required = false) Integer searchBoundFirst,
                              @RequestParam(value = "searchBoundEnd", required = false) Integer searchBoundEnd,
                              @RequestParam(value = "menu", required = false) String menu,
                              Model model) throws Exception {
        System.out.println("/listProduct.do이 시작됩니다..");
        System.out.println("searchBound :: " + searchBoundFirst + " " + searchBoundEnd);
        System.out.println("searchType :: "+ search.getSearchType());
//        if(search.getSearchType() == null) {
//            search.setSearchType("1");
//        }

        if(searchBoundFirst ==null && searchBoundEnd == null) {
        searchBoundFirst = 0;
        searchBoundEnd = 0;
        }
        //바인딩 : 클라-searchBoundFirst, searchBoundEnd > search도메인
        if (!(searchBoundFirst == 0) || !(searchBoundEnd == 0)) {
            search.setSearchBoundFirst(searchBoundFirst);
            search.setSearchBoundEnd(searchBoundEnd);
//                System.out.println("searchBound[0]"+searchBound[0]);
//                System.out.println("searchBound[1]"+searchBound[1]);
        }


        //바인딩 : 클라-currentPage > search도메인 > page도메인
        int currentPage = 1;
        //경로 1,2,3,4로 들어왔을경우
        if (search.getCurrentPage() != 0) {
            currentPage = search.getCurrentPage();
        }

        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);

        Map<String, Object> productMap = productService.getProductList(search);//Like와 다른 부분

        Page page = new Page(
                currentPage,
                (Integer) productMap.get("totalCount"),
                pageUnit,
                pageSize);

        System.out.println("ListProductAction ::" + page);
        System.out.println("products :: " + productMap.get("list"));
        System.out.println("search :: " + search);

        //Model 과 View 연결
        //model.addAttribute("products", products);
        //model.addAttribute("search", search);
        model.addAttribute("totalCount", productMap.get("totalCount"));
        model.addAttribute("list", productMap.get("list"));
        model.addAttribute("resultPage", page);
        model.addAttribute("menu", menu);

        System.out.println("/listProduct.do이 끝났습니다..");

        //네비게이션
        if (menu != null) {
            System.out.println("forward:/product/listProduct.jsp" + "합니다.");
            return "forward:/product/listProduct.jsp";
        } else {
            System.out.println("forward:/product/getProduct.jsp" + "합니다.");
            return "forward:/product/getProduct.jsp";
        }//end of else
    }//end of listProduct

    //prodNo,menu,currentPage,
    @RequestMapping("/setLikeProduct.do")
    public String SetLikeProduct(HttpServletRequest request,
                                 HttpServletResponse response,
                                 @RequestParam("prodNo") int prodNo,
                                 @RequestParam("menu") String menu,
                                 @RequestParam("currentPage") int currentPage,
                                 @CookieValue(name = "like", required = false) String likeCookie,
                                 Model model) throws Exception {
        System.out.println("/SetLikeProduct.do이 시작됩니다..");


        //Business Logic
        Product product = productService.getProduct(prodNo);


        //쿠키있으면 쿠키이름이 like면
        String[] likeCookies = null;

        if (likeCookie != null) {
            likeCookies = likeCookie.split(";");
        } // IF

        boolean result = true;

        for (String element : likeCookies) {
            if (element.equals(String.valueOf(product.getProdNo()))) {
                result = false;
            } // IF
        } // FOR

        if (result) {
            CookieUtil.addValue(request, response, "like", String.valueOf(product.getProdNo()));
        }

        model.addAttribute(product);
        model.addAttribute("menu", menu);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("from", "setLikeProduct.do");

        System.out.println("/SetLikeProduct.do이 끝났습니다..");
        System.out.println("forward:/createLike.do" + "합니다.");
        return "forward:/createLike.do";
    }//end of SetLikeProduct

    @RequestMapping("/updateProduct.do")
    public String updateProduct(@ModelAttribute("product") Product product,
                                Model model) throws Exception {

        System.out.println("/updateProduct.do 이 시작됩니다.");
        //Business Logic
        product = productService.getProduct(product.getProdNo());

        product.setManuDate(product.getManuDate().replaceAll("-", ""));

        System.out.println("업데이트 완료 :: " + productService.updateProduct(product));

        //Model 과 View 연결
        model.addAttribute("product", product);

        System.out.println("/updateProduct.do 이 끝났습니다.");
        System.out.println("redirect:/getProduct.do" + "합니다.");
        return "redirect:/getProduct.do?prodNo=" + product.getProdNo() + "&menu=ok";
    }//end of updateProduct

    //prodNo,
    @RequestMapping("/updateProductView.do")
    public String updateProductView(@ModelAttribute Product product,
                                    Model model) throws Exception {

        System.out.println("/updateProductView.do" + "이 시작됩니다..");
        product = productService.getProduct(product.getProdNo());

        // Model 과 View 연결
        model.addAttribute("product", product);

        System.out.println("/updateProductView.do" + "이 끝났습니다.");
        System.out.println("forward:/product/updateProduct.jsp" + "합니다.");
        return "forward:/product/updateProduct.jsp";
    }

}
