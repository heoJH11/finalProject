package kr.or.ddit.onedayclass.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.onedayclass.service.OnedayClassService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.OndyclPage;
import kr.or.ddit.vo.BcityVO;
import kr.or.ddit.vo.BrtcVO;
import kr.or.ddit.vo.BundleOndyclVO;
import kr.or.ddit.vo.MberVO;
import kr.or.ddit.vo.OndyclReviewVO;
import kr.or.ddit.vo.ReviewMberVO;
import kr.or.ddit.vo.ShopngBundleVO;
import kr.or.ddit.vo.SpcltyRealmVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import kr.or.ddit.vo.UserNcnmMberPhotoVO;
import kr.or.ddit.vo.VOndyclProUsersVO;
import kr.or.ddit.vo.VOndyclSchdulVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Slf4j
@RequestMapping("/onedayClass")
public class OnedayClassController {
	
	@Autowired
	OnedayClassService onedayClassService;
	
	@Autowired
	String uploadFolder;
	
	
	//원데이클래스 장바구니 넣기
	@ResponseBody
	@PostMapping("/putShoppingCart")
	public int putShoppingCart(ShopngBundleVO shopngBundleVO) {
//		log.info("장바구니 넣기 : " + shopngBundleVO);
		return this.onedayClassService.putShoppingCart(shopngBundleVO);
	}
	
	
	//회원 원데이클래스 장바구니 입장
	@GetMapping("/mberShoppingCart")
	public String mberShoppingCart(Model model, String mberId,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mberId",mberId);
		map.put("currentPage",currentPage);
//		log.info("장바구니 출력 map " + map);
		List<BundleOndyclVO> shopngBundleVOList = this.onedayClassService.mberShoppingCart(map);
		if(shopngBundleVOList != null && !shopngBundleVOList.isEmpty()) {
			dayCheckBundle(shopngBundleVOList);
			peopleCheckBundle(shopngBundleVOList);
		}
		
		int total = this.onedayClassService.countShoppingCart(map);
//		log.info("첫번째 리스트 "+shopngBundleVOList);
//		log.info("첫번쨰 total : " + total);
		model.addAttribute("shopngBundleVOList",shopngBundleVOList);
		model.addAttribute("cnt",total);
		
		return "member/shoppingCart";
	}
	@ResponseBody
	@PostMapping("/mberShoppingCartAjax")
	public ArticlePage<BundleOndyclVO> mberShoppingCartAjax(@RequestBody(required=false) Map<String,Object> map) {
		String searchKeyword = (String) map.get("searchKeyword");
		String bfKeyword = map.get("keyword").toString();
		String keyword = map.get("keyword").toString();
		
//		log.info("searchKeyword" + searchKeyword);
//		log.info("bfKeyword" + bfKeyword);
		if(searchKeyword.trim().equals("date")) {
			keyword = bfKeyword.replace("-","");
			map.put("keyword",keyword);
		}else if(searchKeyword.trim().equals("title")){
			keyword = map.get("keyword").toString();
			map.put("keyword",keyword);
		}else {
			keyword = map.get("keyword").toString();
		}
		
//		log.info("두번째 map" + map);
		List<BundleOndyclVO> shopngBundleVOList = this.onedayClassService.mberShoppingCart(map);
		if(shopngBundleVOList != null && !shopngBundleVOList.isEmpty()) {
			dayCheckBundle(shopngBundleVOList);
			peopleCheckBundle(shopngBundleVOList);
		}
		
		int total = this.onedayClassService.countShoppingCart(map);
		int size = 10;
//		log.info("두번째 리스트 "+shopngBundleVOList);
//		log.info("두번쨰 total : " + total);
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		ArticlePage<BundleOndyclVO> data = new ArticlePage<BundleOndyclVO>(total, currentPage, size, shopngBundleVOList, keyword);
		
		String url  = "/member/shoppingCart";
		
		data.setUrl(url);
		
		return data;
	}
	
