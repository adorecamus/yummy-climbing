package com.yummyclimbing.service.mountain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.yummyclimbing.mapper.mountain.MountainInfoMapper;
import com.yummyclimbing.rest.Rest;
import com.yummyclimbing.vo.mountain.MountainImgItemVO;
import com.yummyclimbing.vo.mountain.MountainImgResponseVO;
import com.yummyclimbing.vo.mountain.MountainInfoItemVO;
import com.yummyclimbing.vo.mountain.MountainInfoResponseVO;
import com.yummyclimbing.vo.mountain.MountainPositionItemVO;
import com.yummyclimbing.vo.mountain.MountainPositionResponseVO;
import com.yummyclimbing.vo.mountain.MountainSearchVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@PropertySource("classpath:env.properties")
public class MountainInfoService {
	//---property value----//	
	@Value("${mountain.info.url}")
	private String mountainInfoURL; // api service url
	@Value("${mountain.img_and_traffic.url}")
	private String mountainImgAndTrafficURL; // api service(ImgAndTraffic) url
	@Value("${mountain.position.url}")
	private String mountainPositionURL; // api service(Position) url
	@Value("${mountain.service.key}")
	private String serviceKey; // api key
	@Value("${mountain.num_of_rows_hundred}")
	private int numOfRows100; // 100대 명산 산개수(100개)
	@Value("${mountain.num_of_rows_img_and_traffic}")
	private int numOfRowsImgAndTraffic; // 산 이미지&교통정보 numOfRows
	@Value("${mountain.num_of_rows_position}")
	private int numOfRowsPosition; // 산 위치 리스트 numOfRows
	@Value("${mountain.page_no}")
	private int pageNo; // 1 고정
	
    //-----Dependency injection----///
	@Autowired
	public Rest rest; // rest template
	@Autowired
	public MountainInfoMapper mountainInfoMapper;
	
	public List<MountainInfoItemVO> getMountainInfoList(){ // DATA.GO.KR 100대산 정보 API 데이터 가져오기
		Map<String,Object> apiParam = new HashMap<>();
		apiParam.put("servicekey", serviceKey);
		apiParam.put("pageNo", pageNo);
		apiParam.put("numOfRows", numOfRows100);
		
		MountainInfoResponseVO response = rest.getData(mountainInfoURL, MountainInfoResponseVO.class, apiParam);
		int resCount = response.getBody().getTotalCount();
		int getCount = response.getBody().getItems().size();
		
		log.debug("resCount=>{}", resCount);
		log.debug("getCount=>{}", getCount);
		
		//api 응답 개수와 list의 총개수 비교
		if(resCount!=getCount) {
			throw new RuntimeException("api정보 불러오기 오류(개수가 맞지 않습니다)");
		}
		List<MountainInfoItemVO> list = response.getBody().getItems();
		if(list==null) {
			throw new RuntimeException("api리스트 오류");
		}
		return list;
	}
	
	public List<MountainImgItemVO> getMountainImgAndTrafficInfoList(){ // DATA.GO.KR 산정보 API 데이터(이미지) 가져오기
		Map<String,Object> apiParam = new HashMap<>();
		apiParam.put("servicekey", serviceKey);
		apiParam.put("pageNo", pageNo);
		apiParam.put("numOfRows", numOfRowsImgAndTraffic);
		
		MountainImgResponseVO response = rest.getData(mountainImgAndTrafficURL, MountainImgResponseVO.class, apiParam);
		int resCount = response.getBody().getTotalCount();
		int getCount = response.getBody().getItems().size();
		
		log.debug("resCount=>{}", resCount);
		log.debug("getCount=>{}", getCount);
		
		//api 응답 개수와 list의 총개수 비교
		if(resCount!=getCount) {
			throw new RuntimeException("api정보 불러오기 오류(개수가 맞지 않습니다)");
		}
//		log.debug("res=>{}",response);

		List<MountainImgItemVO> list = response.getBody().getItems();
		if(list==null) {
			throw new RuntimeException("api리스트 오류");
		}
		return list;
	}
	
