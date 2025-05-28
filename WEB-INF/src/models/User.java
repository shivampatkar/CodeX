package models;

import java.sql.Date;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

import utils.DBConnect;

import org.jasypt.util.password.StrongPasswordEncryptor;

public class User {
    private Integer userId;
    private String name;
    private String email;
    private String password;
    private Timestamp createdAt;
    private String aboutMe; 
    private Date dob;
    private String gender;
    private String contact;
    private Country country;       
    private String picPath;
    private Status status;        
    private String activationCode;
    private UserType userType;     
    private Integer questionCount;
    private Integer replyCount;

    static StrongPasswordEncryptor pe = new StrongPasswordEncryptor();
    
    // Constructors
    public User(){

    }
    
    public User(String email, String password){
        this.email = email;
        this.password = password;
    }

    public User(String name, String email, String password, Date dob, String gender, Country country, String picPath){
        this.name = name;
        this.email = email;
        this.password = password;
        this.dob = dob;
        this.gender = gender;
        this.country = country;
        this.picPath = picPath;
    }

    // Other methods

    // Add to UserDAO.java

    public int getUserCountByStatus(int statusId) throws SQLException {
        int count = 0;
        Connection conn = DBConnect.getConnection();
        
        try {
            String query = "select count(*) from users where status_id = ?";
            PreparedStatement ps = conn.prepareStatement(query); 
            
            ps.setInt(1, statusId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getUserCountByType(int userTypeId) throws SQLException {
        int count = 0;
        Connection conn = DBConnect.getConnection();
        
        try { 
            String query = "select count(*) from users where user_type_id = ?";
            PreparedStatement ps = conn.prepareStatement(query); 
             
            ps.setInt(1, userTypeId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean savePromotionCode(int userId, String code) {
        boolean success = false;
        Connection conn = DBConnect.getConnection();
        try {
            String query = "update users set activation_code = ? where user_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, code);
            ps.setInt(2, userId);
            
            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);
            
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean acceptModeratorRole(String email, String code) {
        boolean success = false;
        Connection conn = DBConnect.getConnection();
        try {
            
            // First verify the code
            String query = "select user_id from users where email = ? and activation_code = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, code);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int userId = rs.getInt("user_id");
                
                // Update user_type_id to 2 (moderator) and clear activation code
                PreparedStatement updatePs = conn.prepareStatement(
                    "update users set user_type_id = 2, activation_code = null where user_id = ?"
                );
                updatePs.setInt(1, userId);
                
                int rowsAffected = updatePs.executeUpdate();
                success = (rowsAffected > 0);
                
                updatePs.close();
            }
            
            rs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean updateUserStatus(int userId, int statusId){
        Connection conn = DBConnect.getConnection();
        boolean flag = false;
        
        try {
            String query = "update users set status_id = ? where user_id = ?";

            PreparedStatement ps = conn.prepareStatement(query);
            
            ps.setInt(1, statusId);
            ps.setInt(2, userId);
            
            if(ps.executeUpdate() > 0){
                flag = true;
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    // Method to getUserDetails
    public static User getUserDetailsById(Integer userId){
        Connection con = DBConnect.getConnection();
        try{
            String query = "select * from users where user_id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1,userId);

            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setDob(rs.getDate("dob"));
                user.setGender(rs.getString("gender"));
                user.setContact(rs.getString("contact"));
                user.setPicPath(rs.getString("pic_path"));
                user.setActivationCode(rs.getString("activation_code"));
                user.setQuestionCount(rs.getInt("question_count"));
                user.setReplyCount(rs.getInt("reply_count"));

                // Set country (only ID here)
                Country country = new Country();
                country.setCountryId(rs.getInt("country_id"));
                user.setCountry(country);
    
                // Set status object
                Status status = new Status();
                status.setStatusId(rs.getInt("status_id"));
                user.setStatus(status);
    
                // Set user type
                UserType userType = new UserType();
                userType.setUserTypeId(rs.getInt("user_type_id"));
                user.setUserType(userType);
                
                return user;
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    // Method to get all Users
    public List<User> getAllUsers(int page, int pageSize) throws SQLException {
        List<User> users = new ArrayList<>();
        int offset = (page - 1) * pageSize;
    
        String query = "SELECT u.*, " +
                       "s.status_id, s.name AS status_name, " +
                       "ut.user_type_id, ut.type AS user_type " +
                       "FROM users u " +
                       "JOIN status s ON u.status_id = s.status_id " +
                       "JOIN user_types ut ON u.user_type_id = ut.user_type_id " +
                       "ORDER BY u.user_id " +
                       "LIMIT ? OFFSET ?";
    
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
    
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
    
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setAboutMe(rs.getString("about_me"));
                user.setDob(rs.getDate("dob"));
                user.setGender(rs.getString("gender"));
                user.setContact(rs.getString("contact"));
                user.setPicPath(rs.getString("pic_path"));
                user.setActivationCode(rs.getString("activation_code"));
                user.setQuestionCount(rs.getInt("question_count"));
                user.setReplyCount(rs.getInt("reply_count"));
    
                // Set country (only ID here)
                Country country = new Country();
                country.setCountryId(rs.getInt("country_id"));
                user.setCountry(country);
    
                // Set status object
                Status status = new Status();
                status.setStatusId(rs.getInt("status_id"));
                status.setName(rs.getString("status_name"));
                user.setStatus(status);
    
                // Set user type
                UserType userType = new UserType();
                userType.setUserTypeId(rs.getInt("user_type_id"));
                userType.setType(rs.getString("user_type"));
                user.setUserType(userType);
    
                users.add(user);
            }
    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return users;
    }
     
    // Method to get the total user 
    public int getTotalUsersCount() throws SQLException {
        int count = 0;
        String query = "SELECT COUNT(*) FROM users";
        
        try{  
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    

    // Methof for profile pic

    public boolean updateProfilePic(String picPath) {
        boolean flag = false;

        try{
            Connection con = DBConnect.getConnection();
            String query = "update users set pic_path = ? where user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, picPath);
            ps.setInt(2, this.userId);

            int rows = ps.executeUpdate();
            if(rows>0){
                flag = true;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // Method to increment the replies count in the users table
    public boolean incrementReplyCount() {
        boolean flag = false;
        Connection con = DBConnect.getConnection();
        try {
            String query = "update users set reply_count = reply_count + 1 where user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, this.userId);
            flag = ps.executeUpdate() > 0;
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    // Method to increment the question count in the users table
    public boolean incrementQuestionCount() {
        boolean flag = false;
        Connection con = DBConnect.getConnection();
        try {
            String query = "update users set question_count = question_count + 1 where user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, this.userId);
            flag = ps.executeUpdate() > 0;
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public boolean decrementQuestionCount(Integer userId) {
        boolean flag = false;
        Connection con = DBConnect.getConnection();
        try {
            String query = "update users set question_count = question_count - 1 where user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            flag = ps.executeUpdate() > 0;
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }
   
    // Method to login 
    public boolean loginUser() {
        boolean flag = false;

        status = new Status(-1); // Default: No email or account exists
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tdf?user=root&password=Shivam2601@");
            String query = "select * from users where email=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                if (pe.checkPassword(password, rs.getString("password"))) {
                    name = rs.getString("name");
                    userId = rs.getInt("user_id");
                    createdAt = rs.getTimestamp("created_at");
                    aboutMe = rs.getString("about_me");
                    dob = rs.getDate("dob");
                    gender = rs.getString("gender");
                    contact = rs.getString("contact");
                    country = new Country(rs.getInt("country_id"));
                    status = new Status(rs.getInt("status_id")); // 
                    picPath = rs.getString("pic_path");
                    userType = new UserType(rs.getInt("user_type_id"));
                    questionCount = rs.getInt("question_count");
                    replyCount = rs.getInt("reply_count");

                    flag = true;
                } else {
                    status = new Status(0); // Password incorrect
                }
            } else {
                status = new Status(-2); // user not found in database
            }

            rs.close();
            ps.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Database error or exception occurred
        }

        return flag;
    }


    public boolean registerUser() {
        boolean flag = false;

        try {
            Connection con = DBConnect.getConnection();

            String query = "insert into users (name, email, password, dob, gender, country_id, pic_path, created_at) values (?, ?, ?, ?, ?, ?, ?, ?)";

            // Use RETURN_GENERATED_KEYS to get the inserted user ID
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pe.encryptPassword(password));
            ps.setDate(4, dob);
            ps.setString(5, String.valueOf(gender));
            ps.setInt(6, country.getCountryId());
            ps.setString(7, picPath);
            ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));

            int result = ps.executeUpdate();

            if (result == 1) {
                // Retrieve the generated user_id
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    this.userId = rs.getInt(1);  // **Set userId in the object**
                }
                rs.close();
                flag = true;
            }

            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // ------------setter and getter ---------------

    public void setReplyCount(Integer replyCountCount){
        this.replyCount = replyCountCount;
    }

    public Integer getReplyCount(){
        return replyCount;
    }

    public void setQuestionCount(Integer questionCount){
        this.questionCount = questionCount;
    }

    public Integer getQuestionCount(){
        return questionCount;
    }

    public void setUserType(UserType userType){
        this.userType = userType;
    }

    public UserType getUserType(){
        return userType;
    }

    public void setActivationCode(String activationCode){
        this.activationCode = activationCode;
    }

    public String getActivationCode(){
        return activationCode;
    }

    public void setStatus(Status status){
        this.status = status;
    }

    public Status getStatus(){
        return status;
    }

    public void setPicPath(String picPath){
        this.picPath = picPath;
    }

    public String getPicPath(){
        return picPath;
    }

    public void setCountry(Country country){
        this.country = country;
    }

    public Country getCountry(){
        return country;
    }

    public void setContact(String contact){
        this.contact = contact;
    }

    public String getContact(){
        return contact;
    }

    public void setGender(String gender){
        this.gender = gender;
    }

    public String getGender(){
        return gender;
    }

    public void setDob(Date dob){
        this.dob = dob;
    }

    public Date getDob(){
        return dob;
    }

    public void setAboutMe(String aboutMe){
        this.aboutMe = aboutMe;
    }

    public String getAboutMe(){
        return aboutMe;
    }

    public void setCreatedAt(Timestamp createdAt){
        this.createdAt = createdAt;
    }

    public Timestamp getCreatedAt(){
        return createdAt;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public String getPassword(){
        return password;
    }

    public void setEmail(String email){
        this.email = email;
    }

    public String getEmail(){
        return email;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getName(){
        return name;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getUserId() {
        return userId;
    }

}
