package kr.or.ddit.onedayclass.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.onedayclass.mapper.OnedayClassMapper;
import kr.or.ddit.onedayclass.service.OnedayClassService;
import kr.or.ddit.vo.BcityVO;
import kr.or.ddit.vo.BrtcVO;
import kr.or.ddit.vo.BundleOndyclVO;
import kr.or.ddit.vo.MberVO;
import kr.or.ddit.vo.OndyclReviewVO;
import kr.or.ddit.vo.OndyclVO;
import kr.or.ddit.vo.ReviewMberVO;
import kr.or.ddit.vo.ShopngBundleVO;
import kr.or.ddit.vo.SpcltyRealmVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.UserNcnmMberPhotoVO;
import kr.or.ddit.vo.VOndyclProUsersVO;
import kr.or.ddit.vo.VOndyclSchdulVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Service
public class OnedayClassServiceImpl implements OnedayClassService {
	
	@Autowired
	OnedayClassMapper onedayClassMapper;
	
	@Autowired
	String uploadFolder;

	@Override
	public List<VOndyclProUsersVO> vOndyclProUsersVOList() {
		return this.onedayClassMapper.vOndyclProUsersVOList();
	}

	@Override
	public int countOndycl() {
		return this.onedayClassMapper.countOndycl();
	}

	@Override
	public String getCodeNm(String codeCd) {
		return this.onedayClassMapper.getCodeNm(codeCd);
	}

	@Override
	public List<VOndyclProUsersVO> searchClass(Map<String, Object> searchMap) {
		return this.onedayClassMapper.searchClass(searchMap);
	}

	@Override
	public List<SpcltyRealmVO> category() {
		return this.onedayClassMapper.category();
	}

	@Override
	public List<BcityVO> getBcity() {
		return this.onedayClassMapper.getBcity();
	}

	@Override
	public List<BrtcVO> brtcSelect(String bcityCode) {
		return this.onedayClassMapper.brtcSelect(bcityCode);
	}

	@Override
	public VOndyclProUsersVO detail(String ondyclNo) {
		return this.onedayClassMapper.detail(ondyclNo);
	}

	@Override
	public int getAttachNo() {
		return this.onedayClassMapper.getAttachNo();
	}

	@Override
	public int addSprviseAtchmnfl(SprviseAtchmnflVO sprviseAtchmnflVO) {
		return this.onedayClassMapper.addSprviseAtchmnfl(sprviseAtchmnflVO);
	}

	@Override
	public int createOndycl(Map<String, Object> map) {
		return this.onedayClassMapper.createOndycl(map);
	}

	@Override
	public List<SprviseAtchmnflVO> fileList(String ondyclNo) {
		return this.onedayClassMapper.fileList(ondyclNo);
	}

	@Override
	public int getInsertClNum() {
		return this.onedayClassMapper.getInsertClNum();
	}

	@Override
	public int deleteClass(String classNO) {
		return this.onedayClassMapper.deleteClass(classNO);
	}
	
