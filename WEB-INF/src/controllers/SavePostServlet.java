package controllers;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import models.User;
import models.Post;
import models.PostData;
import models.Question;
import models.Topic;
import models.Status;

@WebServlet("/save_post.do")
public class SavePostServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("home.jsp?error=user_not_logged_in");
            return;
        }

        String title = null;
        Integer topicId = null;
        ArrayList<String> descriptions = new ArrayList<>();
        ArrayList<String> imagePaths = new ArrayList<>();

        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            try {
                List<FileItem> items = upload.parseRequest(request);
                boolean isFileUploaded = false;

                String uploadPath = "uploads/" + user.getUserId() + "_" + user.getEmail();
                File uploadDir = new File(getServletContext().getRealPath("/") + uploadPath);
                
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        if (item.getFieldName().equals("questionTitle")) {
                            title = item.getString();
                        } else if (item.getFieldName().equals("topicSelect")) {
                            topicId = Integer.parseInt(item.getString());
                        } else if (item.getFieldName().equals("descriptions")) {
                            descriptions.add(item.getString());
                        }
                    } else if (!item.isFormField()) {
                        String fileName = item.getName().trim();
                        if (fileName.isEmpty()) {
                            continue;
                        }
                
                        isFileUploaded = true; 
                        if (!uploadDir.exists()) {
                            System.out.println("Creating user folder: " + uploadDir.getAbsolutePath());
                            uploadDir.mkdirs();
                        }
                        fileName = fileName.replaceAll("\\s+", "_");
                        String filePath = uploadPath + "/" + fileName;
                        File file = new File(uploadDir, fileName);
                
                        try {
                            item.write(file);
                            imagePaths.add(filePath);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
                
                if (!isFileUploaded && !uploadDir.exists()) {
                    System.out.println("No file uploaded. Folder was not created.");
                }
                
                
            } catch (FileUploadException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp?error=file_upload_exception");
                return;
            }
        }
        if (title == null || topicId == null || descriptions.isEmpty()) {
            response.sendRedirect("error.jsp?error=missing_fields");
            return;
        }


        // if title are description is present then save the post only
        Post post = new Post(user, true, 0, new Status(5)); 
        Integer postId = post.savePost();

        // checing if post id is not null then proceed 
        if (postId != null) {
            post.setPostId(postId);
            Question question = new Question(post, title, new Topic(topicId));
            question.save();
            question.getTopic().updateQuestionCount();
            user.incrementQuestionCount();

            // Saving PostData entries for each additional description and image
            for (int i = 0; i < descriptions.size(); i++) {
                String imgPath = (i < imagePaths.size()) ? imagePaths.get(i) : null;
                new PostData(post, descriptions.get(i), imgPath).save();
            }
            response.sendRedirect("index.do?success=post_created");
        } else {
            response.sendRedirect("index.do?error=post_creation_failed");
        }
    }

}
