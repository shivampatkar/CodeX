package controllers;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import models.User;
import utils.GenerateCode;
import models.Country;

@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Date dob = Date.valueOf(request.getParameter("dob"));
        String gender = request.getParameter("gender");
        Country country = new Country(Integer.parseInt(request.getParameter("country_id")));

        String picPath = "static/media/images/default-user.png";
        if ("M".equals(gender)) {
            picPath = "static/media/images/male-user.svg";
        } else if ("F".equals(gender)) {
            picPath = "static/media/images/female-user.svg";
        }

        String activationCode = GenerateCode.getVerificationCode();

        User user = new User(name, email, password, dob, gender, country, picPath);

        user.setActivationCode(activationCode);
        String nextPage = "index.do?register=false";

        if (user.registerUser()) {
            if (user.getUserId() != null) {
                String uploadPath = getServletContext().getRealPath("/uploads");

                String folderName = user.getUserId() + "_" + user.getEmail();
                File file = new File(uploadPath, folderName);

                if (!file.exists()) {
                    file.mkdir();
                }

                nextPage = "index.do?register=true";
            }
        }

        response.sendRedirect(nextPage);

    }
}