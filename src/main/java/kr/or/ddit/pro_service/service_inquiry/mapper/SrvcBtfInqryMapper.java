package kr.or.ddit.pro_service.service_inquiry.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.pro_service.service_inquiry.vo.V_SrvcBtfInqryVO;
import kr.or.ddit.vo.OneInqryVO;
import kr.or.ddit.vo.SrvcBtfInqryVO;
import kr.or.ddit.vo.SrvcRequstVO;
import kr.or.ddit.vo.UsersVO;

public interface SrvcBtfInqryMapper {

	// 이용자 유형 확인
	public UsersVO userChk(Object object);

	public List<V_SrvcBtfInqryVO> btfInqryList(Map<String, Object> map);

	public V_SrvcBtfInqryVO btfInqryDetail(V_SrvcBtfInqryVO vSrvcBtfInqryVO);

	public int updateAnswer(Map<String, Object> updateParamMap);

	public int btfInqryCreatePost(Map<String, Object> btfInqryInfoMap);

	public int getTotal(Map<String, Object> map);
	
	public int getNoAnswerTotal(Map<String, Object> map);
	
	public int getSuccessTotal(Map<String, Object> map);

	public List<V_SrvcBtfInqryVO> btfInqryNoAnswerList(Map<String, Object> map);

	public List<V_SrvcBtfInqryVO> btfInqrySuccessList(Map<String, Object> map);

	public int btfInqryUpdatePost(SrvcBtfInqryVO srvcBtfInqryVO);


}
