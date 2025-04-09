package com.yojulab.study_springboot.service.rarefield.users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.HashMap;
import java.util.Map;

import com.yojulab.study_springboot.dao.RareSharedDao;
import com.yojulab.study_springboot.entity.User;
import com.yojulab.study_springboot.repository.UserRepository;
import com.yojulab.study_springboot.service.sample.AuthsService;
import com.yojulab.study_springboot.utils.Commons;
import com.yojulab.study_springboot.service.rarefield.rest.RestTemplateService;

@Service
@Transactional
public class UserService {

    @Autowired
    RareSharedDao rareSharedDao;

    @Autowired
    Commons commonUtils;

    @Autowired
    AuthsService AUTHSService;
    
    @Autowired
    BCryptPasswordEncoder bcryptPasswordEncoder;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RestTemplateService restTemplateService;

    // user에 대한 insert, 
    public Object insert(Map dataMap){
        String password = (String)dataMap.get("user_pswd");
        dataMap.put("user_pswd",bcryptPasswordEncoder.encode(password));

        String sqlMapId = "RarefieldUsers.insert";
        Object result = rareSharedDao.insert(sqlMapId, dataMap);
        return result;
    }

    public boolean checkDupUser(Map dataMap){
        String sqlMapId = "RarefieldUsers.checkUID";
        Object result = rareSharedDao.getOne(sqlMapId, dataMap);

        if(result == null){
            return false;
        } else {
            return true;
        }
    }

    // user에 대한 insert 및 auth 부분
    public Object insertWithAuth(Map dataMap){
        Object result = this.insert(dataMap);
        result = AUTHSService.insert(dataMap);
        return result;
    }

    public Object selectByUID(Map dataMap) {
        String sqlMapId = "RarefieldUsers.selectByUID";
        Object result = rareSharedDao.getOne(sqlMapId, dataMap);
        return result;
    }

    public Object selectByUIDWithAuths(Map dataMap) {
        Map result = (Map) this.selectByUID(dataMap);
        result.putAll(AUTHSService.selectWithUSERNAME(dataMap));
        return result;
    }

    public Object selectAll(String user_ID){
        String sqlMapId = "RarefieldUsers.selectAll";
        HashMap dataMap = new HashMap<>();
        dataMap.put("user_ID", user_ID);

        Object result = rareSharedDao.getList(sqlMapId, dataMap);
        return result;
    }

    public String getUserHope(String userID) {
        Optional<User> user = userRepository.findByUserID(userID);
        return user.map(User::getHopeInfo).orElse("Default Hope Info"); // 사용자 정보를 찾지 못했을 경우 기본 값을 반환
    }

    public Map<String, Object> getApiResponseUsingUserHope(String userID) {
        String userHope = getUserHope(userID);
        return restTemplateService.mainnewsPostRequest(userHope);
    }
}
