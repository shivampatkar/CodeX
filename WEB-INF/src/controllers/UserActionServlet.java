package controllers;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

import java.io.IOException;

import models.User;
import utils.EmailSender;
import utils.EmailTemplate;
import utils.GenerateCode;

@WebServlet("/user_action.do")
public class UserActionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");

        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        JSONObject result = new JSONObject();
        boolean success = false;

        if (action != null && userIdStr != null) {
            User user = new User();
            Integer userId = Integer.parseInt(userIdStr);

            if (action.equals("ban")) {
                success = user.updateUserStatus(userId, 3);
            } else if (action.equals("unban")) {
                success = user.updateUserStatus(userId, 1);
            } else if (action.equals("promote")) {
                // Get user details
                User targetUser = User.getUserDetailsById(userId);
                if (targetUser != null) {
                    String verificationCode = GenerateCode.getVerificationCode();

                    success = user.savePromotionCode(userId, verificationCode);
                    
                    if (success) {
                        String baseURL = request.getScheme() + "://" + request.getServerName() + ":" 
                                       + request.getServerPort() + request.getContextPath();
                        
                        String emailBody = EmailTemplate.moderatorInvitationMail(
                            targetUser.getName(), 
                            targetUser.getEmail(), 
                            verificationCode, 
                            baseURL,
                            targetUser.getQuestionCount(),
                            targetUser.getReplyCount()
                        );
                        
                        EmailSender.sendEmail(
                            targetUser.getEmail(),
                            "Invitation to become a Moderator",
                            emailBody
                        );
                    }
                }
            } 
    }

        result.put("success", success);
        response.getWriter().write(result.toString());
    }
}
