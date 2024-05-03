package kr.or.ddit.pro.mypage.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.pro.mypage.service.ProMypageService;
import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.VMberUsersVO;
import kr.or.ddit.vo.VProUsersVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/pro")
public class ProMypageController {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	ProMypageService proMypageService;
	
	@GetMapping("/proMypage")
	public String proMypage(String userId) {
//		log.info("아이디 : " + userId);
		return "pro/proMypage";
	}
	
	@GetMapping("/proUpdateCk")
	public String proUpdateCk() {
		return "pro/proUpdateCk";
	}
	
	@GetMapping("/proPostList")
	public String proPostList() {
		return "pro/proPostList";
	}
	
	@GetMapping("/proMyClassList")
	public String proMyClassList() {
		return "onedayClass/proMyClassList";
	}
	
	//회원정보 수정
	@PostMapping("/updating")
	public String updating(VProUsersVO vProUsersVO, AdresVO adresVO, HttpSession session) {
//		log.info("업뎃전 vo : " + vProUsersVO);
		Map<String, Object> map = (Map<String, Object>)session.getAttribute("proSession");
		int result = 0;
		
		String proMbtlnum = vProUsersVO.getProMbtlnum();
		if(proMbtlnum != null && !proMbtlnum.isEmpty()) {
			map.put("proMbtlnum",proMbtlnum);
//			log.info("map1 : " + map);
			result += this.proMypageService.updProMbtlnum(map);
		}
		String userPassword = vProUsersVO.getUserPassword();
		if(userPassword != null && !userPassword.isEmpty()) {
			map.put("userPassword",userPassword);
//			log.info("map2 : " + map);
			result += this.proMypageService.updPW(map);
		}
		String userNcnm = vProUsersVO.getUserNcnm();
		if(userNcnm != null && !userNcnm.isEmpty()) {
			map.put("userNcnm",userNcnm);
//			log.info("map3 : " + map);
			result += this.proMypageService.updNcnm(map);
		}
		String email = vProUsersVO.getEmail();
		if(email != null && !email.isEmpty()) {
			map.put("email",email);
			result += this.proMypageService.updEmail(map);
//			log.info("map3 : " + map);
		}
		String userNm = vProUsersVO.getUserNm();
		if(userNm != null && !userNm.isEmpty()) {
			map.put("userNm",userNm);
			result += this.proMypageService.updNm(map);
//			log.info("map5 : " + map);
		}
		String zip = adresVO.getZip();
		String adres = adresVO.getAdres();
		String detailAdres = adresVO.getDetailAdres();
		if(detailAdres != null && !detailAdres.isEmpty()) {
			map.put("zip",zip);
			map.put("adres",adres);
			map.put("detailAdres",detailAdres);
			result += this.proMypageService.updAdres(map);
//			log.info("map6 : " + map);
		}
		
		MultipartFile multipartFile = vProUsersVO.getUploadFile();
		if(vProUsersVO.getProProflPhoto() != null && !vProUsersVO.getProProflPhoto().isEmpty()) {
//			String uploadFolder = "d/team2/upload";
//			log.info("파일경로 : " + uploadFolder);
			File uploadPath = new File(uploadFolder, getFolder());
			if(!uploadPath.exists()) {
				uploadPath.mkdirs();
			}
			String uploadFileName = multipartFile.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				log.info(e.getMessage());
			}
			String proProflPhoto = "/images/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
//			log.info("저장파일1 : " + saveFile);
//			log.info("저장파일2 : " + proProflPhoto);
			
			map.put("proProflPhoto",proProflPhoto);
			map.put("profile",proProflPhoto);
			
//			log.info("업뎃 날릴 map : " + map);
			result += this.proMypageService.updPhoto(map);
		}else {
			map.put("proProflPhoto",null);
			map.put("profile",null);
			result += this.proMypageService.updPhoto(map);
		}
			
//		log.info("결과수 : " + result);
		
		return "pro/proMypage";
	}
	
	//프로필 사진 삭제
	@ResponseBody
	@PostMapping("/photoDelete")
	public int photoDelete(String userId) {
		int result = this.proMypageService.photoDelete(userId);
		
		return result;
	}
	
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
}
