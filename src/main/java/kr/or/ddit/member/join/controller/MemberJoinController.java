package kr.or.ddit.member.join.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.member.join.service.MemberJoinService;
import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.MberVO;
import kr.or.ddit.vo.UsersVO;
import kr.or.ddit.vo.VMberUsersVO;
import kr.or.ddit.vo.VProUsersVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberJoinController {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	MemberJoinService memberJoinService;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@GetMapping("/memberJoin")
	public String memberJoin() {
		return "member/memberJoin";
	}
	
	@GetMapping("/test")
	public String test() {
		return "member/test";
	}
//	@GetMapping("/welcome")
//	public String welcome() {
//		return "welcome";
//	}
	@GetMapping("/memberLogin")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	@GetMapping("/joinSelect")
	public String joinSelect() {
		return "joinSelect";
	}
	
	//이메일 중복확인
	@ResponseBody
	@GetMapping("/emailCk")
	public int emailCk(String email) {
		int result = this.memberJoinService.emailCk(email);
		
		return result;
	}
	
	//아이디 중복확인
	@ResponseBody
	@GetMapping("/idCk")
	public int idCk(String userId) {
		int result = this.memberJoinService.idCk(userId);
		
		return result;
	}
	
	//닉네임 중복 확인
	@ResponseBody
	@GetMapping("/ncnmCk")
	public int ncnmCk(String userNcnm) {
		int result = this.memberJoinService.ncnmCk(userNcnm);
		
		return result;
	}
	
	//휴대폰 본인인증
	@ResponseBody
	@PostMapping("/check/sendSMS")
    public String sendSMS(String mberMbtlnum) {
        Random rand  = new Random();
        String numStr = "";
        for(int i=0; i < 6; i++) {
            String ran = Integer.toString(rand.nextInt(10));
            numStr+=ran;
        }
        log.info("인증번호 : " + numStr);
        this.memberJoinService.certifiedPhoneNumber(mberMbtlnum,numStr);
        return numStr;
    }
	
	//회원가입
	@PostMapping("/memberInsert")
	public String memberInsert(UsersVO usersVO, MberVO mberVO, AdresVO adresVO) {
//		log.info("userVO : " + usersVO);
		log.info("mberVO : " + mberVO);
//		log.info("adresVO : " + adresVO);
		Map<String, Object> map = new HashMap<>();
		
		//프로필사진 업로드 처리
		if(mberVO.getMberProflPhoto() != null && !mberVO.getMberProflPhoto().isEmpty()) {
			MultipartFile multipartFile = mberVO.getUploadFile();
//			log.info("파일경로 : " + uploadFolder);
//		log.info("multipartFile 처음 : " + multipartFile);
//			String uploadFolder = "d/team2/upload";
			File uploadPath = new File(uploadFolder, getFolder());
			if(!uploadPath.exists()) {
				uploadPath.mkdirs();
			}
			String uploadFileName = multipartFile.getOriginalFilename();
//		log.info("uploadFileName 전 : " + uploadFileName);
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
//		log.info("uploadFileName 후 : " + uploadFileName);
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
//				log.info(e.getMessage());
			}
//			log.info("saveFile : " + saveFile);
			String url = "/images/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
//			log.info("url : " + url);
			map.put("mberProflPhoto", url);
			map.put("profile", url);
		}else {
			map.put("mberProflPhoto", null);
		}
		map.put("userId", usersVO.getUserId());
		map.put("userNcnm", usersVO.getUserNcnm());
		map.put("mberMbtlnum", mberVO.getMberMbtlnum());
		map.put("sexdstnTy", mberVO.getSexdstnTy());
		map.put("email", mberVO.getEmail());
		map.put("userNm", usersVO.getUserNm());
		map.put("userPassword", usersVO.getUserPassword());
		map.put("adres", adresVO.getAdres());
		map.put("detailAdres", adresVO.getDetailAdres());
		map.put("zip", adresVO.getZip());
//		log.info("회원가입 맵 : " + map);
		int result = this.memberJoinService.memberInsert(map);
//		log.info("회원가입 여부 : " + result);
		
		return "welcome";
	}
	
	//회원 로그인
	@ResponseBody
	@PostMapping("/memberLogin")
	public Map<String, Object> memberLogin(String userId, String userPassword, HttpServletRequest request) {
		Map<String, Object> userMap = new HashMap<>();
		userMap.put("userId", userId); //아이디
		userMap.put("userPassword", userPassword); //비번
//		log.info("로그인 전 map : " + userMap);
		
		UsersVO usersVO = this.memberJoinService.memberLogin(userMap);
		if(usersVO == null) {
//			log.info(" 왜요");
			return userMap;
		}
		
		VMberUsersVO vMberUsersVO = this.memberJoinService.getProfile(userMap);
//		log.info("로그인 userId : " + userId);
		
		try {
			AdresVO adresVO = this.memberJoinService.getAdres(userMap);
			userMap.put("zip",adresVO.getZip()); //우편번호
			userMap.put("adres",adresVO.getAdres()); //주소
			userMap.put("detailAdres",adresVO.getDetailAdres()); //상세주소
//			log.info("로그인 후 adresVO : " + adresVO);
		} catch (NullPointerException e) {
			userMap.put("zip","-"); //우편번호
			userMap.put("adres","-"); //주소
			userMap.put("detailAdres","-"); //상세주소
		}
		
//		log.info("로그인 후 usersVO : " + usersVO);
//		log.info("로그인 후 vMberUsersVO : " + vMberUsersVO);
		userMap.put("cnt",usersVO.getCnt());
		userMap.put("type",usersVO.getEmplyrTy()); //유저타입(프로/회원)
		if(vMberUsersVO != null && usersVO.getCnt() == 1) {
			String profile = vMberUsersVO.getMberProflPhoto();
//			log.info("이미지 : " + profile);
			if(profile != null) {
				profile = vMberUsersVO.getMberProflPhoto();
			}
			
			userMap.put("userNcnm",usersVO.getUserNcnm()); //닉네임
			userMap.put("email",vMberUsersVO.getEmail()); //이메일
			userMap.put("userNm",vMberUsersVO.getUserNm()); //이름
			userMap.put("mberMbtlnum",vMberUsersVO.getMberMbtlnum()); //전화번호
			userMap.put("sexdstnTy",vMberUsersVO.getSexdstnTy()); //성별
			userMap.put("profile",profile); //프로필사진
			userMap.put("changePwCk",usersVO.getChangePwCk()); //임시비번여부
			
//			log.info("session에 들어갈 map : " + userMap);
			HttpSession session = request.getSession();
			if(!userMap.isEmpty()) {
				session.setAttribute("memSession", userMap);
//				log.info("session Id : " + session + " : " + session.getAttribute("memSession"));
			}else {
				session.setAttribute("memSession", null);
			}
		}else if(vMberUsersVO == null && usersVO.getCnt() == 1){
			userMap.put("cnt",1);
		}else if(vMberUsersVO == null && usersVO.getCnt() == 0) {
			userMap.put("cnt",0);
		}
		
		return userMap;
	}
	
	@GetMapping("/memberLogout")
	public String memberLogout(HttpSession session) {
		session.removeAttribute("memSession");
		
		return "redirect:/main";
	}
	
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
//		log.info(str);
		return str.replace("-", File.separator);
	}
	
	//아이디 찾기
	@ResponseBody
	@PostMapping("/idSearch")
	public UsersVO idSearch(VMberUsersVO vMberUsersVO) {
//		log.info("아이디찾기 vo : " + vMberUsersVO);
		
		UsersVO usersVO = this.memberJoinService.idSearch(vMberUsersVO);
//		log.info("usersVO : " + usersVO);
//		log.info("userVO null : " + usersVO.equals(null));
		if(usersVO == null) {
			VProUsersVO proVO = this.memberJoinService.idSearch2(vMberUsersVO);
//			log.info("proVO : " + proVO);
			UsersVO userVO = new UsersVO();
			if(proVO != null) {
				userVO.setEmplyrTy(proVO.getEmplyrTy());
				userVO.setUserId(proVO.getUserId());
				return userVO;
			}else {
				userVO.setEmplyrTy("warn");
				return userVO;
			}
		}
//		log.info("찾은 아이디 : " + usersVO);
		return usersVO;
	}
	
	//비밀번호찾기
	@ResponseBody
	@PostMapping("/pwSearch")
	public Map<String, Object> pwSearch(VMberUsersVO vMberUsersVO) {
//		log.info("비밀번호찾기 vo : " + vMberUsersVO);
		String userPassword;
		
		Map<String, Object> map = new HashMap<String, Object>();
		UsersVO usersVO = this.memberJoinService.pwSearch(vMberUsersVO);
//		log.info("usersVO : " + usersVO);
		if(usersVO == null) {
			String emplyrTy = this.memberJoinService.pwSearch2(vMberUsersVO);
			if(emplyrTy==null) {//프로조회
				map.put("emplyrTy","warn");
//				log.info("map6 : " + map);
				return map;
			}else {
				map.put("emplyrTy", emplyrTy);
//				log.info("map5 : " + map);
				return map;
			}
		}else {
			String emplyrTy = usersVO.getEmplyrTy();
			map.put("emplyrTy", emplyrTy);
			userPassword = usersVO.getUserPassword();
//			log.info("비번2 : " + userPassword);
		}
		
		
		map.put("mberId", vMberUsersVO.getMberId());
//		log.info("찾은 비밀번호 : " + map);
//		log.info("비번3 : " + userPassword);
		
		if(userPassword == null || userPassword.isEmpty()) { //검색 결과가 없을때
//			log.info("검색결과없음");
			userPassword = null;
			map.put("userPassword", userPassword);
//			log.info("비번4 : " + userPassword);
		}else { //비밀번호가 조회되면 이메일로 전송
			// 임시 비밀번호를 발급받기 위한 랜덤번호(0~9,A~Z 까지 추가하고 싶은 문자는 아래의 형식처럼 추가가능)
			char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
					'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
			// 임시비빌번호가 저장될 변수
			String str = "";
			// 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
			int idx = 0;
			for (int i = 0; i < 10; i++) {
				idx = (int) (charSet.length * Math.random());
				str += charSet[idx];
			}
			log.info("메일 보낼 임시비번 " + str);
			String setForm = "ddit230901@gmail.com"; //보낼 이메일 주소
			String toMail = vMberUsersVO.getEmail(); //받을 이메일 주소
			String title = "누네띠네 회원님의 임시비밀번호 발송 이메일 입니다."; //이메일 제목
			String content = "누네띠네를 이용해 주셔서 감사합니다." + "<br><br>" + "변경된 임시비밀번호는 <div style='backgroud-color:yellow;'><b>"
					+ str + "</b> 입니다.</div><br><br>해당 임시비밀번호로 로그인 후 꼭 비밀번호를 변경해주세요.<br><br>"
							+ "<a href='localhost/main'>누네띠네로 돌아가기</a>";
			mailSend(setForm, toMail, title, content); //메일 전송 메소드 호출
			
			map.put("imsiPw", str);
			// 임시비밀번호로 변경
			int result = this.memberJoinService.updatePw(map);
//			log.info("비번 변경여부 : " + result);
		}
		return map;
	}
	
	//이메일 전송 메소드
		public void mailSend(String setForm, String toMail, String title, String content) {
			//true, 매개값 주면 multipart 형싱의 메세지 전달 가능, 인코딩도 가능
			MimeMessage message = mailSender.createMimeMessage();
			log.info("메일전송 성공");
			try {
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setForm);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true); //true면 html형식으로 전송, 아니면 text로 그냥 감
				mailSender.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}

}





