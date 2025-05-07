package kr.co.khedu.payment.service;

import org.apache.ibatis.session.SqlSession;

import kr.co.khedu.payment.model.dao.PaymentDAO;
import kr.co.khedu.payment.model.vo.Payment;
import kr.co.khedu.template.Template;

public class PaymentServiceImpl implements PaymentService {

	private PaymentDAO paymentDAO = new PaymentDAO();
	
	@Override
	public int insertPayment(Payment paymentInfo) {
		SqlSession sqlSession = Template.getSqlSession();
		
		int result = paymentDAO.insertPayment(sqlSession, paymentInfo);
		
		if(result > 0) {
			sqlSession.commit();
		}
		
		sqlSession.close();
		
		return result;
	}

}
