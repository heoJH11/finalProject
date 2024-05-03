package kr.or.ddit.admin.oneInqry.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.admin.oneInqry.mapper.OneInqryMapper;
import kr.or.ddit.admin.oneInqry.service.OneInqryService;
import kr.or.ddit.pro_service.service_inquiry.mapper.SrvcBtfInqryMapper;
import kr.or.ddit.util.fileupload.service.FileuploadService;
import kr.or.ddit.vo.OneInqryVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OneInqryServiceImpl implements OneInqryService {

	@Autowired
	FileuploadService fileuploadService;
	
	@Autowired
	OneInqryMapper oneInqryMapper;
	
	@Autowired
	SrvcBtfInqryMapper srvcBtfInqryMapper;
	
	OneInqryVO oneInqryVO = new OneInqryVO();
	
	// 아이디 유형 확인 
	@Override
	public UsersVO userChk(String userId) {
		
		UsersVO usersVO = this.srvcBtfInqryMapper.userChk(userId);
		
		if(usersVO.getEmplyrTy().equals("ET01")) { // 회원일 경우, 프로 닉네임을 얻기 위함
			usersVO.setEmplyrTy("ET02");
			
		}else if(usersVO.getEmplyrTy().equals("ET02")) { // 프로일 경우, 회원 닉네임을 얻기 위함
			usersVO.setEmplyrTy("ET01");
		}
		
		log.info("userChk -> usersVO : " + usersVO);
		
		return usersVO;
	}
	
	@Override
	public List<OneInqryVO> searchList(Map<String, Object> map) {
		
		UsersVO usersVO = userChk((String)map.get("userId"));
		
		oneInqryVO.setUserId(usersVO.getUserId());
		
		map.put("oneInqryVO", oneInqryVO);
		map.put("userId", usersVO.getUserId());
		map.put("mngrId", "testAdmin");
		
		return this.oneInqryMapper.searchList(map);
	}
	
	// 미답변 목록 조회
		@Override
		public List<OneInqryVO> oneInqryNoAnswerList(Map<String, Object> map) {
			UsersVO usersVO = userChk((String)map.get("userId"));
			log.info("(serviceImpl)btfInqryList -> usersVO : " + usersVO);
			
			oneInqryVO.setUserId(usersVO.getUserId());
			
			map.put("oneInqryVO", oneInqryVO);
			map.put("userId", usersVO.getUserId());
			map.put("mngrId", "testAdmin");
			
			return this.oneInqryMapper.oneInqryNoAnswerList(map);
		}
	
	// 답변 완료 목록 조회
	@Override
	public List<OneInqryVO> oneInqrySuccessList(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		log.info("(serviceImpl)btfInqryList -> usersVO : " + usersVO);
		
		oneInqryVO.setUserId(usersVO.getUserId());
		
		map.put("oneBtfInqryVO", oneInqryVO);
		map.put("userId", usersVO.getUserId());
		map.put("mngrId", "testAdmin");
		
		return this.oneInqryMapper.oneInqrySuccessList(map);
	}
	
	
	@Override
	public int getTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		oneInqryVO.setUserId(usersVO.getUserId());
		
		map.put("oneInqryVO", oneInqryVO);
		map.put("userId", usersVO.getUserId());
		map.put("mngrId", "testAdmin");
		
		return this.oneInqryMapper.getTotal(map);
	}
	
	@Override
	public int getNoAnswerTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		oneInqryVO.setUserId(usersVO.getUserId());
		
		map.put("oneInqryVO", oneInqryVO);
		map.put("userId", usersVO.getUserId());
		map.put("mngrId", "testAdmin");
		
		return this.oneInqryMapper.getNoAnswerTotal(map);
	}
	
	@Override
	public int getSuccessTotal(Map<String, Object> map) {
		UsersVO usersVO = userChk((String)map.get("userId"));
		oneInqryVO.setUserId(usersVO.getUserId());
		
		map.put("oneInqryVO", oneInqryVO);
		map.put("userId", usersVO.getUserId());
		map.put("mngrId", "testAdmin");
		
		return this.oneInqryMapper.getSuccessTotal(map);
	}

	@Override
	public int oneInqryCreatePost(OneInqryVO oneInqryVO, List<MultipartFile> uploadFiles) {
		int res = 0;
		
		Map<String, Object>oneInqryInfoMap = new HashMap<String, Object>();
		
		oneInqryInfoMap.put("oneInqrySj", oneInqryVO.getOneInqrySj());
		oneInqryInfoMap.put("oneInqryCn", oneInqryVO.getOneInqryCn());
		oneInqryInfoMap.put("userId", oneInqryVO.getUserId());
		
		// 요청서 기본 정보
		res = this.oneInqryMapper.oneInqryCreatePost(oneInqryInfoMap);
		
		String addPath = "oneInqry\\oneInqryImage";
		res += fileuploadService.fileUpload(uploadFiles, addPath, oneInqryVO.getUserId(), res);
			
		return res;
	}

	@Override
	public OneInqryVO oneInqryDetail(OneInqryVO oneInqryVO, String userId) {
		
		UsersVO usersVO = userChk(userId);
		
		oneInqryVO.setUserId(usersVO.getUserId());
		
		return this.oneInqryMapper.oneInqryDetail(oneInqryVO);
	}

	@Override
	public int oneInqryUpdatePost(Map<String, Object> oneInqryUpdateMap, List<MultipartFile> uploadFiles, String userId) {
		int res = 0;
		// 문의 번호
		String oneInqryNo = (String)oneInqryUpdateMap.get("oneInqryNo");
		// 문의 변경 제목 
		String oneInqrySj = (String)oneInqryUpdateMap.get("hiddenOneInqrySj");
		// 문의 변경 내용
		String oneInqryCn = (String)oneInqryUpdateMap.get("newOneInqryCn");
		// 문의 첨부파일 번호
		String sprviseAtchmnflNo = (String)oneInqryUpdateMap.get("sprviseAtchmnflNo");
		
		
		// 사전문의 업데이트
		OneInqryVO oneInqryVO = new OneInqryVO();
		if(oneInqrySj != null || oneInqryCn != null) {
			oneInqryVO.setOneInqryNo(Integer.valueOf(oneInqryNo));
			oneInqryVO.setOneInqrySj(oneInqrySj);
			oneInqryVO.setOneInqryCn(oneInqryCn);

			res = this.oneInqryMapper.oneInqryUpdatePost(oneInqryVO);
		}
		
		// 기존 이미지 삭제
		Map<String, Object> updateFileuploadMap = new HashMap<String, Object>();
		
		String atchmnflNoArrayParam = (String) oneInqryUpdateMap.get("atchmnflNo[]");
		String[] atchmnflNoArray = atchmnflNoArrayParam.split(",");
		
		updateFileuploadMap.put("sprviseAtchmnflNo", sprviseAtchmnflNo);
		updateFileuploadMap.put("atchmnflNoArray", atchmnflNoArray);
		log.info("[btfInqryUpdatePost/serviceimpl] 기존 이미지 삭제 map : " + updateFileuploadMap);
		res += this.fileuploadService.updateFileupload(updateFileuploadMap);
		
		
		// 새로운 파일 업로드
		if(!uploadFiles.isEmpty()) {
			String addPath = "oneInqry\\oneInqryImage";
			res += fileuploadService.newFileUpload(uploadFiles, addPath, userId, res, sprviseAtchmnflNo);
		}
		return res;
	}

	@Override
	public int updateAnswer(Map<String, Object> updateParamMap, String userId) {
		return this.oneInqryMapper.updateAnswer(updateParamMap);
	}

	@Override
	public int resignPro(Map<String, Object> map) {
		return this.oneInqryMapper.resignPro(map);
	}

	@Override
	public List<OneInqryVO> resignProList(Map<String, Object> map) {
		return this.oneInqryMapper.resignProList(map);
	}

	@Override
	public int getTotalResignPro(Map<String, Object> map) {
		return this.oneInqryMapper.getTotalResignPro(map);
	}

	@Override
	public int proSecssion(String proId) {
		return this.oneInqryMapper.proSecssion(proId);
	}
	
	
}
