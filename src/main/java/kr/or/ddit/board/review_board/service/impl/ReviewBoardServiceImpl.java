package kr.or.ddit.board.review_board.service.impl;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.board.freeboard.controller.UploadController;
import kr.or.ddit.board.review_board.mapper.ReviewBoardMapper;
import kr.or.ddit.board.review_board.service.ReviewBoardService;
import kr.or.ddit.vo.AftusBbscttAnswerVO;
import kr.or.ddit.vo.AftusBbscttVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.SrvcRequstVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReviewBoardServiceImpl implements ReviewBoardService {
	
	@Inject
	String uploadFolder;

	@Inject
	ReviewBoardMapper reviewBoardMapper;
	
	@Inject
	UploadController uploadController;

	MultipartHttpServletRequest request;
	
	@Override
	public List<AftusBbscttVO> list(Map<String, Object> map) {
		return this.reviewBoardMapper.list(map);
	}

	@Override
	public List<SrvcRequstVO> listModal(String userId) {
		return this.reviewBoardMapper.listModal(userId);
	}
	
	//로그인한 회원 리뷰 조회
	@Override
	public List<AftusBbscttVO> listMyReview(String userId) {
		return this.reviewBoardMapper.listMyReview(userId);
	}
	
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.reviewBoardMapper.getTotal(map);
	}

	
	@Override
	public int create(AftusBbscttVO aftusBbscttVO) {
		
		return this.reviewBoardMapper.create(aftusBbscttVO);
	}

	@Override
	public AftusBbscttVO detail(int aftusBbscttNo) {
		return this.reviewBoardMapper.detail(aftusBbscttNo);
	}

	@Override
	public int delete(int aftusBbscttNo) {
		return this.reviewBoardMapper.delete(aftusBbscttNo);
	}
	
	@Override
	public int update(AftusBbscttVO aftusBbscttVO) {
		
		int result = 0;
		
		int sprviseAtchmnflNo = aftusBbscttVO.getSprviseAtchmnflNo();
		
		log.info("updateSprviseAtchmnflNo" + sprviseAtchmnflNo);
		
		MultipartFile[] uploadFile = aftusBbscttVO.getUploadFile();
		if(uploadFile == null || uploadFile.length == 0 || uploadFile[0].isEmpty()) {				
			  result = this.reviewBoardMapper.update(aftusBbscttVO);
		} else {
		 
		//원본 파일명
		String originalFilename = "";
		//저장될파일명
		String uploadFileName = "";
		//파일 크기
		long size = 0;
		//MIME타입
		String mime = "";
		//sql 성공한 행의 수
				
		
		result = this.reviewBoardMapper.update(aftusBbscttVO);
		
		String userId = aftusBbscttVO.getUserId();
		
		uploadFile = aftusBbscttVO.getUploadFile();
		
		
		SprviseAtchmnflVO sprviseAtchmnflVO = new SprviseAtchmnflVO();
		log.info("AtchmnflNo : " + sprviseAtchmnflVO.getAtchmnflNo());
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("--------------");
			log.info("원본 파일명 : " + multipartFile.getOriginalFilename());
			log.info("파일 크기    : " + multipartFile.getSize());
			log.info("MIME타입  : " + multipartFile.getContentType());
			
			originalFilename = multipartFile.getOriginalFilename();
			size = multipartFile.getSize();
			mime = multipartFile.getContentType();
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + originalFilename;
			
			//File 객체 설계 (어디로 복사할 것인지? 경로)
//			File saveFile = new File(uploadDirect + "\\" + getFolder(), uploadFileName);
			
			
			File uploadPath = new File(uploadFolder, getFolder());
			File saveFile = new File(uploadPath, uploadFileName);
			try {
			     
				multipartFile.transferTo(saveFile);
				
				//ATTACH테이블에 insert
//				sprviseAtchmnflVO.setAtchmnflNo(atchmnflNo++);
				
				sprviseAtchmnflVO.setAtchmnflCours("/images/" + getFolder().replace("\\", "/") + "/"
						+ uploadFileName);  
				sprviseAtchmnflVO.setAtchmnflNm(originalFilename);
				sprviseAtchmnflVO.setStoreAtchmnflNm(uploadFileName);
				sprviseAtchmnflVO.setAtchmnflTy(mime);
				sprviseAtchmnflVO.setSprviseAtchmnflNo(sprviseAtchmnflNo);
				sprviseAtchmnflVO.setUserId(userId);			
				
				if(aftusBbscttVO.getSprviseAtchmnflNo()==0) {
					//기존에 첨부파일이 없다면 insert
					log.info("인서트?");
					result += this.reviewBoardMapper.insertFile(sprviseAtchmnflVO);
				} else {
					//기존 첨부파일이 있다면 update
					log.info("업데이트?");
				result += this.reviewBoardMapper.updateFile(sprviseAtchmnflVO);
				}			
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage());
				}
			}
		/*
		 * log.info("insert : " + aftusBbscttVO); if
		 * (aftusBbscttVO.getUploadFile().length != 0) { log.info("이미지파일 처리하러~" +
		 * aftusBbscttVO.getUploadFile().length); fileUpload(aftusBbscttVO); }
		 */
		}
		return result;		
	}

	@Override
	public int updateCnt(int aftusBbscttNo) {
		return this.reviewBoardMapper.updateCnt(aftusBbscttNo);
	}
	
	@Override
	public List<SprviseAtchmnflVO> fileList(int sprviseAtchmnflNo) {
		
		return this.reviewBoardMapper.fileList(sprviseAtchmnflNo);
	}
	
	@Override
	public int fileDel(SprviseAtchmnflVO sprviseAtchmnflVO) {
		return this.reviewBoardMapper.fileDel(sprviseAtchmnflVO);
	}

	
	

	@Override
	public int createAjax(AftusBbscttVO aftusBbscttVO) {
		int result = 0;
		//파일을 올리든 안 올리든 sprviseAtchmnflNo=0으로 vo에 담겨서
		//db에 파일이 없어도 nextval 되어 데이터가 추가되는 이슈
		//uploadFile이 없을 경우 처리를 해줌
		MultipartFile[] uploadFile = aftusBbscttVO.getUploadFile();
		log.info("uploadFile : " + uploadFile);
		if(uploadFile == null || uploadFile.length == 0 || uploadFile[0].isEmpty()) {	
			  aftusBbscttVO.setSprviseAtchmnflNo(1);
			  log.info("setSprviseAtchmnflNo : " + aftusBbscttVO.getSprviseAtchmnflNo());
			  result = this.reviewBoardMapper.createAjax(aftusBbscttVO);
		} else {
		//원본 파일명
		String originalFilename = "";
		//저장될파일명
		String uploadFileName = "";
		//파일 크기
		long size = 0;
		//MIME타입
		String mime = "";
		//sql 성공한 행의 수
				
				
//		int result = this.reviewBoardMapper.createAjax(aftusBbscttVO);
		
		int atchmnflNo = 1;
		
		String userId = aftusBbscttVO.getUserId();
		
		result = this.reviewBoardMapper.createAjax(aftusBbscttVO);
		
		uploadFile = aftusBbscttVO.getUploadFile();
				
		for(MultipartFile multipartFile : uploadFile) {
			log.info("--------------");
			log.info("원본 파일명 : " + multipartFile.getOriginalFilename());
			log.info("파일 크기    : " + multipartFile.getSize());
			log.info("MIME타입  : " + multipartFile.getContentType());
			
			originalFilename = multipartFile.getOriginalFilename();
			size = multipartFile.getSize();
			mime = multipartFile.getContentType();
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + originalFilename;
			
			File uploadPath = new File(uploadFolder, getFolder());

			if (uploadPath.exists() == false) {// 폴더가 존재하지 않으면
				uploadPath.mkdirs();
			}
			
			//File 객체 설계 (경로)
			File saveFile = new File(uploadFolder + "\\" + getFolder(), uploadFileName);
			
			
			try {
			     
				multipartFile.transferTo(saveFile);
				
				//ATTACH테이블에 insert
				SprviseAtchmnflVO sprviseAtchmnflVO = new SprviseAtchmnflVO();
				
				sprviseAtchmnflVO.setAtchmnflNo(atchmnflNo++);
				sprviseAtchmnflVO.setAtchmnflCours("/images/" + getFolder().replace("\\", "/") + "/"
						+ uploadFileName);  
				sprviseAtchmnflVO.setAtchmnflNm(originalFilename);
				sprviseAtchmnflVO.setStoreAtchmnflNm(uploadFileName);
				sprviseAtchmnflVO.setAtchmnflTy(mime);
				
				sprviseAtchmnflVO.setUserId(userId);			
				
				result += this.reviewBoardMapper.insertFile(sprviseAtchmnflVO);
							
				} catch (IllegalStateException | IOException e) {
					log.error(e.getMessage());
				}
			}

		/*
		 * log.info("insert : " + aftusBbscttVO); if
		 * (aftusBbscttVO.getUploadFile().length != 0) { log.info("이미지파일 처리하러~" +
		 * aftusBbscttVO.getUploadFile().length); fileUpload(aftusBbscttVO); }
		 */
		}

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

	@Override
	public List<AftusBbscttAnswerVO> aftusBbscttAnswerList(int aftusBbscttNo) {
		return this.reviewBoardMapper.aftusBbscttAnswerList(aftusBbscttNo);
	}

	@Override
	public int aftusBbscttAnswerInsert(AftusBbscttAnswerVO aftusBbscttAnswerVO) {
		return this.reviewBoardMapper.aftusBbscttAnswerInsert(aftusBbscttAnswerVO);
	}

	@Override
	public int aftusBbscttAnswerDelete(int aftusBbscttAnswerNo) {
		return this.reviewBoardMapper.aftusBbscttAnswerDelete(aftusBbscttAnswerNo);
	}

	@Override
	public int aftusBbscttAnswerUpdate(AftusBbscttAnswerVO aftusBbscttAnswerVO) {
		return this.reviewBoardMapper.aftusBbscttAnswerUpdate(aftusBbscttAnswerVO);
	}

	@Override
	public List<AftusBbscttAnswerVO> ansAnsList(int ptAftusBbscttAnswerNo) {
		return this.reviewBoardMapper.ansAnsList(ptAftusBbscttAnswerNo);
	}

	@Override
	public int ansAnsInt(AftusBbscttAnswerVO aftusBbscttAnswerVO) {
		return this.reviewBoardMapper.ansAnsInt(aftusBbscttAnswerVO);
	}

	@Override
	public int ansAnsCnt(int ptAftusBbscttAnswerNo) {
		return this.reviewBoardMapper.ansAnsCnt(ptAftusBbscttAnswerNo);
	}




	

}
