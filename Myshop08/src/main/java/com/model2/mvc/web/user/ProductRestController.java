package com.model2.mvc.web.user;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CookieUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;

@RestController
@RequestMapping("/product/json/*")
public class ProductRestController {
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
    public ProductRestController() {
        System.out.println(YELLOW);
        System.out.println("������ :: " + this.getClass());
        System.out.println(RESET);
    }

    ///Method
    @PostMapping("addProduct")
    public ResponseEntity<?> addProduct(@RequestParam("files") List<MultipartFile> fileList,
                             @ModelAttribute("product") Product product) throws Exception {
        System.out.println("/addProduct�� ���۵˴ϴ�..");

        if (fileList.isEmpty()) {
            return ResponseEntity.badRequest().body("Please select a file to upload");
        }
        //��Ʈ������ �ٲٰ� ����Ʈ�� �����ؾ���

        List<String> fileNameList = new ArrayList<>();

        for (MultipartFile multipartFile : fileList) {
            fileNameList.add(getProductFileName(multipartFile));
        }
        System.out.println("fileName :: "+fileNameList.toString());
        String fileNames = String.join(",",fileNameList);

        //���� �̷��� a������ �ȵɰ� ������..?
        product.setProTranCode("a");
        product.setFileName(fileNames);
        //Business Logic
        System.out.println("�翬�� prodNo 0�̴�. product :: " + product);
        productService.addProduct(product);
        //Model �� View ���� - �� �κ��� @RequestParam + Model ������ ���� �ؾߵ�
        //model.addAttribute("product", product);
        System.out.println("/addProduct�� �������ϴ�..");
        return ResponseEntity.status(HttpStatus.OK).body(product);
        
    }//end of addProduct
    @PostMapping("getProduct")
    public ResponseEntity<?> getProduct(HttpServletRequest request,
                             HttpServletResponse response,
                             @RequestBody Product product,
                             @RequestParam("menu") String menu) throws Exception {

        System.out.println("/getProduct�� ���۵˴ϴ�..");
        //Business Logic
        product = productService.getProduct(product.getProdNo());
        //Model �� View ����
        // �޼��峻���� ���������� �������� ���Ҵ��ع��� ��쿡��
        // ModelAttribute�� �ν��� ���� ���Ѵ�.
        List<String> fileNames = Arrays.asList(product.getFileName().split(","));//1234,1234,1,

        System.out.println(fileNames.toString());


        Map<String,Object> map = new HashMap<>();
        map.put("menu", menu);
        map.put("product", product);
        map.put("fileNames", fileNames);


        CookieUtil.addValue(request, response, "history", String.valueOf(product.getProdNo()));

        System.out.println("/getProduct�� �������ϴ�..");

        if (menu.equals("manage")) {
            System.out.println("forward:/updateProduct.jsp" + "�մϴ�.");
            map.put("navigation","forward:/product/updateProduct.jsp");
        } else {//search, ok
            map.put("navigation","forward:/product/getProduct.jsp");
        }//end of else
        return ResponseEntity.status(HttpStatus.OK).body(map);
    }//end of getProduct

