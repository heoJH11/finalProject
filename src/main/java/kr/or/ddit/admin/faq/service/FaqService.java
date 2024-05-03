package kr.or.ddit.admin.faq.service;

import java.util.List;

import kr.or.ddit.admin.faq.vo.FaqVO;

public interface FaqService {

	public List<FaqVO> faqList();

	public int faqUpdate(FaqVO faqVO);

	public int delete(FaqVO faqVO);

	public int createRegister(FaqVO faqVO);


}
