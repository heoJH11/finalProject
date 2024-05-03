package kr.or.ddit.admin.usersSearch.service.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.usersSearch.mapper.UsersSearchMapper;
import kr.or.ddit.admin.usersSearch.service.UsersSearchService;
import kr.or.ddit.admin.usersSearch.vo.UsersVO;

@Service
public class UsersSearchServiceImpl implements UsersSearchService {

	@Autowired
	UsersSearchMapper usersSearchMapper;
	
	@Override
	public int getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.usersSearchMapper.getTotal(map);
	}

	@Override
	public List<UsersVO> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.usersSearchMapper.list(map);
	}

	@Override
	public UsersVO detail(String userId) {
		return this.usersSearchMapper.detail(userId);
	}

	@Override
	public String getUserProfile(String userId) {
		// TODO Auto-generated method stub
		return this.usersSearchMapper.getUserProfile(userId);
	}

	@Override
	public int userDanger(String userId) {
		// TODO Auto-generated method stub
		return this.usersSearchMapper.userDanger(userId);
	}

}
