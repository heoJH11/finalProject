package kr.or.ddit.admin.faq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.faq.mapper.FaqMapper;
import kr.or.ddit.admin.faq.service.FaqService;
import kr.or.ddit.admin.faq.vo.FaqVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class FaqServiceImpl implements FaqService{

	@Autowired
	FaqMapper faqMapper;
	
	@Override
	public List<FaqVO> faqList() {
		// TODO Auto-generated method stub
		return this.faqMapper.faqList();
	}

	@Override
	public int faqUpdate(FaqVO faqVO) {
		// TODO Auto-generated method stub
		return this.faqMapper.faqUpdate(faqVO);
	}

	@Override
	public int delete(FaqVO faqVO) {
		// TODO Auto-generated method stub
		return this.faqMapper.delete(faqVO);
	}

	@Override
	public int createRegister(FaqVO faqVO) {
		// TODO Auto-generated method stub
		return this.faqMapper.createRegister(faqVO);
	}

}
