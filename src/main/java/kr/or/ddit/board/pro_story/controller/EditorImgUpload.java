package kr.or.ddit.board.pro_story.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EditorImgUpload {

//	@Autowired
//	String uploadDirectCk;
	
//	이건 집에서 할때
	String uploadDirectCk = "C:\\Users\\Home\\Desktop\\ChatTest\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\finalProject\\resources\\ckFolder";

	@Autowired
	String uploadFolder;
	
	//ckeditor이미지 업로드 , data전송 -> ResponseBody 어노테이션 추가(객체화)
	@ResponseBody
	@Transactional
	@PostMapping("/upload/uploadCk")
	public Map<String , Object> uploads(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
		
		// request에 이미지 객체가 담져겨 있다. ckeditor 에서 파일을 보낼 때
		// upload : [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 밸류를 받아서 uploadFile에 저장함 , 열기 누르는 순간
		MultipartFile uploadFile = request.getFile("upload");
		log.info("uploads -> uploadFile : " + uploadFile);
		
		// 파일 오리지널 명
		String originalFileName = uploadFile.getOriginalFilename();
		log.info("uploads -> originalFileName : " + originalFileName);
		
		String ext = originalFileName.substring(originalFileName.indexOf("."));
		log.info("ext : " + ext);	// .jpg
		
		String newFileName = UUID.randomUUID() + ext;
		log.info("newFileName" + newFileName);
		// 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
	    // String realPath = request.getServletContext().getRealPath("/");
		
	    String url = request.getRequestURL().toString();
	    log.info("uploads -> url 업로드전 : " + url);
	    
	    // http://localhost/
	    // http://192.168.93.73/
	    
	    url = url.substring(0, url.indexOf("/", 7));
	    log.info("uploads -> url 업로드후: " + url);
		
		// 업로드 폴더에 저장
		// 물리적 저장 경로.../upload + "\\" + sadlfkjsafd.jpg
		
//	    String savePath = this.uploadFolderDirect + "\\" + newFileName; -> 임시 저장 경로
	    String savePath = this.uploadDirectCk+ "\\" + newFileName;
	    log.info("uploads -> savePath(임시경로) : " + savePath);
	    
	    // 웹 경로
//	    String uploadPath = this.uploadFolder +"\\" + getFolder()+"\\" +newFileName;
	    String uploadPath = getFolder().replace("\\" , "/") + "/"	+ newFileName;
	    log.info("uploadPath -> uploadPath(실제 웹 경로) " + uploadPath);
	    
	    // 설계
	    File file = new File(uploadPath);
	    
	    // 파일 업로드 처리
	    uploadFile.transferTo(file);
	    
	    Map<String, Object>map = new HashMap<>();
	    map.put("uploaded" , true);
	    map.put("url" , url + "/images/" + uploadPath);
	    // map : {uploaded = true  , url=http://localhost/resources/upload/asdasdasd~~.jpg}
	    
	    log.info("uploads -> map : " + map);
	    
	    return map;
		
	}
	
	 public boolean checkImageType(File file) {
	      //MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
	      //MIME 타입 알아냄. .jpeg / .jpg의 MIME타입 : image/jpeg
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
	 
	 public String getFolder() {
		 
		LocalDate now = LocalDate.now();
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		String fmtNow = now.format(dtf);
	      
		return fmtNow.replace("-", File.separator);
	      
	   }
	
}
