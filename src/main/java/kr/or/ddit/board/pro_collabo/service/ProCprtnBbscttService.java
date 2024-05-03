package kr.or.ddit.board.pro_collabo.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.pro_collabo.vo.ProCprtnAnswerVO;
import kr.or.ddit.board.pro_collabo.vo.ProCprtnBbscttVO;


public interface ProCprtnBbscttService {
	
	// 댓글 조회
	public List<ProCprtnAnswerVO> list2(int proCprtnBbscttNo);

	// 댓글 조회
	public int write(ProCprtnAnswerVO proCprtnAnswerVO);

	// 댓글 수정
	public int modify(ProCprtnAnswerVO proCprtnAnswerVO);

	// 댓글 삭제
	public int delete(ProCprtnAnswerVO proCprtnAnswerVO);
	
//	public List<ProCprtnBbscttVO> proCprtnBbscttList();

	public int getTotal(Map<String, Object> map);

	public List<ProCprtnBbscttVO> list(Map<String, Object> map);

	public int increaseViewCount(int proCprtnBbscttNo);

	public ProCprtnBbscttVO detail(int proCprtnBbscttNo);

	public ProCprtnBbscttVO detail2(int proCprtnBbscttNo);

	

}
