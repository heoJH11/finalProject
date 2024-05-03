package kr.or.ddit.member.mypage.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.member.mypage.service.MemberMypageService;
import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.VMberUsersVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberMypageController {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	MemberMypageService memberMypageService;
	
	@GetMapping("/memberMypage")
	public String memberMypage() {
		return "member/memberMypage";
	}
	
	@GetMapping("/memberUpdateCk")
	public String memberUpdateCk() {
		return "member/memberUpdateCk";
	}
	
	@GetMapping("/memberPostList")
	public String memberPostList() {
		return "/member/memberPostList";
	}
	
	@GetMapping("/memberOndyclList")
	public String memberOndyclList() {
		return "/member/memberOndyclList";
	}
	
	//회원 탈퇴
	@ResponseBody
	@PostMapping("/memberDelete")
	public int memberDelete(String userId, HttpSession session) {
//		log.info("userId : " + userId);
		int result = this.memberMypageService.memberDelete(userId); //MBER 테이블에서 삭제
		result += this.memberMypageService.memberDelete2(userId); //USERS 테이블에서 삭제
		result += this.memberMypageService.memberDelete3(userId); //AUTHOR 테이블에서 삭제
		result += this.memberMypageService.memberDelete4(userId); //ADRES 테이블에서 삭제
//		log.info("result : " + result);
		
		session.removeAttribute("memSession");
		
		return result;
	}
	
	//회원 정보수정
	@PostMapping("/memberMypage")
	public String updating(VMberUsersVO vMberUsersVO, AdresVO adresVO, HttpSession session) {
		Map<String, Object> map = (Map<String, Object>)session.getAttribute("memSession");
//		log.info("업뎃전 map : " + map);
//		log.info("업뎃전 vMberUsersVO : " + vMberUsersVO);
		
		int result = 0;
		
		String mberMbtlnum = vMberUsersVO.getMberMbtlnum();
		if(mberMbtlnum != null && !mberMbtlnum.isEmpty()) {
			map.put("mberMbtlnum",mberMbtlnum);
			result += this.memberMypageService.updMberMbtlnum(map);
//			log.info("map1 : " + map);
		}
		String userPassword = vMberUsersVO.getUserPassword();
		if(userPassword != null && !userPassword.isEmpty()) {
			map.put("userPassword",userPassword);
			result += this.memberMypageService.updPw(map);
//			log.info("map2 : " + map);
		}
		String userNcnm = vMberUsersVO.getUserNcnm();
		if(userNcnm != null && !userNcnm.isEmpty()) {
			map.put("userNcnm",userNcnm);
			result += this.memberMypageService.updNcnm(map);
//			log.info("map3 : " + map);
		}
		String email = vMberUsersVO.getEmail();
		if(email != null && !email.isEmpty()) {
			map.put("email",email);
			result += this.memberMypageService.updEmail(map);
//			log.info("map3 : " + map);
		}
		String userNm = vMberUsersVO.getUserNm();
		if(userNm != null && !userNm.isEmpty()) {
			map.put("userNm",userNm);
			result += this.memberMypageService.updNm(map);
//			log.info("map5 : " + map);
		}
		String zip = adresVO.getZip();
		String adres = adresVO.getAdres();
		String detailAdres = adresVO.getDetailAdres();
		if(detailAdres != null && !detailAdres.isEmpty()) {
			map.put("zip",zip);
			map.put("adres",adres);
			map.put("detailAdres",detailAdres);
			result += this.memberMypageService.updAdres(map);
//			log.info("map6 : " + map);
		}
		
		MultipartFile multipartFile = vMberUsersVO.getUploadFile();
		if(vMberUsersVO.getMberProflPhoto() != null && !vMberUsersVO.getMberProflPhoto().isEmpty()) {
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
			String mberProflPhoto = "/images/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
//			log.info("저장파일1 : " + saveFile);
//			log.info("저장파일2 : " + mberProflPhoto);
			
			map.put("mberProflPhoto",mberProflPhoto);
			map.put("profile",mberProflPhoto);
			
//			log.info("업뎃 날릴 map : " + map);
			result += this.memberMypageService.updPhoto(map);
			
		}else {
			map.put("mberProflPhoto",null);
			map.put("profile",null);
		}
		
//		log.info("회원정보수정 맵 : " + map);
//		log.info("결과수 : " + result);
		
		return "member/memberMypage";
	}
	
	//프로필 사진 삭제
	@ResponseBody
	@PostMapping("/photoDelete")
	public int photoDelete(String userId) {
		int result = this.memberMypageService.photoDelete(userId);
		
		return result;
	}
	
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
}