    //Ŭ��-searchBoundFirst,searchBoundEnd,currentPage,search,menu,products,page
    //currentPage��
    @PostMapping("likeProduct")
    public ResponseEntity<?> likeProduct(@ModelAttribute("search") Search search,
                              @RequestParam(value = "menu",required = false) String menu,
                              @RequestParam(value = "searchBoundFirst", required = false) Integer searchBoundFirst,
                              @RequestParam(value = "searchBoundEnd", required = false) Integer searchBoundEnd,
                              HttpServletRequest request) throws Exception {
        //search,searchBoundFirst,End�� ������ �ȿ��� ������ �̵��Ҷ��� �����.


        //@ModelAttribute("products") ArrayList<Product> products

        System.out.println("/likeProduct�� ���۵˴ϴ�..");
        //���ε� : Ŭ��-searchBoundFirst, searchBoundEnd > search������

        if(searchBoundFirst == null || searchBoundEnd == null) {
            searchBoundFirst = 0;
            searchBoundEnd = 0;
        }
        //���ε� : Ŭ��-searchBoundFirst, searchBoundEnd > search������
        if (!(searchBoundFirst == 0) || !(searchBoundEnd == 0)) {
            search.setSearchBoundFirst(searchBoundFirst);
            search.setSearchBoundEnd(searchBoundEnd);
//                System.out.println("searchBound[0]"+searchBound[0]);
//                System.out.println("searchBound[1]"+searchBound[1]);
        }

        //���ε� : Ŭ��-currentPage > search������ > page������
        int currentPage = 1;
        //��� 1,2,3,4�� ���������
        if (search.getCurrentPage() != 0) {
            currentPage = search.getCurrentPage();
        }

        search.setCurrentPage(currentPage);//current�� default Value�� 1�� ��������.
        search.setPageSize(pageSize);

        //createLike���� ������
        Map<String,Object> createLikeData = (Map<String, Object>)request.getAttribute("createLikeData");

        //menu,currentPage,products
        List<Product> products =(List<Product>)(createLikeData.get("products"));

        int productsSize = products != null ? products.size() : 0;

        Page page = new Page(
                currentPage,
                productsSize,
                pageUnit,
                pageSize);

        System.out.println("ListProductAction ::" + page);
        System.out.println("products :: " + products);

        //Model �� View ����

        Map<String,Object> map = new HashMap<>();

        map.put("totalCount", productsSize);
        map.put("products",products);
        map.put("search",search);
        map.put("resultPage", page);
        map.put("menu", menu);

        System.out.println("/likeProduct�� �������ϴ�..");

        //�׺���̼�
        if (menu != null) {
            map.put("navigation","forward:/product/likeProduct.jsp");
        } else {
            System.out.println("forward:/product/getProduct.jsp" + "�մϴ�.");
            map.put("navigation","forward:/product/getProduct.jsp");
        }//end of else

        return ResponseEntity.status(HttpStatus.OK).body(map);
    }//end of likeProduct

    //Ŭ��-searchBoundFirst,searchBoundEnd,search,menu,products,page
    @RequestMapping("/listProduct")
    public String listProduct(@ModelAttribute(value = "search") Search search,
                              @RequestParam(value = "searchBoundFirst", required = false) Integer searchBoundFirst,
                              @RequestParam(value = "searchBoundEnd", required = false) Integer searchBoundEnd,
                              @RequestParam(value = "menu", required = false) String menu,
                              Model model) throws Exception {
        System.out.println("/listProduct�� ���۵˴ϴ�..");
        System.out.println("searchBound :: " + searchBoundFirst + " " + searchBoundEnd);
        System.out.println("searchType :: "+ search.getSearchType());
//        if(search.getSearchType() == null) {
//            search.setSearchType("1");
//        }

        if(searchBoundFirst ==null && searchBoundEnd == null) {
        searchBoundFirst = 0;
        searchBoundEnd = 0;
        }
        //���ε� : Ŭ��-searchBoundFirst, searchBoundEnd > search������
        if (!(searchBoundFirst == 0) || !(searchBoundEnd == 0)) {
            search.setSearchBoundFirst(searchBoundFirst);
            search.setSearchBoundEnd(searchBoundEnd);
//                System.out.println("searchBound[0]"+searchBound[0]);
//                System.out.println("searchBound[1]"+searchBound[1]);
        }


        //���ε� : Ŭ��-currentPage > search������ > page������
        int currentPage = 1;
        //��� 1,2,3,4�� ���������
        if (search.getCurrentPage() != 0) {
            currentPage = search.getCurrentPage();
        }

        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);

        Map<String, Object> productMap = productService.getProductList(search);//Like�� �ٸ� �κ�

        Page page = new Page(
                currentPage,
                (Integer) productMap.get("totalCount"),
                pageUnit,
                pageSize);

        System.out.println("ListProductAction ::" + page);
        System.out.println("products :: " + productMap.get("list"));
        System.out.println("search :: " + search);

        //Model �� View ����
        //model.addAttribute("products", products);
        //model.addAttribute("search", search);
        model.addAttribute("totalCount", productMap.get("totalCount"));
        model.addAttribute("list", productMap.get("list"));
        model.addAttribute("resultPage", page);
        model.addAttribute("menu", menu);

        System.out.println("/listProduct�� �������ϴ�..");

