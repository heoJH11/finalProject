package kr.or.ddit.pro.prtFolio.service.Impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.pro.prtFolio.mapper.PrtfolioMapper;
import kr.or.ddit.pro.prtFolio.service.PrtfolioService;
import kr.or.ddit.vo.PrtfolioVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PrtfolioServiceImpl implements PrtfolioService {
	@Autowired
	String uploadFolder;
	
	@Autowired
	PrtfolioMapper prtfolioMapper;
	
	@Override
	public int createPost(PrtfolioVO prtfolioVO) {

		int result = this.prtfolioMapper.createPost(prtfolioVO);
		
		//원본파일명
		String uploadFileName = "";
		//MIME타입
		String mime = "";
		//seq컬럼 카운터
		int seq = 1;
		
		MultipartFile[] uploadFile = prtfolioVO.getUploadFile();
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("-------------------");
			log.info("원본 파일 명 : " + multipartFile.getOriginalFilename());
			log.info("MIMME타입 : " + multipartFile.getContentType());
			log.info("-------------------");
			
			uploadFileName = multipartFile.getOriginalFilename();
			mime = multipartFile.getContentType();
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			String userId =prtfolioVO.getProId();
			int sprviseAtchmnflNo = prtfolioVO.getSprviseAtchmnflNo();
			log.info("sprviseAtchmnflNo : " + sprviseAtchmnflNo);
			
			File saveFile = new File(uploadFolder + "\\" + getFolder(),uploadFileName);
			
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
				
				result += this.prtfolioMapper.insertSprvise(sprviseAtchmnflVO);
				
				log.info("createPost2->prtfolioVO : " + prtfolioVO );
				log.info("sprviseAtchmnflVO2 : " + sprviseAtchmnflVO);
			}catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
			
		}
		return result;
		
	}

	//연/월/일 폴더 생성
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
	public boolean checkImageType(File file) {
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//image/jpeg는 image로 시작함->true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}

	@Override
	public int deletePrt(int sprviseAtchmnflNo) {
		return this.prtfolioMapper.deletePrt(sprviseAtchmnflNo);
	}
	
}
