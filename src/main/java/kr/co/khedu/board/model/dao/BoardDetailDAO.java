package kr.co.khedu.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import kr.co.khedu.board.model.vo.BoardDetailDto;
import kr.co.khedu.board.model.vo.CommentDto;

public class BoardDetailDAO {

	public BoardDetailDto selectBoardDetail(SqlSession sqlSession, int num) {
		
		
		BoardDetailDto boardDetail = sqlSession.selectOne("boardDetailMapper.searchBoardDetail", num);
		
		
		return boardDetail;
		
	}

	public ArrayList<CommentDto> selectCommentList(SqlSession sqlSession, int pNum) {
		System.out.println("DAO로 요청은 들어옴");

		ArrayList<CommentDto> comments = (ArrayList)sqlSession.selectList("boardDetailMapper.selectCommentList", pNum);
		
		System.out.println("@@DAO에서 요청 후 DB처리까지는 됨");
		return comments;
	}

}
