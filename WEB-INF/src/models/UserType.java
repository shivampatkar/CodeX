package models;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utils.DBConnect;

public class UserType {
    private int userTypeId;
    private String type;

    public UserType(){
        
    }

    public UserType(Integer userTypeId){
        this.userTypeId = userTypeId;
    }

    // other methods
    public String getRoleByUserTypeId(int userTypeId) {
        String role = null;
        try{ 
            Connection con = DBConnect.getConnection();
            String query = "select type from user_types where user_type_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userTypeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                role = rs.getString("type");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return role;
    }

    // setter and getter 
    public void setType(String type){
        this.type = type;
    }

    public String getType(){
        return type;
    }

    public void setUserTypeId(Integer userTypeId){
        this.userTypeId = userTypeId;
    }

    public Integer getUserTypeId(){
        return userTypeId;
    }

}
