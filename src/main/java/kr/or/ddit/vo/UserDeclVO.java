package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class UserDeclVO {
	
	private int declNo;
	private String declResn;
	private String declDetailCn;
	private String userId;
	private String userId2;
	private int declProcessAt;
	private String declProcessResult;
	private Date declRceptDe;
	private Date punshEndde;
	private int sprviseAtchmnflNo;
	private int punshNo;
	private int count;
}
