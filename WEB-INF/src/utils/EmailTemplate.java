package utils;

public class EmailTemplate {
    public static String moderatorInvitationMail(String name, String email, String verificationCode, String baseURL, int questions, int replies) {
        String acceptUrl = baseURL + "/accept_moderator.do?email=" + email + "&code=" + verificationCode;

        return "<div style='max-width: 600px; margin: 50px auto; box-shadow: 0 12px 30px rgba(13, 110, 253, 0.12); font-family: \"Segoe UI\", Roboto, Arial, sans-serif; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0ff;'>\r\n" +
               "    <div style='background: linear-gradient(135deg, #0d6efd, #0a58ca); height: 90px; position: relative; padding-left: 25px; color: white;'>\r\n" +
               "        <div style='position: absolute; left: 25px; top: 25px; font-size: 28px; font-weight: bold; font-family: \"Courier New\", monospace; letter-spacing: -1px;'>&lt;/&gt;</div>\r\n" +
               "        <h1 style='position: absolute; left: 70px; top: 6px; margin: 0; font-family: \"Pacifico\", cursive, sans-serif; font-size: 36px; font-weight: 700; letter-spacing: 0.5px;'>Codex</h1>\r\n" +
               "    </div>\r\n" +
               "    <div style='padding: 35px; color: #333; line-height: 1.6;'>\r\n" +
               "        <h2 style='color: #0d6efd; font-size: 22px; margin-top: 0; margin-bottom: 20px; font-weight: 600;'>Hello " + name + ",</h2>\r\n" +
               "        <p style='margin-bottom: 20px;'>Congratulations! Based on your active participation and valuable contributions to our community, you've been selected as a potential moderator.</p>\r\n" +
               "        <p style='margin-bottom: 10px; font-weight: 500;'>Your activity metrics:</p>\r\n" +
               "        <div style='background-color: #f0f7ff; padding: 18px 25px; border-radius: 8px; margin-bottom: 25px; border-left: 4px solid #0d6efd;'>\r\n" +
               "            <div style='display: flex; justify-content: space-between; margin-bottom: 10px;'>\r\n" +
               "                <span>Questions</span>\r\n" +
               "                <span style='font-weight: bold;'>" + questions + "</span>\r\n" +
               "            </div>\r\n" +
               "            <div style='display: flex; justify-content: space-between;'>\r\n" +
               "                <span>Replies</span>\r\n" +
               "                <span style='font-weight: bold;'>" + replies + "</span>\r\n" +
               "            </div>\r\n" +
               "        </div>\r\n" +
               "        <p style='margin-bottom: 10px; font-weight: 500;'>As a moderator, you'll have additional responsibilities and permissions:</p>\r\n" +
               "        <ul style='background-color: #f0f7ff; padding: 18px 25px 18px 45px; border-radius: 8px; margin-bottom: 25px; border-left: 4px solid #0d6efd;'>\r\n" +
               "            <li style='margin-bottom: 8px;'>Review and approve/reject user content</li>\r\n" +
               "            <li style='margin-bottom: 8px;'>Handle user reports</li>\r\n" +
               "            <li>Help maintain community guidelines</li>\r\n" +
               "        </ul>\r\n" +
               "        <p style='margin-bottom: 20px;'>If you're interested in accepting this role, please click the confirmation button below:</p>\r\n" +
               "        <div style='text-align: center; margin: 35px 0;'>\r\n" +
               "            <a href='" + acceptUrl + "' style='background: linear-gradient(135deg, #0d6efd, #0a58ca); color: white; padding: 14px 30px; text-decoration: none; border-radius: 6px; font-weight: 600; display: inline-block; box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3); transition: all 0.3s ease;'>Accept Moderator Role</a>\r\n" +
               "        </div>\r\n" +
               "        <p>If you have any questions about what this role entails, feel free to reply to this email.</p>\r\n" +
               "        <p style='margin-top: 25px;'>Thank you for your contributions to our community!</p>\r\n" +
               "        <p style='margin-top: 30px; margin-bottom: 0;'>Best regards,<br><strong>The Codex Team</strong></p>\r\n" +
               "    </div>\r\n" +
               "    <div style='background: linear-gradient(135deg, #0d6efd, #0a58ca); padding: 20px 25px;'>\r\n" +
               "        <div style='display: flex; justify-content: space-between; align-items: center;'>\r\n" +
               "            <div style='color: white; font-size: 14px;'><b>&copy; " + java.time.Year.now().getValue() + " Codex. All rights reserved.</b></div>\r\n" +
               "            <div style='color: white; font-size: 26px; font-family: \"Pacifico\", cursive, monospace; font-weight: bold;'>&lt;/&gt;</div>\r\n" +
               "        </div>\r\n" +
               "    </div>\r\n" +
               "</div>";
    }
}
