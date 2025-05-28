package models;

public class Wishlist {
    private Integer wishlistId;
    private Post post;
    private Reply reply;
    private User user;
    
    public Integer getWishlistId() {
        return wishlistId;
    }
    public void setWishlistId(Integer wishlistId) {
        this.wishlistId = wishlistId;
    }
    public Post getPost() {
        return post;
    }
    public void setPost(Post post) {
        this.post = post;
    }
    public Reply getReply() {
        return reply;
    }
    public void setReply(Reply reply) {
        this.reply = reply;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }  
    
}
