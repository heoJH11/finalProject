package kr.or.ddit.admin.faq.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.admin.faq.service.FaqService;
import kr.or.ddit.admin.faq.vo.FaqVO;
import kr.or.ddit.admin.notice.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/faq")
@Controller
public class FaqController {

	@Autowired
	FaqService faqService;
	
	@GetMapping("/list")
	public String faqList(Model model) {
		List<FaqVO> faqList = faqService.faqList();
		model.addAttribute("faqList",faqList);
		return "faq/list";
	}
	
	@ResponseBody
	@PostMapping("/update")
	public int faqUpdate(@RequestBody FaqVO faqVO){
		faqVO.setMngrId("testAdmin");
		log.info("update여기"+faqVO);
		int result = this.faqService.faqUpdate(faqVO);
		log.info("update->result:"+result);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public int faqDelete(@RequestBody FaqVO faqVO) {
		faqVO.setMngrId("testAdmin");
		log.info("delete:"+faqVO);
		int result = this.faqService.delete(faqVO);
		log.info("delete->result:"+result);
		return result;
	}
	
	@GetMapping(value="/create", params="register")
	public String createRegister(FaqVO faqVO) {
		
		log.info("createRegister->faqVO:" + faqVO);
		
		return "faq/create";
	}
	
	@PostMapping(value="/create", params="register")
	public String createRegisterPost(FaqVO faqVO) {
		
		faqVO.setMngrId("testAdmin");
		log.info("createRegisterPost->faqVO:" + faqVO);
		
		int result = this.faqService.createRegister(faqVO);
		log.info("createRegister->result:"+ result);
		
		return "redirect:/faq/list";
		//return "redirect:/admin/notice?noticeNo="+noticeVO.getNoticeNo();
	}
}
