package kr.or.ddit.pro_service.service_inquiry.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.pro_service.service_inquiry.vo.V_SrvcBtfInqryVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.SrvcBtfInqryVO;
import kr.or.ddit.vo.UsersVO;

public interface SrvcBtfInqryService {

	public List<V_SrvcBtfInqryVO> btfInqryList(Map<String, Object> map);

	public UsersVO userChk(String userId);

	public V_SrvcBtfInqryVO btfInqryDetail(V_SrvcBtfInqryVO vSrvcBtfInqryVO, String userId);

	public int updateAnswer(Map<String, Object> updateParamMap, String userId);

	public int btfInqryCreatePost(SrvcBtfInqryVO srvcBtfInqryVO, List<MultipartFile> uploadFiles);

	public int getTotal(Map<String, Object> map);
	
	public int getNoAnswerTotal(Map<String, Object> map);
	
	public int getSuccessTotal(Map<String, Object> map);

	public List<V_SrvcBtfInqryVO> btfInqryNoAnswerList(Map<String, Object> map);

	List<V_SrvcBtfInqryVO> btfInqrySuccessList(Map<String, Object> map);

	public int btfInqryUpdatePost(Map<String, Object> btfInqryUpdateMap, List<MultipartFile> uploadFiles, String userId);

	
}