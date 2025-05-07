package kr.co.khedu.payment.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class PaymentInfoDTO {
    private String receiptId;
    private String orderId;
	private String method;
    private int amount;
    private String status;
    private String memberId;
    private String productId;
}