package kr.co.khedu.payment.service;

import kr.co.khedu.payment.model.vo.Payment;

public interface PaymentService {

	int insertPayment(Payment paymentInfoDTO);
}