	//원데이클래스 게시판 호출
	@GetMapping("/main")
	public String main(Model model) {
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.vOndyclProUsersVOList();
		int countOndycl = this.onedayClassService.countOndycl();
		String codeNm;
		String codeCd;
		
		//카테고리 이름
		for(int i=0;i<vOndyclProUsersVOList.size();i++) {
			codeCd = vOndyclProUsersVOList.get(i).getSpcltyRealmCode();
			codeNm = this.onedayClassService.getCodeNm(codeCd);
			
			vOndyclProUsersVOList.get(i).setSpcltyRealmCode(codeNm);
		}
		
		List<SpcltyRealmVO> codeList = this.onedayClassService.category();
		model.addAttribute("codeList", codeList);
		List<BcityVO> bcityVOList = this.onedayClassService.getBcity();
		for(int i=0;i<bcityVOList.size();i++) {
			if(bcityVOList.get(i).getBcityCode().equals("00")) {
				bcityVOList.remove(i);
			}
		}
		
		dayCheck(vOndyclProUsersVOList);
		
		model.addAttribute("bcityVOList", bcityVOList);
		model.addAttribute("vOndyclProUsersVOList", vOndyclProUsersVOList);
		model.addAttribute("countOndycl", countOndycl);
		return "onedayClass/main";
	}
		
	//전문분야 검색 실행
	@ResponseBody
	@GetMapping("/categorySearch")
	public List<VOndyclProUsersVO> categorySearch(String spcltyRealmCode) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("keyword","category");
		searchMap.put("spcltyRealmCode",spcltyRealmCode);
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.searchClass(searchMap);
		String codeNm;
		String codeCd;
		//카테고리 이름
		for(int i=0;i<vOndyclProUsersVOList.size();i++) {
			codeCd = vOndyclProUsersVOList.get(i).getSpcltyRealmCode();
			codeNm = this.onedayClassService.getCodeNm(codeCd);
			
			vOndyclProUsersVOList.get(i).setSpcltyRealmCode(codeNm);
		}
		
