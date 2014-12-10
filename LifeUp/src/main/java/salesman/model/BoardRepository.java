package salesman.model;

public interface BoardRepository {

    public Iterable<Board> findAll();
    
    public Board findOne(String boardName);
    
}
