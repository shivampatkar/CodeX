package controllers;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;

import models.User;

@WebServlet("/update_profile_pic.do")
public class UpdateProfilePicServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        User user = (User)session.getAttribute("user");

        if(user == null){
            response.getWriter().write("expired");
            return;
        }

        if(ServletFileUpload.isMultipartContent(request)) {
            try{
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                FileItem fileItem = null;
                for(FileItem item : items) {
                    if(!item.isFormField()) {
                        fileItem = item;
                        break;
                    }
                }

                String fileName = "profile_pic" + System.currentTimeMillis() +".jpg";
                String uploadPath = getServletContext().getRealPath("uploads/" + user.getUserId() + "_" + user.getEmail());

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                File file = new File(uploadPath, fileName);
                try {
                    if(fileItem != null) {
                        fileItem.write(file);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                
                String picPath = "uploads/" + user.getUserId() + "_" + user.getEmail() + "/" + fileName;

                System.out.println(picPath);

                if(user.updateProfilePic(picPath)) {
                    user.setPicPath(picPath);
                    session.setAttribute("user", user);
                    response.getWriter().write("updated");
                } else {
                    response.getWriter().write("db_error");
                }

            }catch (FileUploadException e) {
                e.printStackTrace();
                response.getWriter().write("error");
            }
        }

    }
}