		return vOndyclProUsersVOList;
	}
	
	//원데이클래스 검색
	@ResponseBody
	@GetMapping("/searchClass")
	public List<VOndyclProUsersVO> searchClass(String keyword, String firstInput
			, @RequestParam(required = false) String secondInput) {
		String codeNm;
		String codeCd;
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("keyword",keyword);
		if(keyword.equals("date")) {
			if(secondInput!=null && !secondInput.isEmpty()) {
				if(firstInput == null || firstInput == "") { // 첫째 비고 둘째 존재
					String rpSecond = secondInput.replaceAll("-","");
					searchMap.put("firstInput",null);
					searchMap.put("secondInput",rpSecond);
				}else { //둘다 존재
					String rpFirst = firstInput.replaceAll("-","");
					String rpSecond = secondInput.replaceAll("-","");
					searchMap.put("firstInput",rpFirst);
					searchMap.put("secondInput",rpSecond);
				}
			}else {
				String rpFirst = firstInput.replaceAll("-","");
				searchMap.put("firstInput",rpFirst);
				searchMap.put("secondInput",null);
			}
		}else {
			searchMap.put("firstInput",firstInput);
		}
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.searchClass(searchMap);
		//카테고리 이름
		for(int i=0;i<vOndyclProUsersVOList.size();i++) {
			codeCd = vOndyclProUsersVOList.get(i).getSpcltyRealmCode();
			codeNm = this.onedayClassService.getCodeNm(codeCd);
			
			vOndyclProUsersVOList.get(i).setSpcltyRealmCode(codeNm);
		}
		
		for(int i=0;i<vOndyclProUsersVOList.size();i++) {
		}
		return vOndyclProUsersVOList;
	}
	
	//주소 검색
	@ResponseBody
	@GetMapping("/localSearch")
	public List<VOndyclProUsersVO> localSearch(String cityName) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		if(cityName.length() >= 8) {
			if(cityName.substring(6).equals("전체")) {
				searchMap.put("keyword","cityAll");
				searchMap.put("cityName",cityName.substring(0, 2));
			}
		}else if(cityName.substring(0, 2).equals("제주")){
			if(cityName.length() == 8) {
				searchMap.put("keyword","cityAll");
				searchMap.put("cityName","제주특별자치도" + cityName.substring(5));
			}else {
				searchMap.put("keyword","city");
				searchMap.put("cityName",cityName);
			}
		}else if(cityName.substring(0, 2).equals("세종")){
			searchMap.put("keyword","cityAll");
			searchMap.put("cityName","세종특별자치시" + cityName.substring(5));
		}else {
			searchMap.put("keyword","city");
			searchMap.put("cityName",cityName);
		}
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.searchClass(searchMap);
		
		return vOndyclProUsersVOList;
	}
	
	//클래스 삭제
	@ResponseBody
	@GetMapping("/deleteClass")
	public int deleteClass(String classNo) {
//		log.info("classNo : " + classNo);
		int result = this.onedayClassService.deleteClass(classNo);
		
		return result;
	}
	
	//시군구 모달에 출력
	@ResponseBody
	@GetMapping("/brtcSelect")
	public List<BrtcVO> brtcSelect(String bcityCode){
		List<BrtcVO> brtcVOList = this.onedayClassService.brtcSelect(bcityCode);
		
		return brtcVOList;
	}
	
	//원데이클래스 등록화면
	@GetMapping("/createOndycl")
	public String createOndycl() {
		return "onedayClass/createOndycl";
	}
	
	//원데이클래스 수정화면으로
	@PostMapping("/updateClass")
	public String updateClass(VOndyclSchdulVO vOndyclSchdulVO, Model model) {
//		log.info("vOndyclSchdulVO : " + vOndyclSchdulVO);
		String ondyclNo = vOndyclSchdulVO.getOndyclNo() + "";
		List<SprviseAtchmnflVO> sprviseAtchmnflVOList = this.onedayClassService.fileList(ondyclNo);
		String classDate = vOndyclSchdulVO.getOndyclSchdulDe();
		
//		log.info("sprviseAtchmnflVOList"+sprviseAtchmnflVOList);
		model.addAttribute("vOndyclSchdulVO", vOndyclSchdulVO);
		model.addAttribute("sprviseAtchmnflVOList", sprviseAtchmnflVOList);
		
		return "onedayClass/updateOndycl";
	}
	
	//원데이클래스 업데이트
	@PostMapping("/updateOndycl")
	//serviceImpl에서 비즈니스로직 처리
	public String updateOndycl(VOndyclSchdulVO vOndyclSchdulVO) {
		log.info("vOndyclSchdulVO" + vOndyclSchdulVO);
		int result = this.onedayClassService.updateOndycl(vOndyclSchdulVO);
		
		int ondyclNo = vOndyclSchdulVO.getOndyclNo();
		return "redirect:/onedayClass/onedayClassDetail?ondyclNo=" + ondyclNo;
	}
	
	//원데이클래스 등록
	@PostMapping("/createOndycl")
	public String createOndycl(VOndyclSchdulVO vOndyclSchdulVO) {
		log.info("넘어온 원데이클래스 정보 : " + vOndyclSchdulVO);
		Map<String, Object> map = new HashMap<String, Object>();
		SprviseAtchmnflVO sprviseAtchmnflVO = new SprviseAtchmnflVO();
		int sprviseAtchmnflNo = this.onedayClassService.getAttachNo();
		int insertClNum = this.onedayClassService.getInsertClNum();
		int result = 0;
		String proId = vOndyclSchdulVO.getProId();
		String ondyclSchdulDe = vOndyclSchdulVO.getOndyclSchdulDe();
		ondyclSchdulDe = ondyclSchdulDe.replaceAll("-", "");
		
		map.put("ondyclNo",insertClNum);
		map.put("ondyclNm",vOndyclSchdulVO.getOndyclNm());
		map.put("ondyclCn",vOndyclSchdulVO.getOndyclCn());
		map.put("ondyclPc",vOndyclSchdulVO.getOndyclPc());
		map.put("ondyclPsncpa",vOndyclSchdulVO.getOndyclPsncpa());
		map.put("proId",proId);
		map.put("ondyclSchdulDe",ondyclSchdulDe);
		map.put("ondyclSchdulBeginTime",vOndyclSchdulVO.getOndyclSchdulBeginTime());
		map.put("ondyclSchdulEndTime",vOndyclSchdulVO.getOndyclSchdulEndTime());
		map.put("sprviseAtchmnflNo",sprviseAtchmnflNo);
		map.put("ondyclAdres",vOndyclSchdulVO.getOndyclAdres());
		map.put("ondyclDetailAdres",vOndyclSchdulVO.getOndyclDetailAdres());
		map.put("ondyclZip",vOndyclSchdulVO.getOndyclZip());
		
		//썸네일 등록
		if(vOndyclSchdulVO.getUploadProfile() != null && !vOndyclSchdulVO.getUploadProfile().isEmpty()) {
//			log.info("썸네일 메소드 시작");
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
			map.put("ondyclThumbPhoto",null);
		} //썸네일 사진 등록 끝
		
		//첨부파일(이미지들) 추가
		if(vOndyclSchdulVO.getUploadFile() != null) {
//			log.info("첨부파일 메소드 시작");
			String originFileName = ""; //원본파일명
			String newFileName = "";
			String mimeType = ""; //파일 형식
			long size = 0; //파일 사이즈
			int seq = 1;
			
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
					sprviseAtchmnflVO.setSprviseAtchmnflNo(sprviseAtchmnflNo);;
					sprviseAtchmnflVO.setAtchmnflCours(url);
					sprviseAtchmnflVO.setAtchmnflNm(originFileName);
					sprviseAtchmnflVO.setStoreAtchmnflNm(newFileName);
					sprviseAtchmnflVO.setAtchmnflTy(mimeType);
					sprviseAtchmnflVO.setAtchmnflNo(seq++);
					sprviseAtchmnflVO.setUserId(proId);
//					log.info("sprviseAtchmnflVO : " + sprviseAtchmnflVO);
					
					result += this.onedayClassService.addSprviseAtchmnfl(sprviseAtchmnflVO);
					log.info("첨부파일 result " + result);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}//첨부파일추가 끝
		log.info("sql가기 직전 map : " + map);
		
		result += this.onedayClassService.createOndycl(map);
		
		log.info("원데이클래스 result 수 : " + result);
		
		return "redirect:/onedayClass/onedayClassDetail?ondyclNo="+insertClNum;
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
	
	//원데이클래스 결제
	@ResponseBody
	@PostMapping("/buyClass")
	public int buyClass(@RequestBody Map<String, Object> map) {
//		log.info("넘어온 맵 : " + map);
		
		//serviceImpl에서 서비스로직 처리
		int result = this.onedayClassService.buyClass(map);
//		log.info("걀제처리 result : " + result);
		return result;
	}
	
	//장바구니 체크 삭제
	@ResponseBody
	@PostMapping("/delBundle")
	public int delBundle(int[] checkList, String mberId) {
//		log.info("받은 배열 " + Arrays.toString(checkList) + "/" + mberId);
//		log.info("받은 배열 " + checkList.length);
		Map<String, Object> map = new HashMap<String, Object>();
		int result = 0;
		
		map.put("mberId",mberId);
		for(int i=0; i<checkList.length; i++) {
			map.put("ondyclNo",checkList[i]);
			
			result += this.onedayClassService.delBundle(map);
		}
		
		return result;
	}
	
	//장바구니 결제
	@ResponseBody
	@PostMapping("/buyBundle")
	public int buyBundle(@RequestBody Map<String, Object> map) {
		//serviceImpl에서 서비스로직 처리
		int result = this.onedayClassService.buyBundle(map);
//		log.info("결제처리 result : " + result);
		
		return result;
	}
	
	//원데이클래스 가격확인
	@ResponseBody
	@GetMapping("/priceCk")
	public VOndyclSchdulVO priceCk(int ondyclNo) {
		VOndyclSchdulVO vOndyclSchdulVO = this.onedayClassService.priceCk(ondyclNo);
		
		dayCheckSch(vOndyclSchdulVO);
		
//		log.info("가격확인 vo : " + vOndyclSchdulVO);
		
		return vOndyclSchdulVO;
	}
	
	//원데이클래스 상세페이지
	@GetMapping("/onedayClassDetail")
	public String detail(String ondyclNo, @RequestParam(required=false) String startPoint,
			@RequestParam(required=false) String mberId,@RequestParam(required=false) String mainck, Model model) {
//		log.info("ondyclNo : " + ondyclNo);
//		log.info("mberId : " + mberId);
		VOndyclProUsersVO vOndyclProUsersVO = this.onedayClassService.detail(ondyclNo);
//		log.info("detail->vOndyclProUsersVO : " + vOndyclProUsersVO);
		
		List<SprviseAtchmnflVO> sprviseAtchmnflVOList = this.onedayClassService.fileList(ondyclNo);
		if(mberId != null && !mberId.isEmpty()) {
			Map<String, Object> mberOndyclMap = new HashMap<String, Object>();
			mberOndyclMap.put("mberId",mberId);
			mberOndyclMap.put("ondyclNo",ondyclNo);
			int resveCheck = this.onedayClassService.resveCheck(mberOndyclMap);
			model.addAttribute("resveCheck",resveCheck);
			int classBundleCk = this.onedayClassService.classBundleCk(mberOndyclMap);
//			log.info("카운트 : " + classBundleCk);
			model.addAttribute("classBundleCk",classBundleCk);
		}else {
			model.addAttribute("resveCheck",0);
		}
		if(vOndyclProUsersVO != null) {
			dayCheck(vOndyclProUsersVO);
			peopleCheck(vOndyclProUsersVO);
		}
		
		//참가자 목록
		List<UserNcnmMberPhotoVO> userNcnmMberPhotoVOList = this.onedayClassService.getBuyer(ondyclNo);
//		log.info("userNcnmMberPhotoVOList " + userNcnmMberPhotoVOList);
		model.addAttribute("userNcnmMberPhotoVOList",userNcnmMberPhotoVOList);
		
		String date = vOndyclProUsersVO.getOndyclSchdulDe();
//		log.info("시작날짜1 : " + date);
		String reDate = date.substring(0, 4) + "." + date.substring(4, 6) + "." + date.substring(6);
//		log.info("시작날짜2: " + reDate);
		vOndyclProUsersVO.setOndyclSchdulDe(reDate);
		
		
		
		if(startPoint != null && !startPoint.isEmpty()) {
			if(startPoint.equals("myClass")) {
				model.addAttribute("mainck", mainck);
			}
		}
		if(mainck != null && !mainck.isEmpty()) {
			if("main".equals(mainck)) {
				model.addAttribute("startPoint", startPoint);
			}
		}
				
		model.addAttribute("sprviseAtchmnflVOList", sprviseAtchmnflVOList);
		model.addAttribute("vOndyclProUsersVO", vOndyclProUsersVO);
//		log.info("vOndyclProUsersVO : "+vOndyclProUsersVO);
//		log.info("sprviseAtchmnflVOList : "+sprviseAtchmnflVOList);
		return "onedayClass/onedayClassDetail";
	}
	
	//멤버 내 원데이클래스 리스트로 이동
	@GetMapping("/memberOndyclList")
	public String memberOndyclList(Model model, Map<String,Object>map,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue="1")String keyword) {
		map.put("currentPage",currentPage);
		
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.memberOndyclList(map);
		int total = this.onedayClassService.countMberMyClass(map);
		if(vOndyclProUsersVOList != null && !vOndyclProUsersVOList.isEmpty()) {
			dayCheck(vOndyclProUsersVOList);
		}
//		log.info("vOndyclProUsersVOList" + vOndyclProUsersVOList);
		model.addAttribute("vOndyclProUsersVOList",vOndyclProUsersVOList);
		model.addAttribute("cnt",total);
		
		return "/onedayClass/memberOndyclList";
	}
	
	@ResponseBody
	@PostMapping("/memberOndyclListAjax")
	public ArticlePage<VOndyclProUsersVO> memberOndyclListAjax(@RequestBody(required=false) Map<String,Object> map) throws ParseException {
		String searchKeyword = map.get("searchKeyword").toString();
		String bfKeyword = map.get("keyword").toString();
		String keyword = map.get("keyword").toString();
		
		
		if(searchKeyword.trim().equals("date")) {
			keyword = bfKeyword.replace("-","");
			map.put("keyword",keyword);
		}else if(searchKeyword.trim().equals("title")){
			keyword = map.get("keyword").toString();
			map.put("keyword",keyword);
		}else {
			keyword = map.get("keyword").toString();
		}
//		log.info("리스트 맵 : " + map);
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.memberOndyclList(map);
//		log.info("검색결과" + vOndyclProUsersVOList);
		if(vOndyclProUsersVOList != null && !vOndyclProUsersVOList.isEmpty()) {
			dayCheck(vOndyclProUsersVOList);
		}else {
		}
		int total = this.onedayClassService.countMberMyClass(map);
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		int size = 10;
		
		ArticlePage<VOndyclProUsersVO> data = new ArticlePage<VOndyclProUsersVO>(total, currentPage, size, vOndyclProUsersVOList, keyword);
		
		String url  = "/ondayClass/memberOndyclList";
		
		data.setUrl(url);
		
		return data;
	}
	
	//프로 마이페이지에서 원데이클래스 관리
	@GetMapping("/proMyClassList")
	public String proMyClassList(Model model, Map<String,Object>map,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage) {
		map.put("currentPage",currentPage);
		
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.proMyClassList(map);
		if(vOndyclProUsersVOList != null && !vOndyclProUsersVOList.isEmpty()) {
			dayCheck(vOndyclProUsersVOList);
		}
		int total = this.onedayClassService.countProMyClass(map);
		int totalPrice = this.onedayClassService.getTotalPrice(map);
//		log.info("totalPrice" + totalPrice);
		
		model.addAttribute("vOndyclProUsersVOList",vOndyclProUsersVOList);
		model.addAttribute("cnt",total);
		model.addAttribute("totalPrice",totalPrice);
		
		return "onedayClass/proMyClassList";
	}
	
	@ResponseBody
	@PostMapping("/proOndyclListAjax")
	public Map<String, Object> proMyClassListAjax(@RequestBody(required=false) Map<String,Object> map,Model model) {
		String searchKeyword = (String) map.get("searchKeyword");
		String bfKeyword = map.get("keyword").toString();
		String keyword = map.get("keyword").toString();
		int totalPrice = this.onedayClassService.getTotalPrice(map);
		int totalUser = this.onedayClassService.getTotalUser(map);
		double totalStar = this.onedayClassService.getTotalStar(map);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> monthUserMap = new HashMap<String, Object>();
		Map<String, Object> monthPriceMap = new HashMap<String, Object>();
		
		int startMonth = 20240001;
		for(int i=1;i<=4;i++) {
			startMonth += i*100;
			map.put("startMonth",startMonth);
//			log.info("시작 끝달 " + startMonth);
			monthUserMap.put("month"+i,this.onedayClassService.getMonthTotalUser(map));
			monthPriceMap.put("month"+i,this.onedayClassService.getMonthTotalPrice(map));
			startMonth = 20240001;
		}
		returnMap.put("monthUserMap",monthUserMap);
		returnMap.put("monthPriceMap",monthPriceMap);
		
//		log.info("searchKeyword" + searchKeyword);
//		log.info("bfKeyword" + bfKeyword);
		if(searchKeyword.trim().equals("date")) {
			keyword = bfKeyword.replace("-","");
			map.put("keyword",keyword);
		}else if(searchKeyword.trim().equals("title")){
			keyword = map.get("keyword").toString();
			map.put("keyword",keyword);
		}else {
			keyword = map.get("keyword").toString();
		}
		
//		log.info("map" + map);
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.onedayClassService.proMyClassList(map);
		if(vOndyclProUsersVOList != null && !vOndyclProUsersVOList.isEmpty()) {
			dayCheck(vOndyclProUsersVOList);
		}
		int total = this.onedayClassService.countProMyClass(map);
		int size = 10;
//		int totalPrice = this.onedayClassService.getTotalPrice(map);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		ArticlePage<VOndyclProUsersVO> data = new ArticlePage<VOndyclProUsersVO>(total, currentPage, size, vOndyclProUsersVOList, keyword);
		
		String url  = "/onedayClass/proMyClassList";
		
		data.setUrl(url);
		
		returnMap.put("data",data);
		
//		String formatPrice = totalPrice + "";
		DecimalFormat deF = new DecimalFormat("###,###");
		
		returnMap.put("totalPrice",deF.format(totalPrice));
		returnMap.put("totalStar",totalStar);
		returnMap.put("totalUser",totalUser);
//		log.info("totalStar"+totalStar);
		
		return returnMap;
	}
	
	//회원 원데이클래스 취소
	@ResponseBody
	@PostMapping("/mberClassCancel")
	public int mberClassCancel(String mberId, String ondyclNo) {
//		log.info("회원 원데이클래스 삭제 정보 : "+ mberId);
//		log.info("회원 원데이클래스 삭제 정보 : "+ondyclNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mberId",mberId);
		map.put("ondyclNo",ondyclNo);
		
		int result = this.onedayClassService.mberClassCancel(map);
		
		return result;
	}
	
	//리뷰 등록모달에 원데이클래스 제목 전달
	@ResponseBody
	@GetMapping(value = "/mberReviewTitle", produces = "text/plain;charset=UTF-8")
	public String mberReviewTitle(int ondyclNo) {
		String ondyclNm = this.onedayClassService.mberReviewTitle(ondyclNo);
		
		return ondyclNm;
	}
	
	//원데이클래스 상세페이지 리뷰 리스트 출력
	@ResponseBody
	@GetMapping("/reviewList")
	public List<ReviewMberVO> reviewList(int ondyclNo) {
		List<ReviewMberVO> reviewMberVOList = this.onedayClassService.reviewList(ondyclNo);
		
		
		return reviewMberVOList;
	}
	
	//리뷰 작성
	@ResponseBody
	@PostMapping("/createReview")
	public int createReview(OndyclReviewVO ondyclReviewVO) {
//		log.info("리뷰작성vo : " + ondyclReviewVO);
		int result = this.onedayClassService.createReview(ondyclReviewVO);
		
		return result;
	}
	
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	//날짜 지났나 확인(지났으면 true 안지났으면 false)
	public List<VOndyclProUsersVO> dayCheck(List<VOndyclProUsersVO> vOndyclProUsersVOList) {
		Date date = new Date();
		SimpleDateFormat sdf;
		if(vOndyclProUsersVOList.size() == 0) {
			return null;
		}
		if(vOndyclProUsersVOList.get(0).getOndyclSchdulDe().length() == 8) {
			sdf = new SimpleDateFormat("yyyyMMdd");
		}else if(vOndyclProUsersVOList.get(0).getOndyclSchdulDe().substring(4, 5) == "-") {
//			log.info("-형식 " + vOndyclProUsersVOList.get(0).getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		}else {
//			log.info(".형식 " + vOndyclProUsersVOList.get(0).getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy.MM.dd");
		}
		String todayStr = sdf.format(date);
		try {
		    Date today = sdf.parse(todayStr);

		    for(int i = 0; i < vOndyclProUsersVOList.size(); i++) {
		        Date ondyclSchdulDe = sdf.parse(vOndyclProUsersVOList.get(i).getOndyclSchdulDe());

		        boolean dayCheck = ondyclSchdulDe.before(today);
		        vOndyclProUsersVOList.get(i).setDayCheck(dayCheck);
		    }
		} catch (ParseException e) {
		    e.printStackTrace();
		}
		
		return vOndyclProUsersVOList;
	}
	
	//날짜 지났나 확인(지났으면 true 안지났으면 false)
	public List<BundleOndyclVO> dayCheckBundle(List<BundleOndyclVO> bundleOndyclVOList) {
		Date date = new Date();
		SimpleDateFormat sdf;
		if(bundleOndyclVOList.get(0).getOndyclSchdulDe().length() == 8) {
			sdf = new SimpleDateFormat("yyyyMMdd");
		}else if(bundleOndyclVOList.get(0).getOndyclSchdulDe().substring(4, 5) == "-") {
//			log.info("-형식 " + vOndyclProUsersVOList.get(0).getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		}else {
//			log.info(".형식 " + vOndyclProUsersVOList.get(0).getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy.MM.dd");
		}
		String todayStr = sdf.format(date);
		try {
			Date today = sdf.parse(todayStr);
			
			for(int i = 0; i < bundleOndyclVOList.size(); i++) {
				Date ondyclSchdulDe = sdf.parse(bundleOndyclVOList.get(i).getOndyclSchdulDe());
				
				boolean dayCheck = ondyclSchdulDe.before(today);
				bundleOndyclVOList.get(i).setDayCheck(dayCheck);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return bundleOndyclVOList;
	}
	
	//날짜 지났나 확인(지났으면 true 안지났으면 false)
	public VOndyclProUsersVO dayCheck(VOndyclProUsersVO vOndyclProUsersVO) {
		Date date = new Date();
		SimpleDateFormat sdf;
		if(vOndyclProUsersVO.getOndyclSchdulDe().length() == 8) {
			sdf = new SimpleDateFormat("yyyyMMdd");
		}else if(vOndyclProUsersVO.getOndyclSchdulDe().substring(4, 5) == "-") {
//			log.info("-형식 " + vOndyclProUsersVO.getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		}else {
//			log.info(".형식 " + vOndyclProUsersVO.getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy.MM.dd");
		}
		String todayStr = sdf.format(date);
		try {
			Date today = sdf.parse(todayStr);
			
			Date ondyclSchdulDe = sdf.parse(vOndyclProUsersVO.getOndyclSchdulDe());
			
			boolean dayCheck = ondyclSchdulDe.before(today);
			vOndyclProUsersVO.setDayCheck(dayCheck);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return vOndyclProUsersVO;
	}
	
	//날짜 지났나 확인(지났으면 true 안지났으면 false)
	public VOndyclSchdulVO dayCheckSch(VOndyclSchdulVO vOndyclSchdulVO) {
		Date date = new Date();
		SimpleDateFormat sdf;
		if(vOndyclSchdulVO.getOndyclSchdulDe().length() == 8) {
			sdf = new SimpleDateFormat("yyyyMMdd");
		}else if(vOndyclSchdulVO.getOndyclSchdulDe().substring(4, 5) == "-") {
//			log.info("-형식 " + vOndyclProUsersVO.getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		}else {
//			log.info(".형식 " + vOndyclProUsersVO.getOndyclSchdulDe().substring(4, 5));
			sdf = new SimpleDateFormat("yyyy.MM.dd");
		}
		String todayStr = sdf.format(date);
		try {
			Date today = sdf.parse(todayStr);
			
			Date ondyclSchdulDe = sdf.parse(vOndyclSchdulVO.getOndyclSchdulDe());
			
			boolean dayCheck = ondyclSchdulDe.before(today);
			vOndyclSchdulVO.setDayCheck(dayCheck);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return vOndyclSchdulVO;
	}
	
	public List<BundleOndyclVO> peopleCheckBundle(List<BundleOndyclVO> bundleOndyclVOList) {
		int ondyclNo = 0;
		String peopleCkString = "";
		boolean peopleCheck = true;
		
		for(int i = 0; i < bundleOndyclVOList.size(); i++) {
			ondyclNo = bundleOndyclVOList.get(i).getOndyclNo();
			peopleCkString = this.onedayClassService.getPeopleCheck(ondyclNo);
			if("TRUE".equals(peopleCkString)) {
				peopleCheck = true;
			}else {
				peopleCheck = false;
			}
			bundleOndyclVOList.get(i).setPeopleCheck(peopleCheck);
		}
		
		return bundleOndyclVOList;
	}
	
	public VOndyclProUsersVO peopleCheck(VOndyclProUsersVO vOndyclProUsersVO) {
		int ondyclNo = vOndyclProUsersVO.getOndyclNo();
		boolean peopleCheck = true;
		String peopleCkString = this.onedayClassService.getPeopleCheck(ondyclNo);
//		log.info("peopleCkString  " + peopleCkString);
		if("TRUE".equals(peopleCkString)) {
			peopleCheck = true;
		}else {
			peopleCheck = false;
		}
		
		vOndyclProUsersVO.setPeopleCheck(peopleCheck);
		
		return vOndyclProUsersVO;
	}
	
	
}
