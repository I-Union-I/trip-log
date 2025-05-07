package kr.co.khedu.payment.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class PaymentInfoDTO {
    private String receiptId;
    private String orderId;
    private int price;
    private String status;
    private String userId;
    private String productId;
}