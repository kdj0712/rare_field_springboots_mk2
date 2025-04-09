package com.yojulab.study_springboot.service.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yojulab.study_springboot.dao.SharedDao;
import com.yojulab.study_springboot.utils.Commons;

@Service
@Transactional
public class UsersService {

    @Autowired
    SharedDao sharedDao;

    @Autowired
    Commons commonUtils;

    @Autowired
    AuthsService AUTHSService;

        @Autowired
    BCryptPasswordEncoder bcryptPasswordEncoder;
    
    public Object insert(Map dataMap) {
        String password = (String)dataMap.get("password");
        dataMap.put("password", bcryptPasswordEncoder.encode(password));

        String sqlMapId = "Users.insert";
        Object result = sharedDao.insert(sqlMapId, dataMap);
        return result;
    }

    public Object insertWithAuths(Map dataMap){
        Object result = this.insert(dataMap);
        result = AUTHSService.insert(dataMap);
        return result;
    }

    public Object selectByUID(Map dataMap) {
        String sqlMapId = "Users.selectByUID";

        Object result = sharedDao.getOne(sqlMapId, dataMap);
        return result;
    }

    public Object selectByUIDWithAuths(Map dataMap) {
        Map result = (Map) this.selectByUID(dataMap);
        result.putAll(AUTHSService.selectWithUSERNAME(dataMap));
        return result;
    }
}