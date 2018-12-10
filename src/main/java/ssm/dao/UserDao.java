package ssm.dao;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import ssm.model.User;

/**
 * Created by Administrator on 2018/8/12.
 */
@Component
public interface UserDao {
    //通过姓名和密码查询用户
    //在上述方法代码的参数中，@Param("username")表示为参数username命名，命名后，在映射文件的sql中，使用#{username}就可以获取username的参数值
    public User findUser(@Param("userName") String userName,
                  @Param("password") String password);
}
