package com.yummyclimbing.service.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.party.PartyInfoMapper;
import com.yummyclimbing.vo.party.PartyInfoVO;
import com.yummyclimbing.vo.user.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PartyInfoService {

	@Autowired
	private PartyInfoMapper partyInfoMapper;

	// 소모임 리스트
	public List<PartyInfoVO> getPartyList(PartyInfoVO partyInfo) {
		return partyInfoMapper.selectPartyInfoList(partyInfo);
	}

	// 개별 소모임 화면
	public PartyInfoVO getPartyInfo(int piNum) {
		return partyInfoMapper.selectPartyInfo(piNum);
	}

	// 개별 소모임 화면 - 멤버 정보 보기
	public List<UserInfoVO> getPartyMembers(int piNum) {
		return partyInfoMapper.selectPartyMemberList(piNum);
	}

	// 소모임 생성
	public boolean createParty(PartyInfoVO partyInfo) {
		return partyInfoMapper.insertPartyInfo(partyInfo) == 1;
	}

	// 소모임 수정
	public boolean updatePartyInfo(PartyInfoVO partyInfo) {
		if (partyInfoMapper.selectCaptainNum(partyInfo) == null) {
			return false;
		}
		return partyInfoMapper.updatePartyInfo(partyInfo) == 1;
	}

	// 소모임 삭제(비활성화) 및 모집완료
	public boolean updatePartyActive(PartyInfoVO partyInfo) {
		if (partyInfoMapper.selectCaptainNum(partyInfo) == null) {
			return false;
		}
		return partyInfoMapper.updatePartyActive(partyInfo) == 1;
	}

	// 소모임 모집기한 만료
	public int updatePartyExpired(String piExpdat) {
		return partyInfoMapper.updatePartyActiveByExpdat(piExpdat);
	}

}
