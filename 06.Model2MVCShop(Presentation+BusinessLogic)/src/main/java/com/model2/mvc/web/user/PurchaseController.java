package com.model2.mvc.web.user;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import java.util.*;

@Controller
public class PurchaseController {

    ///Field
    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;
    @Autowired
    @Qualifier("productServiceImpl")
    private ProductService productService;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    private static final String RESET = "\u001B[0m";
    private static final String RED = "\u001B[91m";
    private static final String ORANGE = "\u001B[38;5;208m";
    private static final String YELLOW = "\u001B[93m";
    private static final String GREEN = "\u001B[92m";
    private static final String BLUE = "\u001B[94m";

    @Autowired
    public void setPurchaseService(@Qualifier("purchaseServiceImpl") PurchaseService purchaseService) {
        this.purchaseService = purchaseService;
    }

    @Value("#{commonProperties['pageUnit']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("#{commonProperties['pageSize']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;

    ///Constructor
    public PurchaseController() {
        System.out.println(BLUE);
        System.out.println("\n ������ :: "+this.getClass()+"\n");
    }

    ///Method
    @RequestMapping("/addPurchase.do")
    public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase,
                                    @RequestParam("prodNo") int prodNo,
                                    HttpSession session) throws Exception {
        System.out.println("/addPurchase.do");
        System.out.println("purchase�� ::"+purchase);

        User user = (User)session.getAttribute("user");

        System.out.println("prodNO�� :: "+prodNo);
        Product product = productService.getProduct(prodNo);
        System.out.println("Product�� :: "+product);
        purchase.setBuyer(user);
        purchase.setPurchaseProd(product);
        purchase.setTranCode("b");


        purchaseService.addPurchase(purchase);

        return new ModelAndView(
                "forward:/purchase/getPurchase.jsp"
                , Collections.singletonMap("purchase", purchase));

    }
    @RequestMapping("/addPurchaseView.do")
    public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo) throws Exception {
        System.out.println("/addPurchaseView.do");

        Map<String, Object> model = new HashMap<>();
        model.put("product", productService.getProduct(prodNo));

        return new ModelAndView(
                "forward:/purchase/addPurchaseView.jsp",
                model);
    }

    @RequestMapping("/getPurchase.do")
    public ModelAndView getPurchase(@RequestParam("tranNo") int tranNo,
                                    @RequestParam("menu") String menu) throws Exception {
        System.out.println("/getPurchase.do");

        Purchase purchase = purchaseService.getPurchase(tranNo);

        Map<String,Object> model = new HashMap<>();
        model.put("purchase", purchase);
        model.put("menu", menu);

        String viewName = "forward:/purchase/getPurchase.jsp";
        if(menu.equals("ok")){
            viewName = "forward:/purchase/getPurchase.jsp";
        }else{
            viewName = "forward:/updatePurchaseView.do";

        }
        return new ModelAndView(viewName, model);
    }
    @RequestMapping("/listPurchase.do")
    public ModelAndView listPurchase(HttpSession session,
                                     @ModelAttribute("search") Search search,
                                     @ModelAttribute("purchase") Purchase purchase,
                                     @RequestParam("menu") String menu
                                     ) throws Exception {
        System.out.println("/listPurchase.do �����մϴ�...");
        User user = (User) session.getAttribute("user");


        int currentPage = 1;

        if(search.getCurrentPage() != 0){
            currentPage = search.getCurrentPage();
        }

        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);
        System.out.println("search.getStartRowNum()::"+search.getStartRowNum());
        System.out.println("search.getEndRowNum()::"+search.getEndRowNum());
        System.out.println("���⼭ search�� "+search);
        Map<String,Object> map = new HashMap<>();
        map.put("search", search);
        map.put("user", user);

        System.out.println("ListPurchaseAction ::"+map);

        map = purchaseService.getPurchaseList(map);

        System.out.println("map�� :: " + map);

        //null�� �ƴϵ��� ��ġ
        if(map == null){
            map = new HashMap<String, Object>();
                map.put("count", 0);
                map.put("purchase", new Purchase());
        }

        int totalCount = map.get("count") != null ? (Integer)map.get("count") : 0;
        List<Purchase> purchaseList = (List<Purchase>)map.get("list");

        Page resultPage	=
                new Page( currentPage, totalCount, pageUnit, pageSize);
        System.out.println("ListPurchaseAction ::"+resultPage);

        //������
        if(user.getRole().equals("user")){
            System.out.println("ListPurchaseAction :: ����");
        }else{
            System.out.println("ListPurchaseAction :: ������");
            map = purchaseService.getSaleList(search);
        }

        Map<String,Object> model = new HashMap<>();
        model.put("totalCount",totalCount);
        model.put("list", purchaseList);
        model.put("resultPage", resultPage);
        //model.put("search", search);

        System.out.println("listPurchase.do :: �� �������ϴ�..");

        return new ModelAndView(
                "forward:/purchase/listPurchase.jsp",
                model);
    }

    @RequestMapping("/updatePurchase.do")
    public ModelAndView updatePurchase(@RequestParam("tranNo") int tranNo,
                                       @RequestParam("prodNo") int prodNo,
                                       @ModelAttribute("purchase") Purchase lastPurchase) throws Exception {
        System.out.println("/updatePurchase.do�� ���۵˴ϴ�...");

        Purchase purchase = purchaseService.getPurchase(tranNo);

        //TranCode,product,user�� ��ġ�� �ʾƵ� �ȴ�. ��񿡼� �״�� �����ͼ�
        purchase.setPaymentOption(lastPurchase.getPaymentOption());
        purchase.setReceiverName(lastPurchase.getReceiverName());
        purchase.setReceiverPhone(lastPurchase.getReceiverPhone());
        purchase.setDivyAddr(lastPurchase.getDivyAddr());
        purchase.setDivyRequest(lastPurchase.getDivyRequest());
        purchase.setDivyDate(lastPurchase.getDivyDate());

        purchase = purchaseService.updatePurchase(purchase);
        System.out.println("������Ʈ �Ϸ� :: " + purchase);

        System.out.println("/updatePurchase.do�� �������ϴ�...");

        Map<String,Object> map = new HashMap<>();
        map.put("purchase", purchase);
        map.put("menu", "ok");
        map.put("tranNo", tranNo);


        return new ModelAndView(
                "redirect:/getPurchase.do",
                map);

    }
    @RequestMapping("/updatePurchaseView.do")
    public ModelAndView updatePurchaseView(@ModelAttribute("purchase") Purchase purchase,
                                           @RequestParam("menu") String menu) throws Exception {
        System.out.println("/updatePurchaseView.do�� ���۵˴ϴ�...");


        System.out.println("updatePurchaseView.do�� �������ϴ�...");
        return new ModelAndView(
                "forward:/product/updateProduct.jsp",
                Collections.singletonMap("purchase", purchase));
    }
    @RequestMapping("/updateTranCode.do")
    public ModelAndView updateTranCode(@RequestParam("prodNo") int prodNo,
                                       @RequestParam("navigationPage") String navigationPage,
                                       @RequestParam("menu") String menu) throws Exception {
        System.out.println("/updateTranCode.do�� ���۵˴ϴ�...");

        Purchase purchase = purchaseService.getPurchase(prodNo);
        System.out.println("updateTranCode.do :: ���⼭ " + purchase);

        if (CommonUtil.null2str(purchase.getTranCode()).equals("b")) {
            System.out.println("b�����");
            purchase.setTranCode("c");

        } else if (purchase.getTranCode().trim().equals("c")) {
            System.out.println("c�����");
            purchase.setTranCode("d");
        }

        purchaseService.updateTranCode(purchase);

        String viewName = "";
        Map<String,Object> map = new HashMap<>();
        map.put("menu", menu);

        System.out.println("updateTranCode.do�� �������ϴ�...");

        if(navigationPage.equals("listProduct.do")) {
            if(menu.equals("manage")) {
                System.out.println( "redirect:/listProduct.do?menu=manage"+"�մϴ�.");
                viewName = "redirect:/listProduct.do?menu=manage";
            }
        }else if(navigationPage.equals("listPurchase.do")){

            if(menu.equals("search")) {
                System.out.println("redirect:/listPurchase.do?menu=search"+"�մϴ�.");
                viewName =  "redirect:/listPurchase.do?menu=search";
            }
        }else {

        }

        return new ModelAndView(viewName, map);

    }


}
