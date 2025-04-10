package kr.co.khedu.member.model.dto;

import java.sql.Date;

import kr.co.khedu.member.model.vo.Member;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberDTO extends Member {

	private String countryName;

	// ȸ������ ���� ������
	public MemberDTO(int memberId, String password, String nickname, String phone, int countryId) {
		super();
		super.setMemberId(memberId);
		super.setPassword(password);
		super.setNickname(nickname);
		super.setPhone(phone);
		super.setCountryId(countryId);
	}

	// �α��� ������
	public MemberDTO(String email, String password) {
		super();
		super.setEmail(email);
		super.setPassword(password);
	}

	// �Ҽȷα��� ������
	public MemberDTO(String email) {
		super();
		super.setEmail(email);
	}
}
