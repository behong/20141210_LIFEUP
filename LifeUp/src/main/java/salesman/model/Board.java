package salesman.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.BeanUtils;

import com.google.common.base.Predicate;
import com.google.common.base.Predicates;
import com.google.common.collect.Iterables;

public class Board extends SqlSessionDaoSupport {

    String name;
    String description;
    Set<Post> posts = new TreeSet<Post>();
    
    public Board(String name, String description) {
        this.name = name;
        this.description = description;
    }
    
    
    public String getName() { return name; }

    public String getDescription() { return description; }

  //public Set<Post> getPosts() { return Collections.unmodifiableSet(posts); }
    public  List<HashMap<String, Object>>  getPosts(){
    	Object rowMap = null;
		 System.out.println("--------------------" + rowMap);
		 List<HashMap<String, Object>> testTableList = new ArrayList<HashMap<String, Object>>();
		 testTableList = getSqlSession().selectList("main.getList");
		// System.out.println("--------------------" + testTableList);

    	return  testTableList ; 	
    	}

    
    public Post findPost(final Integer postNo) {
        return Iterables.find(posts, new Predicate<Post>() {
            @Override
            public boolean apply(Post source) {
            	if(source.getId() == postNo)
            		return true;
            	
            	return false;
            }
        });
    }
    
    public Post writing(Post post) {
        //if(Iterables.isEmpty(posts))
           // posts.add(post.setId(1));
       // else
           // posts.add(post.setId(Collections.max(posts).getId() + 1));
        post.setId(1);
        return post;
    }
    
    public Post editing(Post post) {
        Post origin = Iterables.find(posts, Predicates.equalTo(post), null);
        if(origin == null)
            throw new IllegalArgumentException("�섏젙��湲�no:" + post.getId() + ")���놁뒿�덈떎.");
        
        BeanUtils.copyProperties(post, origin);
        
        return origin;
    }
    
    public Board erase(Post post) {
        if(!posts.contains(post))
            throw new IllegalArgumentException("��젣��湲�no:" + post.getId() + ")���놁뒿�덈떎.");
        
        posts.remove(post);
        
        return this;
    }
    
    public Board erase(Integer postNo) {
        return erase(findPost(postNo));
    }
    
}
