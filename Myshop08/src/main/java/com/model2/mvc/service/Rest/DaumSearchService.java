package com.model2.mvc.service.Rest;

import reactor.core.publisher.Mono;

public interface DaumSearchService {
    public Mono<String> searchImage(String keyword) throws Exception;
}