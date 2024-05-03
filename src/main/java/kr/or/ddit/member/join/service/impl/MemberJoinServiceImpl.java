package kr.or.ddit.member.join.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.member.join.mapper.MemberJoinMapper;
import kr.or.ddit.member.join.service.MemberJoinService;
import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.UsersVO;
import kr.or.ddit.vo.VMberUsersVO;
import kr.or.ddit.vo.VProUsersVO;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberJoinServiceImpl implements MemberJoinService {
	@Autowired
	MemberJoinMapper memberJoinMapper;

	@Override
	public int emailCk(String email) {
		return this.memberJoinMapper.emailCk(email);
	}

	@Override
	public int idCk(String userId) {
		return this.memberJoinMapper.idCk(userId);
	}

	@Override
	public int ncnmCk(String userNcnm) {
		return this.memberJoinMapper.ncnmCk(userNcnm);
	}

	@Override
	public void certifiedPhoneNumber(String mberMbtlnum, String numStr) {
		String api_key = "NCSLIUVALN15NV86";
        String api_secret = "YCBUEUDBEZA5DMIDC6OAFBY08MRGMZZE";
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", mberMbtlnum);    // 수신전화번호
        params.put("from", "01083354487");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "문자메세지 테스트 : 인증번호는" + "["+numStr+"]" + "입니다.");
        params.put("app_version", "test app 1.2"); // application name and version
        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
		
	}

	@Override
	public UsersVO memberLogin(Map<String, Object> userMap) {
		return this.memberJoinMapper.memberLogin(userMap);
	}

	@Override
	public int memberInsert(Map<String, Object> map) {
		return this.memberJoinMapper.memberInsert(map);
	}

	@Override
	public VMberUsersVO getProfile(Map<String, Object> userMap) {
		return this.memberJoinMapper.getProfile(userMap);
	}

	@Override
	public UsersVO pwSearch(VMberUsersVO vMberUsersVO) {
		return this.memberJoinMapper.pwSearch(vMberUsersVO);
	}

	@Override
	public UsersVO idSearch(VMberUsersVO vMberUsersVO) {
		return this.memberJoinMapper.idSearch(vMberUsersVO);
	}

	@Override
	public int updatePw(Map<String, Object> map) {
		return this.memberJoinMapper.updatePw(map);
	}

	@Override
	public VProUsersVO idSearch2(VMberUsersVO vMberUsersVO) {
		return this.memberJoinMapper.idSearch2(vMberUsersVO);
	}

	@Override
	public String pwSearch2(VMberUsersVO vMberUsersVO) {
		return this.memberJoinMapper.pwSearch2(vMberUsersVO);
	}

	@Override
	public AdresVO getAdres(Map<String, Object> map) {
		return this.memberJoinMapper.getAdres(map);
	}

}