	@Transactional
	@Override
	public int updateOndycl(VOndyclSchdulVO vOndyclSchdulVO) {
//		log.info("업뎃 : " + vOndyclSchdulVO);
		Map<String, Object> map = new HashMap<String, Object>();
		int ondyclNo = vOndyclSchdulVO.getOndyclNo();
		SprviseAtchmnflVO sprviseAtchmnflVO = new SprviseAtchmnflVO();
		int sprviseAtchmnflNo = this.onedayClassMapper.getAttachNo();
//		int sprviseAtchmnflNo = this.onedayClassMapper.thisAttachNo(ondyclNo);
		int result = 0;
		String proId = vOndyclSchdulVO.getProId();
		String ondyclSchdulDe = vOndyclSchdulVO.getOndyclSchdulDe();
		ondyclSchdulDe = ondyclSchdulDe.replaceAll("-", "");
		
		map.put("ondyclNo",ondyclNo);
		map.put("ondyclNm",vOndyclSchdulVO.getOndyclNm());
		map.put("ondyclCn",vOndyclSchdulVO.getOndyclCn());
		map.put("ondyclPc",vOndyclSchdulVO.getOndyclPc());
		map.put("ondyclPsncpa",vOndyclSchdulVO.getOndyclPsncpa());
		map.put("proId",proId);
		map.put("ondyclSchdulDe",ondyclSchdulDe);
		map.put("ondyclSchdulBeginTime",vOndyclSchdulVO.getOndyclSchdulBeginTime());
		map.put("ondyclSchdulEndTime",vOndyclSchdulVO.getOndyclSchdulEndTime());
		map.put("ondyclAdres",vOndyclSchdulVO.getOndyclAdres());
		map.put("ondyclDetailAdres",vOndyclSchdulVO.getOndyclDetailAdres());
		map.put("ondyclZip",vOndyclSchdulVO.getOndyclZip());
		map.put("sprviseAtchmnflNo",sprviseAtchmnflNo);
		
		MultipartFile uploadFile = vOndyclSchdulVO.getUploadProfile();
		
//		log.info("uploadFile.getOriginalFilename().length() : " + uploadFile.getOriginalFilename().length());
		
		//썸네일 수정
		if(uploadFile.getOriginalFilename().length() > 0) {
//			log.info("썸네일 메소드 시작1");
			MultipartFile multipartFile = vOndyclSchdulVO.getUploadProfile();
			
			File uploadPath = new File(uploadFolder, getFolder());
			if(!uploadPath.exists()) {
				uploadPath.mkdirs();
			}
			 String uploadFileName = multipartFile.getOriginalFilename();
			 
			 UUID uuid = UUID.randomUUID();
			 uploadFileName = uuid.toString() + "_" + uploadFileName;
			 
			 File saveFile = new File(uploadPath, uploadFileName);
//			 log.info("프로필사진 이름  : " + saveFile);
			 try {
				multipartFile.transferTo(saveFile);
				
				if(checkImageType(saveFile)) {//이미지라면
					//설계
					FileOutputStream thumbnail = new FileOutputStream(
						new File(uploadPath, "s_"+uploadFileName)
					);
					//썸네일 생성
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),
							thumbnail,50,50);
					thumbnail.close();
				}
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			 
			 String url = "/images/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
			 
//			 log.info("썸네일 url : " + url);
			 map.put("ondyclThumbPhoto",url);
		}else {
//			log.info("썸네일 메소드 시작2");
			map.put("ondyclThumbPhoto",null);
		}//썸네일 사진 등록 끝
		
		MultipartFile[] multipartFileArr = vOndyclSchdulVO.getUploadFile();
//		log.info("multipartFileArr : " + multipartFileArr);
		//첨부파일(이미지들) 수정
		if(multipartFileArr[0].getOriginalFilename().length() > 0) {
//			log.info("첨부파일 메소드 시작");
			String originFileName = ""; //원본파일명
			String newFileName = "";
			String mimeType = ""; //파일 형식
			long size = 0; //파일 사이즈
			int seq = 1;
			
			//기존 이미지 삭제(ondyclNo : 11)
			int result2 = this.onedayClassMapper.deleteSprviseAtchmnfl(ondyclNo);
//			log.info("result2 : " + result2);
			
			for(MultipartFile uploadFiles : vOndyclSchdulVO.getUploadFile()) {
				originFileName = uploadFiles.getOriginalFilename();
				size = uploadFiles.getSize();
				mimeType = uploadFiles.getContentType();
				
				UUID uuid = UUID.randomUUID();
				newFileName = uuid.toString() + "_" + originFileName;
//				log.info("첨부파일 정보 : " + originFileName+"/"+size+"/"+mimeType+"/"+newFileName);
				File saveFiles = new File(uploadFolder + "\\" + getFolder(), newFileName);
				String url = "/images/" + getFolder().replace("\\", "/") + "/" + newFileName;
				try {
					uploadFiles.transferTo(saveFiles);
					sprviseAtchmnflVO.setSprviseAtchmnflNo(sprviseAtchmnflNo);
					sprviseAtchmnflVO.setAtchmnflCours(url);
					sprviseAtchmnflVO.setAtchmnflNm(originFileName);
					sprviseAtchmnflVO.setStoreAtchmnflNm(newFileName);
					sprviseAtchmnflVO.setAtchmnflTy(mimeType);
					sprviseAtchmnflVO.setAtchmnflNo(seq++);
					sprviseAtchmnflVO.setUserId(proId);
//					log.info("sprviseAtchmnflVO : " + sprviseAtchmnflVO);
					
					result += this.onedayClassMapper.addSprviseAtchmnfl(sprviseAtchmnflVO);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}//end for
		}else {
			int result2 = this.onedayClassMapper.deleteSprviseAtchmnfl(ondyclNo);
		}//첨부파일추가 끝
//		log.info("sql가기 직전 map : " + map);
		
		result += this.onedayClassMapper.updateOndycl(map);
		result += this.onedayClassMapper.updateOndyclSchdul(map);
		
//		log.info("원데이클래스 result 수 : " + result);
		
		return result;
	}
	
