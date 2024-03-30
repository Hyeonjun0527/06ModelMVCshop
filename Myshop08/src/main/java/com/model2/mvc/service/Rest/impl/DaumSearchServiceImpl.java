package com.model2.mvc.service.Rest.impl;

import com.model2.mvc.service.Rest.DaumSearchService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.reactive.ClientHttpConnector;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import reactor.netty.http.client.HttpClient;

import java.net.URLEncoder;

@Service("daumSearchServiceImpl")
public class DaumSearchServiceImpl implements DaumSearchService {
    private final WebClient webClient;

    @Value("#{daumProperties['daum.api.key']}")
    private String apiKey;

    public DaumSearchServiceImpl() {
        HttpClient httpClient = HttpClient.create();
        ClientHttpConnector connector = new ReactorClientHttpConnector(httpClient);
        this.webClient = WebClient.builder().clientConnector(connector).baseUrl("https://dapi.kakao.com").build();
    }

    public Mono<String> searchImage(String keyword) throws Exception {
//        String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
        String path = "/v2/search/image?query=" + keyword + "&page=1&size=1";
        System.out.println(path);
        System.out.println("apiKey :: "+apiKey);

        return webClient.get()
                .uri(path)
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + apiKey)
                .retrieve()
                .bodyToMono(String.class);
    }
}