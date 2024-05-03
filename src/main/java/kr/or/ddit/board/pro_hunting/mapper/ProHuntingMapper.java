package kr.or.ddit.board.pro_hunting.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ProJoBbscttVO;

public interface ProHuntingMapper {

	public List<ProJoBbscttVO> listAjax(Map<String, Object> paramMap);

	public int getTotal(Map<String, Object> paramMap);

	public List<ProJoBbscttVO> detail(int proJoBbscttNo);

	public int rdCntUpdt(int proJoBbscttNo);

	public int proAnswerRegister(Map<String, Object> map);

	public int delProAnswer(Map<String, Object> map);

	public List<ProJoBbscttVO> myBoardList(Map<String, Object> paramMap);

	public int myBoardListgetTotal(Map<String, Object> paramMap);

}
