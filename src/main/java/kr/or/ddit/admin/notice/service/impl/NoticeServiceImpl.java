package kr.or.ddit.admin.notice.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.admin.notice.mapper.NoticeMapper;
import kr.or.ddit.admin.notice.service.NoticeService;
import kr.or.ddit.admin.notice.vo.NoticeVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	NoticeMapper noticeMapper;

	@Override
	public List<NoticeVO> getAllNoticeList() {
		// TODO Auto-generated method stub
		return this.noticeMapper.getAllNoticeList();
	}

	@Override
	public NoticeVO detail(int noticeNo) {
		// TODO Auto-generated method stub
		return this.noticeMapper.detail(noticeNo);
	}

	@Override
	public int update(NoticeVO noticeVO) {
		// TODO Auto-generated method stub
		return this.noticeMapper.update(noticeVO);
	}

	@Override
	public int delete(NoticeVO noticeVO) {
		// TODO Auto-generated method stub
		return this.noticeMapper.delete(noticeVO);
	}

	@Override
	public int createPost(NoticeVO noticeVO) {
		log.info("noticeVO:"+noticeVO);
		
		int result = this.noticeMapper.createPost(noticeVO);
		
		//원본파일명
		String uploadFileName = "";
		//Mime타입
		String mime = "";
		//seq 컬럼 카운터
		int seq = 1;
		
		MultipartFile[] uploadFile = noticeVO.getUploadFile();
		
		for(MultipartFile multipartFile : uploadFile){
			log.info("-----------");
			log.info("원본파일명:"+multipartFile.getOriginalFilename());
			log.info("MIME타입:"+multipartFile.getContentType());
			log.info("-----------");
			
			uploadFileName = multipartFile.getOriginalFilename();
			mime =multipartFile.getContentType();
			
			UUID uuid =UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			
			String userId = noticeVO.getMngrId();
			int sprviseAtchmnflNo = noticeVO.getSprviseAtchmnflNo();
			log.info("sprviseAtchmnflNo : " + sprviseAtchmnflNo);

			File saveFile = new File(uploadFolder+ "\\" + getFolder(),uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
				
				SprviseAtchmnflVO sprviseAtchmnflVO = new SprviseAtchmnflVO();
				sprviseAtchmnflVO.setSprviseAtchmnflNo(sprviseAtchmnflNo);
				sprviseAtchmnflVO.setAtchmnflNo(seq++);
				sprviseAtchmnflVO.setAtchmnflCours("/images/" + getFolder().replaceAll("\\\\", "/") + "/" 
						+ uploadFileName);
				
				sprviseAtchmnflVO.setAtchmnflNm(multipartFile.getOriginalFilename());
				sprviseAtchmnflVO.setStoreAtchmnflNm(uploadFileName);
				sprviseAtchmnflVO.setAtchmnflTy(mime);
				sprviseAtchmnflVO.setUserId(userId);
				
				log.info("sprviseAtchmnflVO : " + sprviseAtchmnflVO);

				result += this.noticeMapper.insertSprvise(sprviseAtchmnflVO);
				
			}catch(IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}

			
		}
		
		return result;
		
		
	}
	
	public String getFolder() {
		//2024-01-30 형식(format) 지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2024-01-30
		String str = sdf.format(date);
		//2024-01-30 -> 2024\\01\\30
		return str.replace("-", File.separator);
	}
	//이미지인지 판단. 
	/*
	 * public boolean checkImageType(File file) { String contentType; try {
	 * contentType = Files.probeContentType(file.toPath());
	 * log.info("contentType : " + contentType); //image/jpeg는 image로 시작함->true
	 * return contentType.startsWith("image"); } catch (IOException e) {
	 * e.printStackTrace(); } //이 파일이 이미지가 아닐 경우 return false; }
	 */
		

	@Override
	public int getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.noticeMapper.getTotal(map);
	}

	@Override
	public List<NoticeVO> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("map테스트 : " + map);
		return this.noticeMapper.list(map);
	}

	@Override
	public int increaseViewCount(int noticeNo) {
		// TODO Auto-generated method stub
		return this.noticeMapper.increaseViewCount(noticeNo);
	}

	@Override
	public NoticeVO sprviseAtchmnflVO(int noticeNo) {
		// TODO Auto-generated method stub
		return this.noticeMapper.sprviseAtchmnflVO(noticeNo);
	}
	
	

}
