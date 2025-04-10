package kr.co.khedu.member.model.dto;

import java.sql.Date;

import kr.co.khedu.member.model.vo.Member;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberDTO extends Member{

	private String countryName;
	
	// 회원가입용 생성자
	public MemberDTO(String email, String password, String nickname, Date birthday, String phone, int countryId) {
		super();
		super.setEmail(email);
		super.setPassword(password);
		super.setNickname(nickname);
		super.setBirthday(birthday);
		super.setPhone(phone);
		super.setCountryId(countryId);
	}


	 // 회원정보 수정 생성자
	public MemberDTO(int memberId, String password, String nickname, String phone, int countryId) {
		super();
		super.setMemberId(memberId);
		super.setPassword(password);
		super.setNickname(nickname);
		super.setPhone(phone);
		super.setCountryId(countryId);
	}
	
	// 로그인 생성자
	public MemberDTO(String email, String password) {
		super.setEmail(email);
		super.setPassword(password);
	}
}
