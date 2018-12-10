package ssm.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import ssm.model.Sports;
import ssm.model.User;
import ssm.service.SportsService;
import ssm.service.UserService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2018/8/12.
 */
@Controller
public class UserController {
    //依赖注入
    @Autowired
    private UserService userService;
    @Autowired
    private SportsService sportsService;

    @RequestMapping(value="/denglu",method= RequestMethod.POST)
    public String login(HttpServletRequest request,Model model,HttpSession session){
        String username=request.getParameter("username");
        String password = request.getParameter("password");
        //通过账号和密码查询用户
        User user=userService.findUser(username,password);
        //如果用户不为空，将用户对象添加到session中
        if(user!=null){
            session.setAttribute("user",user);
            // 登录开始，就查出数据库中所有项目名称
            List<Sports> allSports = sportsService.getAllSports();
            System.out.println("测试集合："+allSports.size());
            System.out.println("测试集合："+allSports.get(1).getSpo_name());
            List<String> nameType=new ArrayList<String>();
            for(int i=0;i<allSports.size();i++){
                nameType.add(allSports.get(i).getSpo_name());
            }
            System.out.println("UserController:"+nameType.get(1));
            // 将nameType放在session中
            request.getSession().setAttribute("nameType",nameType);
            return "customer";
        }
        model.addAttribute("msg","账号或密码错误，请重新输入！");
        //返回登陆页面
        return "login";
    }
    @RequestMapping(value="/logout")
    public String logout(HttpSession session){
        //清除session
        session.invalidate();
        //返回登陆页面
        return "login";
    }
}
