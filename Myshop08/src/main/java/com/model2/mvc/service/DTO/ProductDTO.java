package com.model2.mvc.service.DTO;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

@Data
public class ProductDTO {
    private String fileName;
    private String manuDate;
    private int price;
    private String prodDetail;
    private String prodName;
    private int prodNo;
    private Date regDate;
    private String proTranCode;
    private List<MultipartFile> fileList;

    // ������, getter, setter, toString ���� Lombok�� �ڵ����� �������ݴϴ�.
}