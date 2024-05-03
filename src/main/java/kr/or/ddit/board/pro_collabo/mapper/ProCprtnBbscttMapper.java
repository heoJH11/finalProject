package kr.or.ddit.board.pro_collabo.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.pro_collabo.vo.ProCprtnAnswerVO;
import kr.or.ddit.board.pro_collabo.vo.ProCprtnBbscttVO;

public interface ProCprtnBbscttMapper {

//	public List<ProCprtnBbscttVO> proCprtnBbscttList();

	public int getTotal(Map<String, Object> map);

	public List<ProCprtnBbscttVO> list(Map<String, Object> map);

	public int increaseViewCount(int proCprtnBbscttNo);

	public ProCprtnBbscttVO detail(int proCprtnBbscttNo);

	public ProCprtnBbscttVO detail2(int proCprtnBbscttNo);

	public List<ProCprtnAnswerVO> list2(int proCprtnBbscttNo);

	public int write(ProCprtnAnswerVO proCprtnAnswerVO);

	public int modify(ProCprtnAnswerVO proCprtnAnswerVO);

	public int delete(ProCprtnAnswerVO proCprtnAnswerVO);

	

	
}
