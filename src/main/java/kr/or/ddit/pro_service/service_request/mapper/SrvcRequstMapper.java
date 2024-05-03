package kr.or.ddit.pro_service.service_request.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.pro_service.service_request.vo.V_SrvcRequstVO;
import kr.or.ddit.vo.SrvcRequstVO;

public interface SrvcRequstMapper {

	public List<V_SrvcRequstVO> srvcRqList(Map<String, Object> map);

	public V_SrvcRequstVO srvcRqDetail(V_SrvcRequstVO vSrvcRequstVO);

	public int processFn(Map<String, Object> paramMap);

	public int acceptRequst(Map<String, Object> acceptMap);

	public int rejectRequst(Map<String, Object> rejectMap);

	public int srvcRqCreatePost(Map<String, Object> srvcRqInfoMap);

	public int insertSprviseAtchmnfl(Map<String, Object> srvcRqInfoMap);

	public int getTotal(Map<String, Object> map);

	public List<V_SrvcRequstVO> srvcRqNoAnswerList(Map<String, Object> map);

	public List<V_SrvcRequstVO> srvcRqSuccessList(Map<String, Object> map);

	public List<V_SrvcRequstVO> srvcRqRejectList(Map<String, Object> map);

	public int getNoAnswerTotal(Map<String, Object> map);

	public int getSuccessTotal(Map<String, Object> map);
	
	public int getRejectTotal(Map<String, Object> map);

	public int srvcRqUpdatePost(SrvcRequstVO srvcRequstVO);

}
