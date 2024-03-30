package com.model2.mvc.web.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.model2.mvc.common.DaumSearch;
import com.model2.mvc.service.Rest.DaumSearchService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;

@RestController
@RequestMapping("/rest/*")
public class RestAPIController {

    //Field
    private DaumSearchService daumSearchService;

    @Autowired
    public void setDaumSearchService(@Qualifier("daumSearchServiceImpl") DaumSearchService daumSearchService) {
        this.daumSearchService = daumSearchService;
    }
    //Constructor
    public RestAPIController() {
        System.out.println(this.getClass());
    }
    //Method
    @RequestMapping(value="json/searchImage",method = RequestMethod.POST)
    public ResponseEntity<?> searchImage(@RequestBody DaumSearch daumSearch,
                              Model model) throws Exception {
        System.out.println("/rest/json/searchImage : POST");

        Map<String,Object> map = new HashMap<String,Object>();
//        AtomicReference<String> resultValueStringRef = new AtomicReference<>();

//        String returnValue = String.valueOf(daumSearchService.searchImage("������"));
        //�갡 �����ϴ°� Mono<String>�̶� String���� ��ȯ�������
        //subscribe�� ������ Mono�� ������ �ִ� ���� ������ ����ϴ� ��
        String resultValue  = daumSearchService.searchImage(daumSearch.getName())
                .map(
                        result -> {
                            System.out.println("result : " + result);
                            JSONObject jsonObject = (JSONObject) JSONValue.parse(result);
                            JSONArray documents = (JSONArray) jsonObject.get("documents");
                            JSONObject document = (JSONObject) documents.get(0);
                            String imageUrl = (String) document.get("image_url");
                            System.out.println("imageUrl : " + imageUrl);
                            return imageUrl;
                        }
                ).block();


        System.out.println("resultValue :: "+resultValue);
        daumSearch.setImageUrl(resultValue);
        //��Ʈ������Ʈ���� �� ������ json�߿� �Ӽ��� �ϳ� ������..

        //resultValue
//        ObjectMapper mapper = new ObjectMapper();
//        mapper.readValue(resultValue, String.class);

        //���⼭
        return ResponseEntity.status(HttpStatus.OK).body(daumSearch);
        //Mono<ResponseEntity<String>>�� �ִ� �� ���� ResponseEntity<String> �ν��Ͻ���
        //�񵿱������� ������ �� �ִ� ����Ƽ�� Ÿ���� �����ϴ� ���� �ǹ�
//        return daumSearchService.searchImage("������")
//                .map(result -> {
//                    System.out.println("returnValue : " + result);
//                    return ResponseEntity.ok(result);
//                });
    }

}
