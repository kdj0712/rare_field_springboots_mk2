package com.yojulab.study_springboot.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "user_member")
public class User implements UserDetails {
    @Id
    @Column(name = "user_ID")
    private String userID;

    @Column(name = "user_pswd")
    private String password;

    @Column(name = "user_email")
    private String email;

    @Column(name = "user_name")
    private String name;

    @Column(name = "user_phone")
    private String phone;

    @Column(name = "user_birth")
    private String birth;

    @Column(name = "user_postcode")
    private String postcode;

    @Column(name = "user_address")
    private String address;

    @Column(name = "user_detailed_address")
    private String detailedAddress;

    @Column(name = "user_sex")
    private String sex;

    @Column(name = "path_select")
    private String pathSelect;

    @Column(name = "user_who")
    private String userWho;

    @Column(name = "related_diseases")
    private String relatedDiseases;

    @Column(name = "hope_info")
    private String hopeInfo;

    @Column(name = "user_info_aggree")
    private String userInfoAgree;

    @Column(name = "auth")
    private String auth;

    @Transient
    private Map<String, Object> userInfo;

    @Transient
    private List<GrantedAuthority> authorities;

    public User() {
        // Default constructor
    }

    public User(Map<String, Object> userInfo) {
        this.userInfo = userInfo;
        this.userID = (String) userInfo.get("user_ID");
        this.password = (String) userInfo.get("user_pswd");
        this.authorities = new ArrayList<>();
        List<Map<String, Object>> resultList = (List<Map<String, Object>>) userInfo.get("resultList");
        for (Map<String, Object> item : resultList) {
            this.authorities.add(new SimpleGrantedAuthority((String) item.get("UNIQUE_ID")));
        }
    }

    // Getters and setters
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return userID; // UserDetails 인터페이스의 getUsername() 메서드와 매핑
    }

    public void setUsername(String username) {
        this.userID = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetailedAddress() {
        return detailedAddress;
    }

    public void setDetailedAddress(String detailedAddress) {
        this.detailedAddress = detailedAddress;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPathSelect() {
        return pathSelect;
    }

    public void setPathSelect(String pathSelect) {
        this.pathSelect = pathSelect;
    }

    public String getUserWho() {
        return userWho;
    }

    public void setUserWho(String userWho) {
        this.userWho = userWho;
    }

    public String getRelatedDiseases() {
        return relatedDiseases;
    }

    public void setRelatedDiseases(String relatedDiseases) {
        this.relatedDiseases = relatedDiseases;
    }

    public String getHopeInfo() {
        return hopeInfo;
    }

    public void setHopeInfo(String hopeInfo) {
        this.hopeInfo = hopeInfo;
    }

    public String getUserInfoAgree() {
        return userInfoAgree;
    }

    public void setUserInfoAgree(String userInfoAgree) {
        this.userInfoAgree = userInfoAgree;
    }

    public String getAuth() {
        return auth;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }

    public Map<String, Object> getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(Map<String, Object> userInfo) {
        this.userInfo = userInfo;
    }

    public void setAuthorities(List<GrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    // UserDetails 인터페이스 구현 메서드들
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
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
