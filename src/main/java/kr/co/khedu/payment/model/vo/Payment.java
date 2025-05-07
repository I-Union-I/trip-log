package kr.co.khedu.payment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Payment {
	private int paymentRecordId;
	private int amount;
	private String method;
	private String status;
	private String createdAt;
	private int productId;
	private int memberId;
    private String receiptId;
    private String orderId;
}