        //�׺���̼�
        if (menu != null) {
            System.out.println("forward:/product/listProduct.jsp" + "�մϴ�.");
            return "forward:/product/listProduct.jsp";
        } else {
            System.out.println("forward:/product/getProduct.jsp" + "�մϴ�.");
            return "forward:/product/getProduct.jsp";
        }//end of else
    }//end of listProduct

    //prodNo,menu,currentPage,
    @RequestMapping("/setLikeProduct")
    public String SetLikeProduct(HttpServletRequest request,
                                 HttpServletResponse response,
                                 @RequestParam("prodNo") int prodNo,
                                 @RequestParam("menu") String menu,
                                 @RequestParam("currentPage") int currentPage,
                                 @CookieValue(name = "like", required = false) String likeCookie,
                                 Model model) throws Exception {
        System.out.println("/////////////////////////////////////////////////////////////setLikeProduct�� ���۵˴ϴ�..");


        //Business Logic
        Product product = productService.getProduct(prodNo);

        //��Ű����� ;
        if (likeCookie!=null && likeCookie.startsWith(";")) {
            likeCookie = likeCookie.substring(1);
        }


        System.out.println("setLikeProduct::likeCookie :: "+likeCookie);
        String[] likeCookies = null;

        if (likeCookie != null) {
            likeCookies = likeCookie.split(";");
        } // IF

        System.out.println("setLikeProduct::likeCookies::"+ Arrays.toString(likeCookies));

        boolean result = true;
        if(likeCookies!=null) {
            for (String element : likeCookies) {
                if (element.equals(String.valueOf(product.getProdNo()))) {//������ �ϳ��� ������ false
                    result = false;
                } // IF
            } // FOR
        }
        if(result) {//������ ������ true
            CookieUtil.addValue(request, response, "like", String.valueOf(product.getProdNo()));
        }

        request.setAttribute("currentPage", currentPage);
        //request.setAttribute("from", "setLikeProduct");
        //request.setAttribute("product",product);

        System.out.println("//////////////////////////////////////////////////////////////setLikeProduct�� �������ϴ�..");
        System.out.println("forward:/product/listProduct?menu=search" + "�մϴ�.");
        //������ �򸮽�Ʈ�� �����ڴ� ������ �� ������ �س�����.
        return "forward:/product/listProduct"+"?currentPage="+currentPage;
    }//end of SetLikeProduct

    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute("product") Product product,
                                @RequestParam("file") MultipartFile file,
                                RedirectAttributes redirectAttributes,
                                Model model) throws Exception {
        System.out.println("/updateProduct �� ���۵˴ϴ�.");

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            return "redirect:/product/updateProduct.jsp";
        }

        String fileName = getProductFileName(file);
        System.out.println("fileName :: "+fileName);

        //Business Logic
        product = productService.getProduct(product.getProdNo());

        product.setFileName(fileName);
        product.setManuDate(product.getManuDate().replaceAll("-", ""));

        System.out.println("������Ʈ �Ϸ� :: " + productService.updateProduct(product));

        //Model �� View ����
        model.addAttribute("product", product);

        System.out.println("/updateProduct �� �������ϴ�.");
        System.out.println("redirect:/getProduct" + "�մϴ�.");
        redirectAttributes.addFlashAttribute("message", "You successfully uploaded '" + file.getOriginalFilename() + "' and added product information.");
        return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=ok";
    }//end of updateProduct

    //prodNo,
    @GetMapping("/updateProduct")
    public String updateProductView(@ModelAttribute Product product,
                                    Model model) throws Exception {

        System.out.println("/updateProductView" + "�� ���۵˴ϴ�..");
        product = productService.getProduct(product.getProdNo());

        // Model �� View ����
        model.addAttribute("product", product);

        System.out.println("/updateProductView" + "�� �������ϴ�.");
        System.out.println("forward:/product/updateProduct.jsp" + "�մϴ�.");
        return "forward:/product/updateProduct.jsp";
    }

    public String getProductFileName(MultipartFile file) throws Exception{;

        String uploadDir = "C:/Users/osuma/git/Myshop/Myshop08/src/main/webapp/images/uploadFiles/";
        String fileName = file.getOriginalFilename();


        System.out.println("uploadDir"+uploadDir);
        System.out.println("fileName" + fileName);

        Path path = Paths.get(uploadDir + fileName);

        FileCopyUtils.copy(file.getBytes(), new File(path.toString()));
//      Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

        return fileName;
    }

}