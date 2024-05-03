package kr.or.ddit.board.pro_story.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.board.pro_story.mapper.ProStoryMapper;
import kr.or.ddit.board.pro_story.service.ProStoryService;
import kr.or.ddit.board.pro_story.vo.GoodPointVO;
import kr.or.ddit.board.pro_story.vo.ProStoryBbscttVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Service
public class ProStoryServiceImpl implements ProStoryService {

	@Inject
	String uploadFolder;

	@Inject
	ProStoryMapper proStoryMapper;

	@Override
	@Transactional
	public int insert(ProStoryBbscttVO proStoryBbscttVO, MultipartHttpServletRequest multi) {

		int result = 0;

		MultipartFile multipartFile = proStoryBbscttVO.getUploadFile();

		log.info("proStoryBbscttVO : " + proStoryBbscttVO);
		// 스프링 파일 객체
		log.info("MIME 타입   : " + multipartFile.getContentType());

		// 연월일 폴더 생성 설계 ... \\upload \\ 2024 \\ 01 \\ 30
		File uploadPath = new File(uploadFolder, getFolder());
		// 연월일 폴더 생성 실행
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		String uploadFileName = multipartFile.getOriginalFilename();
		// 파일명 중복 방지 -> 같은 날 같은 이미지 업로드 시 파일명 중복 방지 시작----------------
		// java.util.UUID => 랜덤값 생성
		UUID uuid = UUID.randomUUID();
		// 원래의 파일 이름과 구분하기 위해 _를 붙임(sdafjasdlfksadj_개똥이.jpg)
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		// 같은 날 같은 이미지 업로드 시 파일 중복 방지 끝----------------

		// 설계 -> , 의 역할 : \\
		// uploadFolder : ...upload\\2024\\01\\30 + \\ + 개똥이.jpg
//		File saveFile = new File(uploadFolder + "\\" + multipartFile.getOriginalFilename());
//		↕↕↕↕↕↕↕ 동일
		File saveFile = new File(uploadPath, uploadFileName);
		log.info("uploadPath : " + uploadPath);
		log.info("uploadFileName : " + uploadFileName);
		// 스프링파일객체.transferTo -> 실제 파일을 복사하기 때문에 try-catch로 예외처리 해야한다
		try {

			multipartFile.transferTo(saveFile);
			// 썸네일 처리 -> 이미지만 가능하기때문에 이미지인지 사전체크
			if (checkImageType(saveFile)) { // 이미지가 맞다면
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				// 썸네일 생성 -> 기존 이미지를 해당 사이즈로 축소시킨다(400 * 400)
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 300, 300);
				thumbnail.close();
			};
			// /2024/01/30 sdafjasdlfksadj_개똥이.jpg
//			proStoryBbscttVO.setProStoryBbscttThumbPhoto(uploadPath + getFolder().replace("\\" , "/") + "/"	+ uploadFileName);
			// getFolder() : 2024\\04\\01(윈도우경로) => 2024/04/01(웹경로)
			proStoryBbscttVO
					.setProStoryBbscttThumbPhoto("/" + getFolder().replace("\\", "/") + "/" + "s_" + uploadFileName);

			result = this.proStoryMapper.insert(proStoryBbscttVO);

			log.info("proStoryBbscttVO -> result : " + result);
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage());
		}
		return result;
	}

	@Override
	@Transactional
	public List<ProStoryBbscttVO> storyList() {

		if (this.proStoryMapper.storyList() == null) {
			return null;
		}
		return this.proStoryMapper.storyList();
	}

	@Override
	@Transactional
	public ProStoryBbscttVO getStory(int storyNo) {

		ProStoryBbscttVO proStoryBbscttVO = this.proStoryMapper.getStory(storyNo);

		log.info("프로 데이터 확인 : " + proStoryBbscttVO);

		return proStoryBbscttVO;
	}

	@Override
	@Transactional
	public List<ProStoryBbscttVO> getPage(Map<String, Object> searchParam) {
		
		int getTotal = this.proStoryMapper.getTotal();
		
		System.out.println("데이터 잘 오나확인  ServiceImpl : " + searchParam);
		
		searchParam.put("totalPages", getTotal);
		
		List<ProStoryBbscttVO> getStory = this.proStoryMapper.getPage(searchParam);
		
		System.out.println("최종값??!: " + searchParam);
		
		return getStory;
	}

	/* 수정해야함.. 임시로 하드코딩 */
	@Override
	@Transactional
	public int updateStory(ProStoryBbscttVO proStoryBbscttVO, MultipartHttpServletRequest multi) {

		int result = 0;

		MultipartFile multipartFile = proStoryBbscttVO.getUploadFile();

		log.info("proStoryBbscttVO : " + proStoryBbscttVO);
		// 스프링 파일 객체

		// 연월일 폴더 생성 설계 ... \\upload \\ 2024 \\ 01 \\ 30
		File uploadPath = new File(uploadFolder, getFolder());
		// 연월일 폴더 생성 실행
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		if (multipartFile != null && !multipartFile.isEmpty()) {
			String uploadFileName = multipartFile.getOriginalFilename();

			System.out.println("fileName ::: " + uploadFileName);
			// 파일명 중복 방지 -> 같은 날 같은 이미지 업로드 시 파일명 중복 방지 시작----------------
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			// 같은 날 같은 이미지 업로드 시 파일 중복 방지 끝----------------

			// 설계 -> , 의 역할 : \\
			// uploadFolder : ...upload\\2024\\01\\30 + \\ + 개똥이.jpg
			//		File saveFile = new File(uploadFolder + "\\" + multipartFile.getOriginalFilename());
			//		↕↕↕↕↕↕↕ 동일
			File saveFile = new File(uploadPath, uploadFileName);
			log.info("uploadPath : " + uploadPath);
			log.info("uploadFileName : " + uploadFileName);

			try {

				multipartFile.transferTo(saveFile);
				// 썸네일 처리 -> 이미지만 가능하기때문에 이미지인지 사전체크
				if (checkImageType(saveFile)) { // 이미지가 맞다면

					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					// 썸네일 생성 -> 기존 이미지를 해당 사이즈로 축소시킨다(300 * 300)
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 450, 450);
					thumbnail.close();
				};

				// getFolder() : 2024\\04\\01(윈도우경로) => 2024/04/01(웹경로)
				proStoryBbscttVO.setProStoryBbscttThumbPhoto(
						"/" + getFolder().replace("\\", "/") + "/" + "s_" + uploadFileName);
				// uuid가 적용된 파일명
				result = this.proStoryMapper.updateStory(proStoryBbscttVO);
				log.info("proStoryBbscttVO -> 수정 결과 result : " + result);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}
		return result;
	}

	@Override
	@Transactional
	public int deleteStory(String userId, int storyNo) {
		return this.proStoryMapper.deleteStory(userId, storyNo);
	}

	@Override
	@Transactional
	public int getStoryCount(int storyNo) {
		return this.proStoryMapper.getStoryCount(storyNo);
	}

	@Override
	@Transactional
	public ProStoryBbscttVO updateGood(GoodPointVO goodPointVO) {

		ProStoryBbscttVO psbcttVO = new ProStoryBbscttVO();

		psbcttVO.setProStoryBbscttNo(goodPointVO.getProStoryBbscttNo());

		this.proStoryMapper.goodUp(psbcttVO);
		int result = this.proStoryMapper.goodSave(goodPointVO);

		if (result > 0) {
			log.info("♥ 추가 성공!!");
			psbcttVO = this.proStoryMapper.goodCount(psbcttVO);
		} else {
			log.info("♡ 추가 실패");
			return null;
		}
		System.out.println("하트 추가 후 해당글 추천수 : " + psbcttVO.getProStoryBbscttRecommend());
		return psbcttVO;
	}

	@Override
	@Transactional
	public ProStoryBbscttVO goodRemove(GoodPointVO goodPointVO) {

		ProStoryBbscttVO psbcttVO = new ProStoryBbscttVO();

		psbcttVO.setProStoryBbscttNo(goodPointVO.getProStoryBbscttNo());

		this.proStoryMapper.goodDown(psbcttVO);

		int result = this.proStoryMapper.goodRemove(goodPointVO);

		System.out.println("하트삭제 성공 : " + result);

		if (result > 0) {
			psbcttVO = this.proStoryMapper.goodCount(psbcttVO);
		}
		System.out.println("하트 삭제 후 해당글 추천수 : " + psbcttVO.getProStoryBbscttRecommend());
		return psbcttVO;
	}

	public boolean checkImageType(File file) {
		// MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
		// MIME 타입 알아냄. .jpeg / .jpg의 MIME타입 : image/jpeg
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			// image/jpeg는 image로 시작함->true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 이 파일이 이미지가 아닐 경우
		return false;
	}

	public String getFolder() {

		String fmtNow = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		log.info("fmtNow ::: " + fmtNow);

		return fmtNow.replace("-", File.separator);

	}

	@Override
	@Transactional
	public int getTotal() {
		return this.proStoryMapper.getTotal();
	}

	@Override
	public int getGoodCheck(GoodPointVO goodPointVO) {
		return this.proStoryMapper.getGoodCheck(goodPointVO);
	}
	@Override
	public List<ProStoryBbscttVO> getPageTest(Map<String , Object> map){
		
		log.info("getPageTest : " + map);
		
		return this.proStoryMapper.getPageTest(map);
	}
	@Override
	public List<ProStoryBbscttVO> getWeekRecommend(){
		
		return this.proStoryMapper.getWeekRecommend();
		
	}

}
