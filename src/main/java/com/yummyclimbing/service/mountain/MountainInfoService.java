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
import com.yummyclimbing.vo.mountain.MountainImgAndTrafficItemVO;
import com.yummyclimbing.vo.mountain.MountainImgAndTrafficResponseVO;
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
		return response.getBody().getItems();
	}
	
	public List<MountainImgAndTrafficItemVO> getMountainImgAndTrafficInfoList(){ // DATA.GO.KR 산정보 API 데이터(이미지) 가져오기
		Map<String,Object> apiParam = new HashMap<>();
		apiParam.put("servicekey", serviceKey);
		apiParam.put("pageNo", pageNo);
		apiParam.put("numOfRows", numOfRowsImgAndTraffic);
		
		MountainImgAndTrafficResponseVO response = rest.getData(mountainImgAndTrafficURL, MountainImgAndTrafficResponseVO.class, apiParam);
		int resCount = response.getBody().getTotalCount();
		int getCount = response.getBody().getItems().size();
		
		log.debug("resCount=>{}", resCount);
		log.debug("getCount=>{}", getCount);
		
		//api 응답 개수와 list의 총개수 비교
		if(resCount!=getCount) {
			throw new RuntimeException("api정보 불러오기 오류(개수가 맞지 않습니다)");
		}
//		log.debug("res=>{}",response);
		return response.getBody().getItems();
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
//		log.debug("res=>{}",response);
		return response.getBody().getItems();
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
	
	public int insertMountainInfo(){ // insert list
		List<MountainInfoItemVO> mountainInfoList = getMountainInfoList();
		List<MountainImgAndTrafficItemVO> mountainImgAndTrafficList = getMountainImgAndTrafficInfoList();
		List<MountainPositionItemVO> mountainPositionList = getMountainPositionInfoList();
		
		if(mountainInfoList!=null && mountainImgAndTrafficList!=null && mountainPositionList!=null) {
			for(int i=0;i<mountainInfoList.size();i++) {
				for(int j=0;j<mountainImgAndTrafficList.size();j++) {
					if(mountainInfoList.get(i).getMntnm().equals(mountainImgAndTrafficList.get(j).getMntnnm())) {
						mountainInfoList.get(i).setMntnattchimageseq(mountainImgAndTrafficList.get(j).getMntnattchimageseq());
						mountainInfoList.get(i).setTourisminf(mountainImgAndTrafficList.get(j).getPbtrninfodscrt());
						
						for(int z=0;z<mountainPositionList.size();z++) {
							if(mountainInfoList.get(i).getMntnm().equals(mountainPositionList.get(z).getFrtrlNm())){
								mountainInfoList.get(i).setLat(mountainPositionList.get(z).getLat());
								mountainInfoList.get(i).setLot(mountainPositionList.get(z).getLot());
							}
						}
					}
				}
			}
		} else {
			throw new RuntimeException("api리스트 오류");
		}
		//log.debug("mountainInfoList=>",mountainInfoList);

		int result = mountainInfoMapper.insertMountainInfoList(mountainInfoList);
		
		if(result!=1) {
			throw new RuntimeException("insert 실패");
		}
		return result;
	}
	
//	public int updateMountainInfoList(){ // update list(통합)
//		List<MountainInfoItemVO> mountainInfoList = getMountainInfoList();
//		
//		if(mountainInfoList!=null && mountainInfoList.size()==numOfRows100) {
//			return mountainInfoMapper.updateMountainInfoList(mountainInfoList);
//		}
//		return 0;
//	}
	
	public int updateMountainInfos(){ // update(단건 반복)
		List<MountainPositionItemVO> mountainPositionList = getMountainPositionInfoList();
		List<MountainImgAndTrafficItemVO> mountainImgAndTrafficList = getMountainImgAndTrafficInfoList();
		List<MountainInfoItemVO> mountainInfoList = getMountainInfoList();
		int result = 0;
		
		if(mountainInfoList!=null && mountainImgAndTrafficList!=null && mountainPositionList!=null) {
			for(int i=0;i<mountainInfoList.size();i++) {
				for(int j=0;j<mountainImgAndTrafficList.size();j++) {
					if(mountainInfoList.get(i).getMntnm().equals(mountainImgAndTrafficList.get(j).getMntnnm())) {
						mountainInfoList.get(i).setMntnattchimageseq(mountainImgAndTrafficList.get(j).getMntnattchimageseq());
						mountainInfoList.get(i).setTourisminf(mountainImgAndTrafficList.get(j).getPbtrninfodscrt());
						
						for(int z=0;z<mountainPositionList.size();z++) {
							if(mountainInfoList.get(i).getMntnm().equals(mountainPositionList.get(z).getFrtrlNm())){
								mountainInfoList.get(i).setLat(mountainPositionList.get(z).getLat());
								mountainInfoList.get(i).setLot(mountainPositionList.get(z).getLot());
							}
						}
					}
				}
			}
		} else {
			throw new RuntimeException("api리스트 오류");
		}
		log.debug("mountainInfoList=>{}",mountainInfoList);

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
	
	public List<MountainInfoItemVO> selectRecommendedMountainInfoList(){
		return mountainInfoMapper.selectRecommendedMountainList();
	}
	
	public List<MountainSearchVO> selectMountainNameAndArea(MountainSearchVO mountainSearch) {
		return mountainInfoMapper.selectMountainNameAndArea(mountainSearch);
	}
}
