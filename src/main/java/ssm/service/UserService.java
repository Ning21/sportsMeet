package ssm.service;
import org.springframework.stereotype.Component;
import ssm.model.User;

/**
 * Created by Administrator on 2018/8/12.
 */
@Component
public interface UserService {
    //通过账号和密码查询用户
    public User findUser(String username,String password);
}
