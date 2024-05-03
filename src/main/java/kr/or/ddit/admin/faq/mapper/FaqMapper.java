package kr.or.ddit.admin.faq.mapper;

import java.util.List;

import kr.or.ddit.admin.faq.vo.FaqVO;

public interface FaqMapper {
	
	public List<FaqVO> faqList();

	public int faqUpdate(FaqVO faqVO);

	public int delete(FaqVO faqVO);

	public int createRegister(FaqVO faqVO);

}
