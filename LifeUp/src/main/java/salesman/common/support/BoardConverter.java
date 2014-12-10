package salesman.common.support;

import javax.inject.Inject;

import org.springframework.core.convert.converter.Converter;

import salesman.model.Board;
import salesman.model.BoardRepository;

public class BoardConverter implements Converter<String, Board> {
    
    @Inject BoardRepository boardRepository;

    @Override
    public Board convert(String source) {
        return boardRepository.findOne(source);
    }
}
