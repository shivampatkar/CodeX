package controllers;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import models.Post;
import models.PostData;
import models.Question;
import models.Reply;
import models.User;
import models.Status;


@WebServlet("/save_reply.do")
public class SaveReplyServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");

        String resp = "false";

        if (user != null) {
            String description = null, imagePath = null;
            Integer originalPostId = null; 

            if (ServletFileUpload.isMultipartContent(request)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                try {
                    List<FileItem> items = upload.parseRequest(request);
                    String uploadPath = "uploads/" + user.getUserId() + "_" + user.getEmail();
                    File uploadDir = new File(getServletContext().getRealPath("/") + uploadPath);

                    for (FileItem item : items) {
                        if (item.isFormField()) {
                            if ("description".equals(item.getFieldName())) {
                                description = item.getString();
                            } else if ("post_id".equals(item.getFieldName())) {
                                originalPostId = Integer.parseInt(item.getString().trim());
                            }
                        } else {

                            String fileName = item.getName().trim();
                            if (!fileName.isEmpty()) {
                                if (!uploadDir.exists()) uploadDir.mkdirs();

                                fileName = fileName.replaceAll("\\s+", "_");
                                imagePath = uploadPath + "/" + fileName;
                                File file = new File(uploadDir, fileName);
                                if (!file.exists()) {
                                    item.write(file);
                                } else {
                                    System.out.println("File already exists: " + file.getAbsolutePath());
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(resp);
                    return;
                }
            }

            if (description == null || originalPostId == null) {
                System.out.println("Missing required fields: description or post_id is null");
                response.getWriter().write(resp);
                return;
            }

            // Save reply post
            Post replyPost = new Post(user, false, 0, new Status(5));
            Integer replyPostId = replyPost.savePost();

            if (replyPostId != null) {
                replyPost.setPostId(replyPostId);
                boolean postDataSaved = new PostData(replyPost, description, imagePath).save();
                user.incrementReplyCount();

                Integer questionId = Question.getQuestionIdByPostId(originalPostId);

                if (questionId != null) {
                    Reply reply = new Reply(new Post(replyPostId), new Question(questionId));
                    boolean replySaved = reply.saveReply();
                    if (replySaved) {
                        resp = "true";
                    }
                } else {
                    System.out.println("No Question ID found for Post ID: " + originalPostId);
                }
            } else {
                System.out.println("Failed to save reply post");
            }

            response.getWriter().write(resp);
        } else {
            response.getWriter().write("expired");
        }
    }
}
