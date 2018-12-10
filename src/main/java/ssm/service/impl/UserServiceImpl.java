package ssm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ssm.dao.UserDao;
import ssm.model.User;
import ssm.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{
    //注入UserDao
    @Autowired
    private UserDao userDao;
    //通过账号和密码查询用户
    @Override
    public User findUser(String username, String password) {
      User user=this.userDao.findUser(username,password);
      return user;
    }
}