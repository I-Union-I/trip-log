package kr.co.khedu.payment.model.dao;

import org.apache.ibatis.session.SqlSession;

import kr.co.khedu.payment.model.vo.Payment;

public class PaymentDAO {

	public int insertPayment(SqlSession sqlSession, Payment paymentInfoDTO) {
		return sqlSession.insert("paymentMapper.insertPayment", paymentInfoDTO);
	}
}
