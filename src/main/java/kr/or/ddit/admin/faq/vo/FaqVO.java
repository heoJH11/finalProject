package kr.or.ddit.admin.faq.vo;

import lombok.Data;

@Data
public class FaqVO {
	private int rnum;
	private int faqNo;
	private String faqQestn;
	private String faqAnswer;
	private String mngrId;
}
