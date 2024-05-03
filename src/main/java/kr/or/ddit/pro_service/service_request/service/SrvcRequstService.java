package kr.or.ddit.pro_service.service_request.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.pro_service.service_request.vo.V_SrvcRequstVO;
import kr.or.ddit.vo.SrvcRequstVO;
import kr.or.ddit.vo.UsersVO;

public interface SrvcRequstService {

	public UsersVO userChk(String userId);

	public List<V_SrvcRequstVO> srvcRqList(Map<String, Object> map);

	public V_SrvcRequstVO srvcRqDetail(V_SrvcRequstVO vSrvcRequstVO, String userId);

	public int processFn(int srvcRequstNo, String userId);

	public int acceptRequst(Map<String, Object> acceptMap, String userId);

	public int rejectRequst(Map<String, Object> rejectMap, String userId);

	public int srvcRqCreatePost(SrvcRequstVO srvcRequstVO, List<MultipartFile> uploadFiles);

	public int getTotal(Map<String, Object> map);

	public List<V_SrvcRequstVO> srvcRqNoAnswerList(Map<String, Object> map);

	public List<V_SrvcRequstVO> srvcRqSuccessList(Map<String, Object> map);

	public List<V_SrvcRequstVO> srvcRqRejectList(Map<String, Object> map);

	public int getNoAnswerTotal(Map<String, Object> map);
	
	public int getSuccessTotal(Map<String, Object> map);
	
	public int getRejectTotal(Map<String, Object> map);

	public int srvcRqUpdatePost(Map<String, Object> srvcRqUpdateMap, List<MultipartFile> uploadFiles, String userId);


}
