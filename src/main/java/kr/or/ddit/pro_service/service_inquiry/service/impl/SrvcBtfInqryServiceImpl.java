package kr.or.ddit.pro_service.service_inquiry.service.impl;

import java.io.File;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import kr.or.ddit.member.join.controller.MemberJoinController;
import kr.or.ddit.pro_service.service_inquiry.mapper.SrvcBtfInqryMapper;
import kr.or.ddit.pro_service.service_inquiry.service.SrvcBtfInqryService;
import kr.or.ddit.pro_service.service_inquiry.vo.V_SrvcBtfInqryVO;
import kr.or.ddit.pro_service.service_request.mapper.SrvcRequstMapper;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.SrvcBtfInqryVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class SrvcBtfInqryServiceImpl implements SrvcBtfInqryService {

	@Autowired
	SrvcBtfInqryMapper srvcBtfInqryMapper;
	
	@Autowired
	SrvcRequstMapper srvcRequstMapper;
	
	@Autowired
	FileuploadService fileuploadService;
	
	@Autowired
	MemberJoinController memberJoinController;
	
	@Autowired
	String uploadFolder;
	
	V_SrvcBtfInqryVO vSrvcBtfInqryVO = new V_SrvcBtfInqryVO();
	
	// 아이디 유형 확인 
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
	public int getTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcBtfInqryVO.setUserId(usersVO.getUserId());
		vSrvcBtfInqryVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcBtfInqryVO", vSrvcBtfInqryVO);
		
		return this.srvcBtfInqryMapper.getTotal(map);
	}
	@Override
	public int getNoAnswerTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcBtfInqryVO.setUserId(usersVO.getUserId());
		vSrvcBtfInqryVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcBtfInqryVO", vSrvcBtfInqryVO);
		
		return this.srvcBtfInqryMapper.getNoAnswerTotal(map);
	}
	
	@Override
	public int getSuccessTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		vSrvcBtfInqryVO.setUserId(usersVO.getUserId());
		vSrvcBtfInqryVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcBtfInqryVO", vSrvcBtfInqryVO);
		
		return this.srvcBtfInqryMapper.getSuccessTotal(map);
	}
	
	// 보낸 사전 문의 및 받은 사전문의 목록 조회 
	@Override
	public List<V_SrvcBtfInqryVO> btfInqryList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		log.info("(serviceImpl)btfInqryList -> usersVO : " + usersVO);
		
		vSrvcBtfInqryVO.setUserId(usersVO.getUserId());
		vSrvcBtfInqryVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcBtfInqryVO", vSrvcBtfInqryVO);
		
		return this.srvcBtfInqryMapper.btfInqryList(map);
	}

	// 미답변 목록 조회
	@Override
	public List<V_SrvcBtfInqryVO> btfInqryNoAnswerList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		log.info("(serviceImpl)btfInqryList -> usersVO : " + usersVO);
		
		vSrvcBtfInqryVO.setUserId(usersVO.getUserId());
		vSrvcBtfInqryVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcBtfInqryVO", vSrvcBtfInqryVO);
		
		return this.srvcBtfInqryMapper.btfInqryNoAnswerList(map);
	}
	
	// 답변 완료 목록 조회
	@Override
	public List<V_SrvcBtfInqryVO> btfInqrySuccessList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		log.info("(serviceImpl)btfInqryList -> usersVO : " + usersVO);
		
		vSrvcBtfInqryVO.setUserId(usersVO.getUserId());
		vSrvcBtfInqryVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		map.put("vSrvcBtfInqryVO", vSrvcBtfInqryVO);
		return this.srvcBtfInqryMapper.btfInqrySuccessList(map);
	}
	
	
	@Override
	public V_SrvcBtfInqryVO btfInqryDetail(V_SrvcBtfInqryVO vSrvcBtfInqryVO, String userId) {
		
		UsersVO usersVO = userChk(userId);
		vSrvcBtfInqryVO.setUserId(usersVO.getUserId());
		vSrvcBtfInqryVO.setEmplyrTy(usersVO.getEmplyrTy());
		
		return this.srvcBtfInqryMapper.btfInqryDetail(vSrvcBtfInqryVO);
	}

	@Override
	public int updateAnswer(Map<String, Object> updateParamMap, String userId) {
		
		updateParamMap.put("proId", userId);
		return this.srvcBtfInqryMapper.updateAnswer(updateParamMap);
	}

	@Override
	public int btfInqryCreatePost(SrvcBtfInqryVO srvcBtfInqryVO, List<MultipartFile> uploadFiles) {
		
		int res = 0;
		log.info("btfInqryCreatePost -> srvcRequstVO : " + srvcBtfInqryVO);
		log.info("btfInqryCreatePost -> 제목 : " + srvcBtfInqryVO.getBtfInqrySj());
		log.info("btfInqryCreatePost -> 내용 : " + srvcBtfInqryVO.getBtfInqryCn());
		log.info("btfInqryCreatePost -> 아이디 : " + srvcBtfInqryVO.getMberId());
		log.info("btfInqryCreatePost -> 프로아이디 : " + srvcBtfInqryVO.getProId());
		
		Map<String, Object>btfInqryInfoMap = new HashMap<String, Object>();
		
		btfInqryInfoMap.put("btfInqrySj", srvcBtfInqryVO.getBtfInqrySj());
		btfInqryInfoMap.put("btfInqryCn", srvcBtfInqryVO.getBtfInqryCn());
		btfInqryInfoMap.put("mberId", srvcBtfInqryVO.getMberId());
		btfInqryInfoMap.put("proId", srvcBtfInqryVO.getProId());
		
		// 요청서 기본 정보
		res = this.srvcBtfInqryMapper.btfInqryCreatePost(btfInqryInfoMap);
		
		String addPath = "pro_service\\btfInqryImage";
		res += fileuploadService.fileUpload(uploadFiles, addPath, srvcBtfInqryVO.getMberId(), res);
			
		return res;
	}
	
	@Override
	public int btfInqryUpdatePost(Map<String, Object> btfInqryUpdateMap, List<MultipartFile> uploadFiles, String userId) {
		int res = 0;
		// 문의 번호
		String btfInqryNo = (String)btfInqryUpdateMap.get("btfInqryNo");
		// 문의 변경 제목 
		String btfInqrySj = (String)btfInqryUpdateMap.get("hiddenBtfInqrySj");
		// 문의 변경 내용
		String btfInqryCn = (String)btfInqryUpdateMap.get("newBtfInqryCn");
		// 문의 첨부파일 번호
		String sprviseAtchmnflNo = (String)btfInqryUpdateMap.get("sprviseAtchmnflNo");
		
		log.info("[btfInqryUpdatePost/serviceimpl]번호 :"+(String)btfInqryUpdateMap.get("btfInqryNo"));
		log.info("[btfInqryUpdatePost/serviceimpl]제목 : "+(String)btfInqryUpdateMap.get("hiddenBtfInqrySj"));
		log.info("[btfInqryUpdatePost/serviceimpl]내용 : "+(String)btfInqryUpdateMap.get("newBtfInqryCn"));
		log.info("[btfInqryUpdatePost/serviceimpl]통합첨부파일 번호 : "+(String)btfInqryUpdateMap.get("sprviseAtchmnflNo"));
		log.info("[btfInqryUpdatePost/serviceimpl]기존 사진 배열 : "+(String) btfInqryUpdateMap.get("atchmnflNo[]"));
		
		// 사전문의 업데이트
		SrvcBtfInqryVO srvcBtfInqryVO = new SrvcBtfInqryVO();
		if(btfInqrySj != null || btfInqryCn != null) {
			srvcBtfInqryVO.setBtfInqryNo(Integer.valueOf(btfInqryNo));
			srvcBtfInqryVO.setBtfInqrySj(btfInqrySj);
			srvcBtfInqryVO.setBtfInqryCn(btfInqryCn);

			res = this.srvcBtfInqryMapper.btfInqryUpdatePost(srvcBtfInqryVO);
		}
		
		// 기존 이미지 삭제
		Map<String, Object> updateFileuploadMap = new HashMap<String, Object>();
		
		String atchmnflNoArrayParam = (String) btfInqryUpdateMap.get("atchmnflNo[]");
		String[] atchmnflNoArray = atchmnflNoArrayParam.split(",");
		log.info("[btfInqryUpdatePost/serviceimpl] String[] atchmnflNoArray : " + Arrays.toString(atchmnflNoArray));
		
		updateFileuploadMap.put("sprviseAtchmnflNo", sprviseAtchmnflNo);
		updateFileuploadMap.put("atchmnflNoArray", atchmnflNoArray);
		log.info("[btfInqryUpdatePost/serviceimpl] 기존 이미지 삭제 map : " + updateFileuploadMap);
		res += this.fileuploadService.updateFileupload(updateFileuploadMap);
		
		
		// 새로운 파일 업로드
		if(!uploadFiles.isEmpty()) {
			String addPath = "pro_service\\btfInqryImage";
			res += fileuploadService.newFileUpload(uploadFiles, addPath, userId, res, sprviseAtchmnflNo);
		}
		return res;
	}
}
