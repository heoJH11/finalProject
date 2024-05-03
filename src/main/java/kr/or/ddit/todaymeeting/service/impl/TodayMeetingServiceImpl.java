package kr.or.ddit.todaymeeting.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.chatting.mapper.MessageMapper;
import kr.or.ddit.todaymeeting.VChatRoom;
import kr.or.ddit.todaymeeting.mapper.TodayMeetingMapper;
import kr.or.ddit.todaymeeting.service.TodayMeetingService;
import kr.or.ddit.vo.TdmtngChSpMshgVO;
import kr.or.ddit.vo.TdmtngPrtcpntVO;
import kr.or.ddit.vo.TdmtngVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TodayMeetingServiceImpl implements TodayMeetingService {

	@Inject
	String uploadFolder;

	@Inject
	private TodayMeetingMapper todayMeetingMapper;
	
	@Inject
	MessageMapper messageMapper;
	
	//모임 캘린더 조회
	@Override
	public List<TdmtngVO> findAll(String userId) {
		return this.todayMeetingMapper.findAll(userId);
	}
	
	//모임 캘린더 리스트 조회
	@Override
	public List<TdmtngVO> list(Map<String, Object> map) {
		// error : 파라미터로 map을 안 넣어줘서 keyword를 못 보내서 모든 리스트가 출력됐음
		return this.todayMeetingMapper.list(map);
	}
	
	//모임 상세 조회
	@Override
	public TdmtngVO detail(int tdmtngNo) {
		return this.todayMeetingMapper.detail(tdmtngNo);
	}
	
//	@Override
//	public int update(TdmtngVO tdmtngVO) {
//	
//		return this.todayMeetingMapper.update(tdmtngVO);
//	}
	
	//모임 생성
	@Override
	public int create(TdmtngVO tdmtngVO) {
		log.info("create : " + tdmtngVO);
		
		//formdata로 보내니 파일 업로드를 안 하면 upload파일이 null로 옴
		//null조건 추가..
		if (tdmtngVO.getUploadFile() != null && !tdmtngVO.getUploadFile().isEmpty()) {
		    log.info("이미지파일 처리하러~" + tdmtngVO.getUploadFile().getOriginalFilename());
		    imageUpload(tdmtngVO);
		}

		return this.todayMeetingMapper.create(tdmtngVO);
	}
	
	//모임 수정
	@Override
	public int update(TdmtngVO tdmtngVO) {
		log.info("update : " + tdmtngVO);
		if (!tdmtngVO.getUploadFile().getOriginalFilename().isEmpty()) {
			log.info("이미지파일 처리하러~" + tdmtngVO.getUploadFile().getOriginalFilename());
	        imageUpload(tdmtngVO);
	    }
		return this.todayMeetingMapper.update(tdmtngVO);
	}
	
	//모임 삭제
	@Override
	public int delete(int tdmtngNo) {
		return this.todayMeetingMapper.delete(tdmtngNo);
	}
	
	
	@Override
	public TdmtngPrtcpntVO selectMyChat(TdmtngPrtcpntVO tdmtngPrtcpntVO) {
		return this.todayMeetingMapper.selectMyChat(tdmtngPrtcpntVO);
	}
	
	@Override
	public int getTotal(Map<String,Object> map) {
		return this.todayMeetingMapper.getTotal(map);
	}
	


	@Override
	public int joinChat(TdmtngPrtcpntVO tdmtngPrtcpntVO) {
		
		TdmtngVO tdmtngVO = new TdmtngVO();
		
		log.info("입장 전{}" + tdmtngVO);
		
		tdmtngVO.setUserId(tdmtngPrtcpntVO.getUserId());
		tdmtngVO.setTdmtngNo(tdmtngPrtcpntVO.getTdmtngNo());
		int result = this.todayMeetingMapper.updateFirstMSG(tdmtngVO);
		
		log.info("입장 후 result :" + result);
		log.info("입장 후 tdmtngVO : " + tdmtngVO);
		
		return this.todayMeetingMapper.joinChat(tdmtngPrtcpntVO);
	}
	
	@Override
	public int chatMemCount(int tdmtngNo) {
		return this.todayMeetingMapper.chatMemCount(tdmtngNo);
	}

	@Override
	public List<TdmtngPrtcpntVO> chatMemList(int tdmtngNo) {
		return this.todayMeetingMapper.chatMemList(tdmtngNo);
	}
	
	public TdmtngVO imageUpload(TdmtngVO tdmtngVO) {

		// TdmtngVO의 MultipartFile uploadFile 가져오기
		MultipartFile multipartFile = tdmtngVO.getUploadFile();
		
		log.info("이미지 파일명 : " + multipartFile.getOriginalFilename());		
		log.info("이미지 크기 : " + multipartFile.getSize());
		log.info("MIME 타입 : " + multipartFile.getContentType());
		

		
		// 저장될 폴더 설정
		File uploadPath = new File(uploadFolder, getFolder());

		if (uploadPath.exists() == false) {// 폴더가 존재하지 않으면
			uploadPath.mkdirs();
		}

		String uploadFileName = multipartFile.getOriginalFilename();

		// java.util.UUID => 랜덤값 생성
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;

		File saveFile = new File(uploadPath, uploadFileName);
		// 파일 복사 실행
		try {
			multipartFile.transferTo(saveFile);

			tdmtngVO.setTdmtngThumbPhoto("/images/" + getFolder().replace("\\", "/") + "/" + uploadFileName);
			

			log.info("create -> tdmtngVO : " + tdmtngVO);

		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage());
		}
		
		return tdmtngVO;
	}

	private String getFolder() {
		// 2024-01-30 형식(format) 지정
		// 간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		// 2024-01-30
		String str = sdf.format(date);

		return str.replace("-", File.separator);

	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	@Override
	public List<VChatRoom> myList(String userId) {
		System.out.println("userId 유저 아이디 : " + userId);
		
		List<VChatRoom> myList = this.todayMeetingMapper.myList(userId);
		
		List<UsersVO> userInfo = this.todayMeetingMapper.getUserInfo(userId);
		
		for(VChatRoom chat : myList) {
			chat.setUserInfo(userInfo);
		}
				
		System.out.println("myList myList myList : " + myList);
		
		return myList;
	}
	
	@Override
	public VChatRoom join(int tdmtngNo , String userId) {
		
		VChatRoom list = this.todayMeetingMapper.join(tdmtngNo , userId);
		
		List<TdmtngPrtcpntVO> chatMemList = this.todayMeetingMapper.chatMemList(tdmtngNo);
		
		for(TdmtngPrtcpntVO test : chatMemList) {
			
			if(list.getUserId().equals(test.getUserId())) {
				
				list.setUserInfo(test.getUsersVOList());
				
			}
		
			log.info("테스트 : " + test);
		}
		
		System.out.println("방번호로 리스트 체크 : " + list);
		return list;
	}

	@Override
	public List<TdmtngChSpMshgVO> scrollTest(Map<String, Object> map) {
		
		
		return this.todayMeetingMapper.scrollTest(map);

	}

	@Override
	public int getTotalMsg(int tdmtngNo) {
		return this.todayMeetingMapper.getTotalMsg(tdmtngNo);
	}

}