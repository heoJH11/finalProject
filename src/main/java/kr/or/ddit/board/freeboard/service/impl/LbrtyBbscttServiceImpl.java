package kr.or.ddit.board.freeboard.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.board.freeboard.mapper.LbrtyBbscttMapper;
import kr.or.ddit.board.freeboard.service.LbrtyBbscttService;
import kr.or.ddit.vo.CommonCdDetailVO;
import kr.or.ddit.vo.LbrtyBbscttAnswerVO;
import kr.or.ddit.vo.LbrtyBbscttAnswerVO2;
import kr.or.ddit.vo.LbrtyBbscttVO;
import kr.or.ddit.vo.LbrtyBbscttVO2;
import kr.or.ddit.vo.SntncDeclVO;
import kr.or.ddit.vo.SprviseAtchmnfl;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LbrtyBbscttServiceImpl implements LbrtyBbscttService {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	LbrtyBbscttMapper lbrtyBbscttMapper;
	
	@Override
	public List<LbrtyBbscttVO2> lbrtyBbscttList() {
		return this.lbrtyBbscttMapper.lbrtyBbscttList();
		
	}

	@Override
	public LbrtyBbscttVO lbrtyBbscttDetail(int lbrtyBbscttNo) {
		return this.lbrtyBbscttMapper.lbrtyBbscttDetail(lbrtyBbscttNo);
	}

	@Transactional
	@Override
	public int lbrtyBbscttDelete(LbrtyBbscttVO lbrtyBbscttVO) {
		int result = 0;
		
		result += this.lbrtyBbscttMapper.lbrtyBbscttDelete(lbrtyBbscttVO);
		log.info("lbrtyBbscttDelete -> result : " + result);
		result += this.lbrtyBbscttMapper.sprviseAtchmnflDelete(lbrtyBbscttVO);
		
		return result;
	}

	@Override
	public int lbrtyBbscttInsert(LbrtyBbscttVO lbrtyBbscttVO) {
		/*
		 lbrtyBbscttVO : LbrtyBbscttVO(lbrtyBbscttNo=0, lbrtyBbscttSj=안녕하세요, 
		 lbrtyBbscttCn=<figure class="image"><img src="http://localhost/resources/upload/1e8a5dfe-b865-4b47-822c-88805ffd0161.png"></figure><p>안녕 친구</p>, lbrtyBbscttWrDt=null, lbrtyBbscttRdcnt=0, sprviseAtchmnflNo=0, userId=1111, 
		 uploadFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@3f496c2e, org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@4ec22da3])
		*/
		long size2 = 0;
		log.info("lbrtyBbscttVO : " + lbrtyBbscttVO);
		MultipartFile[] uploadFile = lbrtyBbscttVO.getFiles();
		for(MultipartFile multipartFile : uploadFile) {
			
			size2 += multipartFile.getSize();
		}
		log.info("multipartFile 사이즈 : " + size2);
		if(size2 > 0) {
			lbrtyBbscttVO.setSprviseAtchmnflNo(1);
		}
		log.info("lbrtyBbscttVOSprviseAtchmnflNo : " + lbrtyBbscttVO.getSprviseAtchmnflNo());
		
		
		int result = this.lbrtyBbscttMapper.lbrtyBbscttInsert(lbrtyBbscttVO); // 부모 테이블 1
		
		//원본 파일명
		String uploadFileName = "";
		
		//MIME타입
		String mime = "";
		//ATTACH 테이블의 SEQ컬럼을 위한 카운터 변수
		int seq = 1;
		long size = 0;
		
		log.info("uploadFile : " + uploadFile.toString());
		//스프링 파일 객체 배열로부터 스프링 파일 객체를 하나씩 가져와 본다
		//MultipartFile[] uploadFile
		
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------");
			log.info("원본 파일명 : " + multipartFile.getOriginalFilename());
			log.info("파일 크기    : " + multipartFile.getSize());
			log.info("MIME타입  : " + multipartFile.getContentType());
			
			size = multipartFile.getSize();
			if(size==0) {
				log.info("before result = " + result);
				return result;
			}
			uploadFileName = multipartFile.getOriginalFilename();
			mime = multipartFile.getContentType();
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File savePath = new File(uploadFolder + "\\" + getFolder());
			log.info("폴더 getFolder : " + getFolder());
			log.info("폴더 savePath : " + savePath);
	        if (!savePath.exists()) {
	            savePath.mkdirs();
	            log.info("해당 폴더가 없어서 생성했어요?");
	        }
			
			//File객체 설께(어디로 복사할것인지? 경로 지정)
			File saveFile = new File(uploadFolder + "\\" + getFolder(),uploadFileName);
			
			try {
				//파일 복사 실행
				//파일객체.복사하겠다 TO(saveFile)
				multipartFile.transferTo(saveFile);
				
				SprviseAtchmnfl sprviseAtchmnfl = new SprviseAtchmnfl();
				sprviseAtchmnfl.setAtchmnflNo(seq++);
				sprviseAtchmnfl.setAtchmnflCours("/images/"+getFolder().replace("\\", "/")+"/"+uploadFileName);
				log.info("setAtchmnflCours : " + sprviseAtchmnfl.getAtchmnflCours());
				sprviseAtchmnfl.setAtchmnflNm(multipartFile.getOriginalFilename());
				sprviseAtchmnfl.setStoreAtchmnflNm(uploadFileName);
				sprviseAtchmnfl.setAtchmnflTy(mime);
				sprviseAtchmnfl.setUserId(lbrtyBbscttVO.getUserId());
				log.info("sprviseAtchmnfl : " + sprviseAtchmnfl);
				
				result += this.lbrtyBbscttMapper.SprviseAtchmnflInsert(sprviseAtchmnfl);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
			
		}
		
		log.info("after2 result = " + result);
		return result;
		
		
		
	}
	//연/월/일 폴더 생성
	public String getFolder() {
		//2024-01-30 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2024-01-30
		String str = sdf.format(date);
		
		//2024-01-30 -> 2024\\01\\30
		return str.replace("-", File.separator);
	}

	//댓글 조회
	@Override
	public List<LbrtyBbscttAnswerVO> lbrtyBbscttAnswerList(String lbrtyBbscttNo) {
		return this.lbrtyBbscttMapper.lbrtyBbscttAnswerList(lbrtyBbscttNo);
	}
	//댓글 입력
	@Override
	public int lbrtyBbscttAnswerInsert(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO) {
		return this.lbrtyBbscttMapper.lbrtyBbscttAnswerInsert(lbrtyBbscttAnswerVO);
	}
	
	//댓글 삭제
	@Override
	public int lbrtyBbscttAnswerDelete(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO) {
		return this.lbrtyBbscttMapper.lbrtyBbscttAnswerDelete(lbrtyBbscttAnswerVO);
	}
	
	//댓글 수정
	@Override
	public int lbrtyBbscttAnswerUpdate(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO) {
		return this.lbrtyBbscttMapper.lbrtyBbscttAnswerUpdate(lbrtyBbscttAnswerVO);
	}
	
	//게시글 수정
	@Override
	public int lbrtyBbscttUpdate(LbrtyBbscttVO lbrtyBbscttVO) {
		int result = 0;
		long size2 = 0;
		log.info("lbrtyBbscttVO : " + lbrtyBbscttVO);
		MultipartFile[] uploadFile = lbrtyBbscttVO.getFiles();
		log.info("uploadFile : " + uploadFile);
		
		if(uploadFile==null || uploadFile.equals("")) {
			log.info("여기까지는 오니?");
			result = this.lbrtyBbscttMapper.lbrtyBbscttUpdate(lbrtyBbscttVO);
			return result;
		}
		//첨부파일이 있다면 첨부파일 번호를 여기에 첨부파일 번호를 일단 찍어보자
		log.info("getSprviseAtchmnflNo : " + lbrtyBbscttVO.getSprviseAtchmnflNo());
		int sprviseAtchmnflNo = lbrtyBbscttVO.getSprviseAtchmnflNo();
		log.info("getSprviseAtchmnflNo : " + sprviseAtchmnflNo);
		//통합 첨부파일 번호가 0 이라면 첨부파일 값을 nextval로 해서 받아온다 그리고 그것을 변수로 지정해준다
		if(sprviseAtchmnflNo==0) {
			sprviseAtchmnflNo = this.lbrtyBbscttMapper.sprviseAtchmnflNoNextval();
			lbrtyBbscttVO.setSprviseAtchmnflNo(sprviseAtchmnflNo);
			log.info("첨부파일 통합 번호를 셋팅 해준 VO의 값 lbrtyBbscttVO : " + lbrtyBbscttVO);
			
			this.lbrtyBbscttMapper.uptsprviseAtchmnflNo(lbrtyBbscttVO);
			
			log.info("sprviseAtchmnflNo : " + sprviseAtchmnflNo);
		}
		
		result += this.lbrtyBbscttMapper.lbrtyBbscttUpdate(lbrtyBbscttVO);
		log.info("파일이 있을때 도 업데이트를 해야되니 그때 result : " +  result);
		
		for(MultipartFile multipartFile : uploadFile) {
			
			size2 += multipartFile.getSize();
		}
		log.info("multipartFile 사이즈 : " + size2);
		if(size2 > 0) {
			lbrtyBbscttVO.setSprviseAtchmnflNo(lbrtyBbscttVO.getSprviseAtchmnflNo());
		}
		log.info("lbrtyBbscttVOSprviseAtchmnflNo : " + lbrtyBbscttVO.getSprviseAtchmnflNo());
		
		
		//int result = this.lbrtyBbscttMapper.lbrtyBbscttInsert(lbrtyBbscttVO); // 부모 테이블 1
		
		//원본 파일명
		String uploadFileName = "";
		
		//MIME타입
		String mime = "";
		//ATTACH 테이블의 SEQ컬럼을 위한 카운터 변수
		int seq = 1;
		long size = 0;
		
		log.info("uploadFile : " + uploadFile.toString());
		//스프링 파일 객체 배열로부터 스프링 파일 객체를 하나씩 가져와 본다
		//MultipartFile[] uploadFile
		
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------");
			log.info("원본 파일명 : " + multipartFile.getOriginalFilename());
			log.info("파일 크기    : " + multipartFile.getSize());
			log.info("MIME타입  : " + multipartFile.getContentType());
			
			size = multipartFile.getSize();
			log.info("업데이트 파일 사이즈 : " + size);
			if(size==0) {
				log.info("before result = " + result);
				return result;
			}
			
			uploadFileName = multipartFile.getOriginalFilename();
			log.info("업데이트 uploadFileName : " + uploadFileName);
			mime = multipartFile.getContentType();
			log.info("업데이트 mime : " + mime);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			// 폴더가 없을때 생성하는 것이 빠져있다..
			File savePath = new File(uploadFolder + "\\" + getFolder());
			log.info("폴더 getFolder : " + getFolder());
			log.info("폴더 savePath : " + savePath);
	        if (!savePath.exists()) {
	            savePath.mkdirs();
	            log.info("해당 폴더가 없어서 생성했어요?");
	        }
			
			//File객체 설께(어디로 복사할것인지? 경로 지정)
			File saveFile = new File(uploadFolder + "\\" + getFolder(),uploadFileName);
			log.info("업데이트 getFolder : " + getFolder());
			log.info("업데이트 saveFile : " + saveFile);
			try {
				//파일 복사 실행
				//파일객체.복사하겠다 TO(saveFile)
				multipartFile.transferTo(saveFile);
				
				SprviseAtchmnfl sprviseAtchmnfl = new SprviseAtchmnfl();
				sprviseAtchmnfl.setSprviseAtchmnflNo(sprviseAtchmnflNo);
				//sprviseAtchmnfl.setAtchmnflNo(seq++);
				sprviseAtchmnfl.setAtchmnflCours("/images/"+getFolder().replace("\\", "/")+"/"+uploadFileName);
				sprviseAtchmnfl.setAtchmnflNm(multipartFile.getOriginalFilename());
				sprviseAtchmnfl.setStoreAtchmnflNm(uploadFileName);
				sprviseAtchmnfl.setAtchmnflTy(mime);
				log.info("lbrtyBbscttVO.getUserId() : " + lbrtyBbscttVO.getUserId());
				sprviseAtchmnfl.setUserId(lbrtyBbscttVO.getUserId());
				log.info("sprviseAtchmnfl : " + sprviseAtchmnfl);
				
				result += this.lbrtyBbscttMapper.uptSprviseAtchmnflInsert(sprviseAtchmnfl);
				log.info("최종 result : " + result);
				
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
			
		}
		
		log.info("after2 result = " + result);
		return result;
		
		//return this.lbrtyBbscttMapper.lbrtyBbscttUpdate(lbrtyBbscttVO);
	}
	
	//대댓글 조회
	@Override
	public List<LbrtyBbscttAnswerVO2> ansAnsList(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO) {
		return this.lbrtyBbscttMapper.ansAnsList(lbrtyBbscttAnswerVO);
	}
	
	//대댓글 입력
	@Override
	public int ansAnsInt(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO) {
		return this.lbrtyBbscttMapper.ansAnsInt(lbrtyBbscttAnswerVO);
	}
	
	//대댓글 갯수조회
	@Override
	public int ansAnsCnt(LbrtyBbscttAnswerVO lbrtyBbscttAnswerVO) {
		return this.lbrtyBbscttMapper.ansAnsCnt(lbrtyBbscttAnswerVO);
	}
	
	//첨부파일 조회
	@Override
	public List<SprviseAtchmnfl> sprviseAtchmnflDetail(int sprviseAtchmnflNo) {
		return this.lbrtyBbscttMapper.sprviseAtchmnflDetail(sprviseAtchmnflNo);
	}

	@Override
	public int fileDel(SprviseAtchmnfl sprviseAtchmnfl) {
		return this.lbrtyBbscttMapper.fileDel(sprviseAtchmnfl);
	}

	@Override
	public List<SprviseAtchmnfl> detailfileList(String sprviseAtchmnflNo) {
		return this.lbrtyBbscttMapper.detailfileList(sprviseAtchmnflNo);
	}
	
	
	//페이징 처리하는 게시글 리스트
	@Override
	public List<LbrtyBbscttVO2> lbrtyBbscttListPage(Map<String, Object> map) {
		return this.lbrtyBbscttMapper.lbrtyBbscttListPage(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.lbrtyBbscttMapper.getTotal(map);
	}

	@Override
	public int declInsert(SntncDeclVO sntncDeclVO) {
		return this.lbrtyBbscttMapper.declInsert(sntncDeclVO);
	}

	@Override
	public List<CommonCdDetailVO> declComCdDeSelect() {
		return this.lbrtyBbscttMapper.declComCdDeSelect();
	}

	@Override
	public int cntUp(int lbrtyBbscttNo) {
		return this.lbrtyBbscttMapper.cntUp(lbrtyBbscttNo);
	}


}
