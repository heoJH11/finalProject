package kr.or.ddit.pro_service.service_request.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.pro_service.service_inquiry.mapper.SrvcBtfInqryMapper;
import kr.or.ddit.pro_service.service_request.mapper.SrvcRequstMapper;
import kr.or.ddit.pro_service.service_request.service.SrvcRequstService;
import kr.or.ddit.pro_service.service_request.vo.V_SrvcRequstVO;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.SrvcRequstVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class SrvcRequstSeviceImpl implements SrvcRequstService {

	@Autowired
	SrvcBtfInqryMapper srvcBtfInqryMapper;
	
	@Autowired
	SrvcRequstMapper srvcRequstMapper;
	
	@Autowired
	FileuploadService fileuploadService;
	
	@Autowired
	String uploadFolder;
	
	V_SrvcRequstVO vSrvcRequstVO = new V_SrvcRequstVO();

	@Override
	public UsersVO userChk(String userId) { 
		
		UsersVO usersVO = this.srvcBtfInqryMapper.userChk(userId);
		
		if(usersVO.getEmplyrTy().equals("ET01")) { // 회원일 경우, 프로 닉네임을 얻기 위함
			usersVO.setEmplyrTy("ET02");
			
		}else if(usersVO.getEmplyrTy().equals("ET02")) { // 프로일 경우, 회원 닉네임을 얻기 위함
			usersVO.setEmplyrTy("ET01");
		}
		log.info("userChk -> usersVO : " + usersVO.toString());
		
		return usersVO;
	}

	@Override
	public List<V_SrvcRequstVO> srvcRqList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.srvcRqList(map);
	}
	
	@Override
	public List<V_SrvcRequstVO> srvcRqNoAnswerList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.srvcRqNoAnswerList(map);
	}

	@Override
	public List<V_SrvcRequstVO> srvcRqSuccessList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.srvcRqSuccessList(map);
	}
	
	@Override
	public List<V_SrvcRequstVO> srvcRqRejectList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.srvcRqRejectList(map);
	}
	
	@Override
	public int getTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.getTotal(map);
	}
	
	@Override
	public int getNoAnswerTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.getNoAnswerTotal(map);
	}
	
	@Override
	public int getSuccessTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.getSuccessTotal(map);
	}
	
	@Override
	public int getRejectTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcRequstVO", vSrvcRequstVO);
		
		return this.srvcRequstMapper.getRejectTotal(map);
	}

	@Override
	public V_SrvcRequstVO srvcRqDetail(V_SrvcRequstVO vSrvcRequstVO, String userId) {
		UsersVO usersVO = userChk(userId);
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		return this.srvcRequstMapper.srvcRqDetail(vSrvcRequstVO);
	}

	@Override
	public int processFn(int srvcRequstNo, String userId) {
		UsersVO usersVO = userChk(userId);
		vSrvcRequstVO.setUserId(usersVO.getUserId());
		vSrvcRequstVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		String emplyrTy = usersVO.getEmplyrTy();
		String processUser = "";
		if("ET01".equals(emplyrTy)) { // 프로
			processUser = "SRVC_REQUST_PROCESS_PRO";
		}else if("ET02".equals(emplyrTy)) { //회원
			processUser = "SRVC_REQUST_PROCESS_MBER";
		}
		paramMap.put("emplyrTy", emplyrTy);
		paramMap.put("processUser", processUser);
		paramMap.put("userId", userId);
		paramMap.put("srvcRequstNo", srvcRequstNo);
		
		return this.srvcRequstMapper.processFn(paramMap);
	}

	@Override
	public int acceptRequst(Map<String, Object> acceptMap, String userId) {
		acceptMap.put("proId", userId);
		int res = 0;

		res = this.srvcRequstMapper.acceptRequst(acceptMap);
		
		return res;
	}

	@Override
	public int rejectRequst(Map<String, Object> rejectMap, String userId) {
		rejectMap.put("proId", userId);
		int res = 0;
		
		res = this.srvcRequstMapper.rejectRequst(rejectMap);
		
		return res;
	}

	@Override
	public int srvcRqCreatePost(SrvcRequstVO srvcRequstVO, List<MultipartFile> uploadFiles) {
		
		int res = 0;
		log.info("srvcRqCreatePost -> srvcRequstVO : " + srvcRequstVO);
		log.info("srvcRqCreatePost -> 제목 : " + srvcRequstVO.getSrvcRequstSj());
		log.info("srvcRqCreatePost -> 내용 : " + srvcRequstVO.getSrvcRequstCn());
		
		Map<String, Object>srvcRqInfoMap = new HashMap<String, Object>();
		
		srvcRqInfoMap.put("srvcRequstSj", srvcRequstVO.getSrvcRequstSj());
		srvcRqInfoMap.put("srvcRequstCn", srvcRequstVO.getSrvcRequstCn());
		srvcRqInfoMap.put("mberId", srvcRequstVO.getMberId());
		srvcRqInfoMap.put("proId", srvcRequstVO.getProId());
		
		// 요청서 기본 정보
		res = this.srvcRequstMapper.srvcRqCreatePost(srvcRqInfoMap);
		
		String addPath = "pro_service\\srvcRequstImage";
		log.info("uploadFiles : " + uploadFiles.toString());
		
		if(uploadFiles !=null && !uploadFiles.isEmpty()) {
			res += fileuploadService.fileUpload(uploadFiles, addPath, 
					srvcRequstVO.getMberId(), res);
		}
		return res;
	}

	@Override
	public int srvcRqUpdatePost(Map<String, Object> srvcRqUpdateMap, List<MultipartFile> uploadFiles, String userId) {
		int res = 0;
		// 문의 번호
		String srvcRequstNo = (String)srvcRqUpdateMap.get("srvcRequstNo");
		// 문의 변경 제목 
		String srvcRequstSj = (String)srvcRqUpdateMap.get("hiddenSrvcRequstSj");
		// 문의 변경 내용
		String srvcRequstCn = (String)srvcRqUpdateMap.get("newSrvcRequstCn");
		// 문의 첨부파일 번호
		String sprviseAtchmnflNo = (String)srvcRqUpdateMap.get("sprviseAtchmnflNo");
		
		// 사전문의 업데이트
		SrvcRequstVO srvcRequstVO = new SrvcRequstVO();
		if(srvcRequstSj != null || srvcRequstCn != null) {
			srvcRequstVO.setSrvcRequstNo(Integer.valueOf(srvcRequstNo));
			srvcRequstVO.setSrvcRequstSj(srvcRequstSj);
			srvcRequstVO.setSrvcRequstCn(srvcRequstCn);

			res = this.srvcRequstMapper.srvcRqUpdatePost(srvcRequstVO);
		}
		
		Map<String, Object> updateFileuploadMap = new HashMap<String, Object>();
		String atchmnflNoArrayParam = (String) srvcRqUpdateMap.get("atchmnflNo[]");
		String[] atchmnflNoArray = atchmnflNoArrayParam.split(",");
		
		updateFileuploadMap.put("sprviseAtchmnflNo", sprviseAtchmnflNo);
		updateFileuploadMap.put("atchmnflNoArray", atchmnflNoArray);

		res += this.fileuploadService.updateFileupload(updateFileuploadMap);
		
		// 새로운 파일 업로드
		if(!uploadFiles.isEmpty()) {
			String addPath = "pro_service\\btfInqryImage";
			res += fileuploadService.newFileUpload(uploadFiles, addPath, userId, res, sprviseAtchmnflNo);
		}
		return res;
	}
}
