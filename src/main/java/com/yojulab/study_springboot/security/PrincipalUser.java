package com.yojulab.study_springboot.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.yojulab.study_springboot.entity.User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public class PrincipalUser implements UserDetails {

    private User user;
    private Map<String, Object> userInfo;

    public PrincipalUser(User user, Map<String, Object> userInfo) {
        this.user = user;
        this.userInfo = userInfo;
    }

    public String getMemberName() {
        return user.getUsername();
    }

    @Override
    public Collection<GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collections = new ArrayList<>();
        List<Map<String, Object>> resultList = (List<Map<String, Object>>) userInfo.get("resultList");
        for (Map<String, Object> item : resultList) {
            collections.add(new SimpleGrantedAuthority((String) item.get("UNIQUE_ID")));
        }
        return collections;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
