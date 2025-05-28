package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import utils.DBConnect;

public class PostData {
    private Integer postDataId;
    private Post post;             
    private String description;
    private String picPath;

    // Constructors

    public PostData() {

    }

    public PostData(Post post, String description, String picPath) {
        this.post = post;
        this.description = description;
        this.picPath = picPath;
    }

    // Other methods
    public boolean save() {
        boolean isSaved = false;
        Connection con = DBConnect.getConnection();
        try {
            String query = "insert into post_data (post_id, description, pic_path) values (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, post.getPostId());
            ps.setString(2, description);
            ps.setString(3, picPath);
            isSaved = ps.executeUpdate() > 0;
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSaved;
    } 
    
    // Setter and getters
    public Integer getPostDataId() {
        return postDataId;
    }

    public void setPostDataId(Integer postDataId) {
        this.postDataId = postDataId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPicPath() {
        return picPath;
    }
    
    public void setPicPath(String picPath) {
        this.picPath = picPath;
    }

    
}
