package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import utils.DBConnect;

public class Post {
    private Integer postId;
    private User user;
    private Date postDate;
    private boolean postType;
    private Integer spamCount;
    private Status status;

    // constructors
    public Post() {

    }

    public Post(Integer postId) {
        this.postId = postId;
    }
    
    public Post(User user, boolean postType, Integer spamCount, Status status) {
        this.user = user;
        this.postType = postType;
        this.status = status;
        this.spamCount = spamCount;
    }

    // Other methods

    public Integer getTopicIdByPostId(Integer postId) {
        String query = "select topic_id from questions where post_id = ?";
        Connection conn = DBConnect.getConnection();
        try { 
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("topic_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; 
    }

     // Get the userId for a given postId
    public Integer getUserIdByPostId(Integer postId){
        String query = "select user_id from posts where post_id = ?";
        Connection con = DBConnect.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
            con.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Delete post
    public void deletePost(Integer postId) {
        String query = "delete from posts where post_id = ?";
        Connection con = DBConnect.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, postId);
            ps.executeUpdate();

            con.close();
        }catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static Map<String, Object> collectPostById(Integer postId){
        Map<String, Object> post = new LinkedHashMap<>();
        Connection con = DBConnect.getConnection();

        try{
            String query = "select " +
                        "p.post_id, " +
                        "p.post_date, " + 
                        "u.name as user_name, " +
                        "u.pic_path as profile_pic, " +
                        "q.title, " +
                        "t.name as topic_name, " +
                        "pd.description, " +
                        "pd.pic_path " +
                        "from posts p " +
                        "join users u on p.user_id = u.user_id " +
                        "join questions q on p.post_id = q.post_id " +
                        "join topics t on q.topic_id = t.topic_id " +
                        "left join post_data pd on p.post_id = pd.post_id " +
                        "where p.post_id = ?";
                   
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, postId);
            
            ResultSet rs = ps.executeQuery();

            ArrayList<Map<String, String>> postData = new ArrayList<>();

            while(rs.next()){
                if(post.isEmpty()) {
                    post.put("postId", rs.getInt("post_id"));
                    post.put("postDate", rs.getTimestamp("post_date"));
                    post.put("userName", rs.getString("user_name"));
                    post.put("profilePic", rs.getString("profile_pic"));
                    post.put("title", rs.getString("title"));
                    post.put("topicName", rs.getString("topic_name"));
                    post.put("postData", postData);
                }

                String description = rs.getString("description");
                String picPath = rs.getString("pic_path");
                if(description != null || picPath != null) {
                    Map<String, String> postDataMap = new LinkedHashMap<>();
                    postDataMap.put("description", description);
                    postDataMap.put("picPath", picPath);

                    postData.add(postDataMap);
                }
            }
            con.close();

        }catch(SQLException e) {
            e.printStackTrace();
        }

        return post;
    }

    public static ArrayList<Map<String, Object>> collectAllPosts() {
        ArrayList<Map<String, Object>> postsList = new ArrayList<>();
        Connection con = DBConnect.getConnection();
    
        String query = "select " +
                "p.post_id, " +
                "p.post_date, " +
                "p.user_id, " +  
                "u.name as user_name, " +
                "u.pic_path, " +
                "q.title, " +
                "t.name as topic_name, " +
                "pd.description " +
                "from posts p " +
                "join users u on p.user_id = u.user_id " +
                "join questions q on p.post_id = q.post_id " +
                "join topics t on q.topic_id = t.topic_id " +
                "left join post_data pd on p.post_id = pd.post_id " +
                "order by p.post_date desc";
    
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
    
            Map<Integer, Map<String, Object>> postMap = new LinkedHashMap<>();
    
            while (rs.next()) {
                int postId = rs.getInt("post_id");
    
                Map<String, Object> postData = postMap.get(postId);
                if (postData == null) {
                    postData = new HashMap<>();
                    postData.put("postId", postId);
                    postData.put("postDate", rs.getTimestamp("post_date"));
                    postData.put("userId", rs.getInt("user_id")); 
                    postData.put("userName", rs.getString("user_name"));
                    postData.put("profilePic", rs.getString("pic_path"));
                    postData.put("title", rs.getString("title"));
                    postData.put("topicName", rs.getString("topic_name"));
    
                    // Initialize post data list
                    ArrayList<Map<String, String>> postDataList = new ArrayList<>();
                    postData.put("postDataList", postDataList);
    
                    postMap.put(postId, postData);
                }
    
                // Retrieving post data list
                @SuppressWarnings("unchecked")
                ArrayList<Map<String, String>> postDataList = (ArrayList<Map<String, String>>) postData.get("postDataList");
    
                String description = rs.getString("description");
                if (description != null) {
                    Map<String, String> pdMap = new HashMap<>();
                    pdMap.put("description", description);
                    postDataList.add(pdMap);
                }
            }
    
            postsList.addAll(postMap.values());
    
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return postsList;
    }
    
    
    // save post method
    public Integer savePost() {
        Integer generatedPostId = null;
        Connection con = DBConnect.getConnection();
        try {
            String query = "insert into posts (user_id, post_date, post_type, spam_count, status_id) values (?, NOW(), ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, user.getUserId());
            ps.setBoolean(2, postType);
            ps.setInt(3, spamCount);
            ps.setInt(4, status.getStatusId());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedPostId = rs.getInt(1);
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedPostId;
    }

    // setter and getter
    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }

    public boolean isPostType() {
        return postType;
    }

    public void setPostType(boolean postType) {
        this.postType = postType;
    }

    public Integer getSpamCount() {
        return spamCount;
    }

    public void setSpamCount(Integer spamCount) {
        this.spamCount = spamCount;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

}