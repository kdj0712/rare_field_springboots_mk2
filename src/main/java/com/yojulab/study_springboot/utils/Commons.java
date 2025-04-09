package com.yojulab.study_springboot.utils;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class Commons {
    public String getUniqueSequence() {
        UUID uuid = UUID.randomUUID();
        return uuid.toString();
    }    

    
    public boolean makeFolder(String folderPath){
        
        File folder = new File(folderPath);
        
        if (!folder.exists()) { // 폴더가 존재하지 않는 경우
            boolean created = folder.mkdirs(); // 폴더 생성
            
            if (created) {
                System.out.println("폴더가 성공적으로 생성되었습니다.");
            } else {
                System.out.println("폴더 생성에 실패하였습니다.");
                return false;
            }
        } else {
            System.out.println("이미 해당 경로에 폴더가 존재합니다.");
        }        
        return true;
    }

     public void saveFile(MultipartFile file, String fileName) throws IOException {
         if (!file.isEmpty()) {
             byte[] bytes = file.getBytes();
             File savedFile = new File(fileName + ".jpg"); // or any other format you wish to save in.
             file.transferTo(savedFile);
         }
     }    
}