	public boolean checkImageType(File file) {
		//MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
		//MIME 타입 알아냄. .jpeg / .jpg의 MIME(ContentType)타입 : image/jpeg
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
//			log.info("contentType : " + contentType);
			//image/jpeg는 image로 시작함->true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}
	
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	@Transactional
	@Override
	public int buyClass(Map<String, Object> map) {
		int resveNo = this.onedayClassMapper.getResveNo();
		
		map.put("resveNo", resveNo);
//		log.info("결제때 map : " + map);
		int result = this.onedayClassMapper.buyClass(map); //구매 구매상세 결제 추가
		result += this.onedayClassMapper.plusndyclResvpa(map); //클래스 참여인원 +1
		
		return result;
	}
	
	

	@Override
	public List<VOndyclProUsersVO> memberOndyclList(Map<String, Object> map) {
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassMapper.memberOndyclList(map);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String todayStr = sdf.format(date);
		try {
		    Date today = sdf.parse(todayStr);

		    for(int i = 0; i < vOndyclProUsersVOList.size(); i++) {
		        Date ondyclSchdulDe = sdf.parse(vOndyclProUsersVOList.get(i).getOndyclSchdulDe());

		        boolean dayCheck = ondyclSchdulDe.before(today);
		        vOndyclProUsersVOList.get(i).setDayCheck(dayCheck);
//		        log.info("시간 비교 : " + todayStr + "/" + ondyclSchdulDe + " 불린 : " + dayCheck);
		    }
		} catch (ParseException e) {
		    e.printStackTrace();
		}
		
		return vOndyclProUsersVOList;
	}

	@Override
	public int countMberMyClass(Map<String, Object> map) {
		return this.onedayClassMapper.countMberMyClass(map);
	}
	
	@Override
	public List<VOndyclProUsersVO> proMyClassList(Map<String, Object> map) {
		
//		log.info("impl map " + map);
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassMapper.proMyClassList(map);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String todayStr = sdf.format(date);
		try {
		    Date today = sdf.parse(todayStr);

		    for(int i = 0; i < vOndyclProUsersVOList.size(); i++) {
		        Date ondyclSchdulDe = sdf.parse(vOndyclProUsersVOList.get(i).getOndyclSchdulDe());

		        boolean dayCheck = ondyclSchdulDe.before(today);
		        vOndyclProUsersVOList.get(i).setDayCheck(dayCheck);
//		        log.info("시간 비교 : " + todayStr + "/" + ondyclSchdulDe + " 불린 : " + dayCheck);
		    }
		} catch (ParseException e) {
		    e.printStackTrace();
		}
		
		return vOndyclProUsersVOList;
	}

	@Override
	public int countProMyClass(Map<String, Object> map) {
		return this.onedayClassMapper.countProMyClass(map);
	}

	@Override
	public int resveCheck(Map<String, Object> mberOndyclMap) {
		return this.onedayClassMapper.resveCheck(mberOndyclMap);
	}

	@Override
	public int mberClassCancel(Map<String, Object> map) {
		int result = this.onedayClassMapper.mberClassCancel(map);
		return result;
	}

	@Override
	public String mberReviewTitle(int ondyclNo) {
		return this.onedayClassMapper.mberReviewTitle(ondyclNo);
	}

	@Override
	public int createReview(OndyclReviewVO ondyclReviewVO) {
		int result = this.onedayClassMapper.createReview(ondyclReviewVO);
		
		return result;
	}

	@Override
	public List<ReviewMberVO> reviewList(int ondyclNo) {
		List<ReviewMberVO> reviewMberVOList = this.onedayClassMapper.reviewList(ondyclNo);
//		log.info("리뷰 리스트 : " + reviewMberVOList);
		
		for(ReviewMberVO reMbVO : reviewMberVOList) {
			String wrDate = reMbVO.getOndyclReWrDt();
			
			wrDate.replace("-", ".");
//			wrDate.replaceFirst("0", "2");
			wrDate = "2" + wrDate.substring(1);
//			log.info("날짜 형식 확인 : " + wrDate);
			
			reMbVO.setOndyclReWrDt(wrDate);
		}
		
		return reviewMberVOList;
	}

	@Override
	@Transactional
	public List<BundleOndyclVO> mberShoppingCart(Map<String, Object> map) {
		List<BundleOndyclVO> shopngBundleVOList = this.onedayClassMapper.mberShoppingCart(map);
		String userId;
		String userNcnm;
		
		for(BundleOndyclVO bundleOndyclVO : shopngBundleVOList) {
			userId = bundleOndyclVO.getProId();
			
			userNcnm = this.onedayClassMapper.getUserNcnm(userId);
			bundleOndyclVO.setUserNcnm(userNcnm);
		}
		
		return shopngBundleVOList;
	}

	@Override
	public int countShoppingCart(Map<String, Object> map) {
		return this.onedayClassMapper.countShoppingCart(map);
	}

	@Override
	public int putShoppingCart(ShopngBundleVO shopngBundleVO) {
		return this.onedayClassMapper.putShoppingCart(shopngBundleVO);
	}

	@Override
	public int classBundleCk(Map<String, Object> mberOndyclMap) {
		return this.onedayClassMapper.classBundleCk(mberOndyclMap);
	}

	@Override
	public VOndyclSchdulVO priceCk(int ondyclNo) {
		return this.onedayClassMapper.priceCk(ondyclNo);
	}

	@Override
	public int delBundle(Map<String, Object> map) {
		return this.onedayClassMapper.delBundle(map);
	}

	@Override
	public int buyBundle(Map<String, Object> map) {
		log.info("넘어온 맵 : " + map);
		int result = 0;
		VOndyclSchdulVO vOndyclSchdulVO = new VOndyclSchdulVO();
		
		List<Integer> arrClassNo = (List<Integer>) map.get("checkList");
		log.info("배열 : " + arrClassNo + " / " + arrClassNo.size());
		
		Map<String, Object> buyMap = new HashMap<String, Object>();
		buyMap.put("mberId",map.get("mberId"));
		buyMap.put("setleNo",map.get("setleNo"));
		
		for(int i=0; i<arrClassNo.size(); i++) {
			int resveNo = this.onedayClassMapper.getResveNo();
			Object item = arrClassNo.get(i);
		    int ondyclNo;
		    if (item instanceof String) {
		        ondyclNo = Integer.parseInt((String) item);
		    } else if (item instanceof Integer) {
		        ondyclNo = (Integer) item;
		    } else {
		        // 예외 처리 또는 로그를 남김
		        continue; // 또는 적절한 오류 처리
		    }
			log.info("각 넘버 : " + arrClassNo.get(i));
			vOndyclSchdulVO = this.onedayClassMapper.priceCk(ondyclNo);
			
			buyMap.put("ondyclNo",ondyclNo);
			buyMap.put("resveNo",resveNo);
			buyMap.put("resveTpprice",vOndyclSchdulVO.getOndyclPc());
			buyMap.put("ondyclSchdulNo",vOndyclSchdulVO.getOndyclSchdulNo());
			
			log.info("결제처리 buyMap : " + buyMap);
			result += this.onedayClassMapper.buyClass(buyMap);
			result += this.onedayClassMapper.plusndyclResvpa(buyMap);
			
			//장바구니에서 삭제
			result += this.onedayClassMapper.delBundle(buyMap);
		}
		
		return result;
	}

	@Override
	public int getTotalPrice(Map<String, Object> map) {
		return this.onedayClassMapper.getTotalPrice(map);
	}

	@Override
	public double getTotalStar(Map<String, Object> map) {
		return this.onedayClassMapper.getTotalStar(map);
	}
	
	@Override
	public int getTotalUser(Map<String, Object> map) {
		return this.onedayClassMapper.getTotalUser(map);
	}

	@Override
	public int getMonthTotalUser(Map<String, Object> map) {
		return this.onedayClassMapper.getMonthTotalUser(map);
	}

	@Override
	public int getMonthTotalPrice(Map<String, Object> map) {
		return this.onedayClassMapper.getMonthTotalPrice(map);
	}

	@Override
	public List<UserNcnmMberPhotoVO> getBuyer(String ondyclNo) {
		return this.onedayClassMapper.getBuyer(ondyclNo);
	}

	@Override
	public List<OndyclVO> getOndyclRank() {
		List<OndyclVO> ondyclVOList = this.onedayClassMapper.getOndyclRank();
		
		
		return ondyclVOList;
	}

	@Override
	public String getPeopleCheck(int ondyclNo) {
		return this.onedayClassMapper.getPeopleCheck(ondyclNo);
	}


	
	
	
	
	
	
}
