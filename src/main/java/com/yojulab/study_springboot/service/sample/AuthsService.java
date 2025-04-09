package com.yojulab.study_springboot.service.sample;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yojulab.study_springboot.dao.SharedDao;
import com.yojulab.study_springboot.utils.Commons;

@Service
@Transactional
public class AuthsService {

    @Autowired
    SharedDao sharedDao;

    @Autowired
    Commons commonUtils;

    public Object insert(Map<String, Object> dataMap) {
        List<String> authList = new ArrayList<>();
        if (!"ROLE_MEMBER".equals((String) dataMap.get("auth"))){
            authList.add("ROLE_MEMBER");  // default auth
        }
        authList.add((String) dataMap.get("auth"));  // choosed auth
        dataMap.put("authList", authList);

        String sqlMapId = "Auths.insert";
        Object result = sharedDao.insert(sqlMapId, dataMap);
        return result;
    }

    public Map selectWithUSERNAME(Map dataMap) {
        String sqlMapId = "Auths.selectWithUSERNAME";
        
        HashMap result = new HashMap<>();
        result.put("resultList", sharedDao.getList(sqlMapId, dataMap));
        return result;
    }
}