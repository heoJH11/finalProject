package kr.or.ddit.pro.join.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.pro.join.mapper.ProJoinMapper;
import kr.or.ddit.pro.join.service.ProJoinService;
import kr.or.ddit.vo.AdresVO;
import kr.or.ddit.vo.SpcltyRealmVO;
import kr.or.ddit.vo.UsersVO;
import kr.or.ddit.vo.VMberUsersVO;
import kr.or.ddit.vo.VOndyclProUsersVO;
import kr.or.ddit.vo.VProUsersVO;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Slf4j
@Service
public class ProJoinServiceImpl implements ProJoinService {
	
	@Autowired
	ProJoinMapper proJoinMapper;
	
	@Override
	public int emailCk(String email) {
		return this.proJoinMapper.emailCk(email);
	}

	@Override
	public int idCk(String userId) {
		return this.proJoinMapper.idCk(userId);
	}

	@Override
	public int ncnmCk(String userNcnm) {
		return this.proJoinMapper.ncnmCk(userNcnm);
	}
	
	@Override
	public void certifiedPhoneNumber(String proMbtlnum, String numStr) {
		 String api_key = "NCSLIUVALN15NV86";
        String api_secret = "YCBUEUDBEZA5DMIDC6OAFBY08MRGMZZE";
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", proMbtlnum);    // 수신전화번호
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
	public UsersVO proLogin(Map<String, Object> userMap) {
		return this.proJoinMapper.proLogin(userMap);
	}
	
	@Override
	public int proInsert(Map<String, Object> map) {
		return this.proJoinMapper.proInsert(map);
	}

	@Override
	public VProUsersVO getProfile(Map<String, Object> userMap) {
		return this.proJoinMapper.getProfile(userMap);
	}

	@Override
	public UsersVO idSearch(VProUsersVO vProUsersVO) {
		return this.proJoinMapper.idSearch(vProUsersVO);
	}

	@Override
	public UsersVO pwSearch(VProUsersVO vProUsersVO) {
		return this.proJoinMapper.pwSearch(vProUsersVO);
	}

	@Override
	public int updatePw(Map<String, Object> map) {
		return this.proJoinMapper.updatePw(map);
	}

	@Override
	public VMberUsersVO idSearch2(VProUsersVO vProUsersVO) {
		return this.proJoinMapper.idSearch2(vProUsersVO);
	}

	@Override
	public String pwSearch2(VProUsersVO vProUsersVO) {
		return this.proJoinMapper.pwSearch2(vProUsersVO);
	}


	@Override
	public AdresVO getAdres(Map<String, Object> userMap) {
		return this.proJoinMapper.getAdres(userMap);
	}

	@Override
	public String proSRCode(String spcltyRealmCode) {
		return this.proJoinMapper.proSRCode(spcltyRealmCode);
	}

	@Override
	public List<SpcltyRealmVO> selectCode() {
		return this.proJoinMapper.selectCode();
	}

	@Override
	public List<SpcltyRealmVO> codeSelect(String code) {
		return this.proJoinMapper.codeSelect(code);
	}


	//관리자
	@Override
	public UsersVO admLogin(Map<String, Object> userMap) {
		// TODO Auto-generated method stub
		return this.proJoinMapper.admLogin(userMap);
	}

	@Override
	public UsersVO adminVO(String userId) {
		// TODO Auto-generated method stub
		return this.proJoinMapper.adminVO(userId);
	}

	@Override
	public List<VOndyclProUsersVO> proMyClassList(String proId) {
		List<VOndyclProUsersVO> vOndyclProUsersVOList = this.proJoinMapper.proMyClassList(proId);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String todayStr = sdf.format(date);
		try {
		    Date today = sdf.parse(todayStr);

		    for(int i = 0; i < vOndyclProUsersVOList.size(); i++) {
		        Date ondyclSchdulDe = sdf.parse(vOndyclProUsersVOList.get(i).getOndyclSchdulDe());

		        boolean dayCheck = ondyclSchdulDe.before(today);
		        vOndyclProUsersVOList.get(i).setDayCheck(dayCheck);
		        log.info("시간 비교 : " + todayStr + "/" + ondyclSchdulDe + " 불린 : " + dayCheck);
		    }
		} catch (ParseException e) {
		    e.printStackTrace();
		}
		
		return vOndyclProUsersVOList;
	}

	@Override
	public int countProMyClass(String proId) {
		return this.proJoinMapper.countProMyClass(proId);
	}
	
	//동균 신고처리 추가
	@Override
	public Date getUserEndDt(String userId) {
		return this.proJoinMapper.getUserEndDt(userId);
	}
	//동균 추가 끝

}