	public List<MountainPositionItemVO> getMountainPositionInfoList(){ // DATA.GO.KR 산위치 API 데이터 가져오기
		Map<String,Object> apiParam = new HashMap<>();
		apiParam.put("servicekey", serviceKey);
		apiParam.put("pageNo", pageNo);
		apiParam.put("numOfRows", numOfRowsPosition);
		apiParam.put("srchPlaceTpeCd", "PEAK");
		apiParam.put("type", "xml");
		
		MountainPositionResponseVO response = rest.getData(mountainPositionURL, MountainPositionResponseVO.class, apiParam);
		int resCount = response.getBody().getTotalCount();
		int getCount = response.getBody().getItems().size();
		
		log.debug("resCount=>{}", resCount);
		log.debug("getCount=>{}", getCount);
		
		//api 응답 개수와 list의 총개수 비교
		if(resCount!=getCount) {
			throw new RuntimeException("api정보 불러오기 오류(개수가 맞지 않습니다)");
		}

		List<MountainPositionItemVO> list = response.getBody().getItems();
		if(list==null) {
			throw new RuntimeException("api리스트 오류");
		}
//		log.debug("res=>{}",response);
		return list;
	}
	
	public List<MountainInfoItemVO> selectMountainInfoList(MountainInfoItemVO mountainInfo){
		return mountainInfoMapper.selectMountainInfoList(mountainInfo);
	}
	
	public MountainInfoItemVO selectMountainInfoByMntnm(String mntnm) {
		return mountainInfoMapper.selectMountainInfoByMntnm(mntnm);
	}
	
	public MountainInfoItemVO selectMountainInfoByMiNum (int miNum) {
		return mountainInfoMapper.selectMountainInfoByMiNum(miNum);
	}
	
	private MountainImgItemVO getMountainImgItemVO(List<MountainImgItemVO> list, String mntnm) {
		for(MountainImgItemVO obj : list) {
			if(mntnm.equals(obj.getMntnnm())){
				return obj;
			}
		}
		return null;
	}
	
	private MountainPositionItemVO getMountainPositionItemVO(List<MountainPositionItemVO> list, String mntnm) {
		for(MountainPositionItemVO obj : list) {
			if(mntnm.equals(obj.getFrtrlNm())){
				return obj;
			}
		}
		return null;
	}
	
	public int insertMountainInfo(){ // insert list
		List<MountainInfoItemVO> mountainInfoList = getMountainInfoList(); // core vo
		List<MountainImgItemVO> mountainImgAndTrafficList = getMountainImgAndTrafficInfoList();
		List<MountainPositionItemVO> mountainPositionList = getMountainPositionInfoList();

		for(MountainInfoItemVO mii : mountainInfoList) {
			MountainImgItemVO miti = getMountainImgItemVO(mountainImgAndTrafficList, mii.getMntnm());
			mii.setMntnattchimageseq(miti.getMntnattchimageseq());
			mii.setTourisminf(miti.getPbtrninfodscrt());
			
			MountainPositionItemVO mpi = getMountainPositionItemVO(mountainPositionList, mii.getMntnm());
			mii.setLat(mpi.getLat());
			mii.setLot(mpi.getLot());
		}
		
		if(mountainInfoMapper.insertMountainInfoList(mountainInfoList)!=1) {
			throw new RuntimeException("insert 실패");
		}
		return 1;
	}
	
	public int updateMountainInfos(){ // update(단건 반복)
		List<MountainInfoItemVO> mountainInfoList = getMountainInfoList(); // core vo
		List<MountainImgItemVO> mountainImgAndTrafficList = getMountainImgAndTrafficInfoList();
		List<MountainPositionItemVO> mountainPositionList = getMountainPositionInfoList();
		int result = 0;
		
		for(MountainInfoItemVO mii : mountainInfoList) {
			MountainImgItemVO miti = getMountainImgItemVO(mountainImgAndTrafficList, mii.getMntnm());
			mii.setMntnattchimageseq(miti.getMntnattchimageseq());
			mii.setTourisminf(miti.getPbtrninfodscrt());
			
			MountainPositionItemVO mpi = getMountainPositionItemVO(mountainPositionList, mii.getMntnm());
			mii.setLat(mpi.getLat());
			mii.setLot(mpi.getLot());
		}
				
		for(MountainInfoItemVO mountainInfo : mountainInfoList) {
			result += mountainInfoMapper.updateMountainInfo(mountainInfo);
		}
		
		if(result!=numOfRows100) {
			throw new RuntimeException("update 누락");
		}
		return result;
	}
	
	public int deleteMountainInfoList() { // delete all(where문 없는 delete)
		return mountainInfoMapper.deleteMountainInfoList();
	}
	
	public List<MountainInfoItemVO> selectRecommendedMountainInfoList(){ //추천 산 리스트
		return mountainInfoMapper.selectRecommendedMountainList();
	}
	
	public List<MountainSearchVO> selectMountainNameAndArea(MountainSearchVO mountainSearch) { //산 이름과 지역
		return mountainInfoMapper.selectMountainNameAndArea(mountainSearch);
	}
}
