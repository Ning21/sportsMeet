package ssm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import ssm.model.Sports;
import ssm.service.SportsService;
import ssm.utils.Page;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@Controller
public class SportsController {
    //依赖注入
    @Autowired
    private SportsService sportsService;
    /**
     *  客户列表
     */
    @RequestMapping(value = "/sportslist")
    public String list(@RequestParam(defaultValue="1")Integer page,
                       @RequestParam(defaultValue="6")Integer rows,
                       HttpServletRequest request,Model model) {
        String spo_name=request.getParameter("spo_name");
        String spo_property=request.getParameter("spo_property");
        String spo_type=request.getParameter("spo_type");
        String gender=request.getParameter("gender");
        System.out.println("传递的参数为："+spo_name+"----"+spo_property+"----"+gender+"----"+spo_type);
        // 条件查询所有比赛项目
        Page<Sports> sportsPage = sportsService
                .findSportsList(page, rows, spo_name,
                        spo_property, spo_type,gender);
        model.addAttribute("page", sportsPage);
        return "customer";
    }

    /**
     * 创建新的比赛项目
     */
    @RequestMapping("/createSports")
    @ResponseBody
    public String sportsCreate(HttpServletRequest request) {
        String spo_name=request.getParameter("cust_name");
        String spo_property=request.getParameter("cust_property");
        String gender=request.getParameter("cust_gender");
        String spo_type=request.getParameter("cust_type");
        String scoreUnit=request.getParameter("cust_scoreUnit");
        String sort=request.getParameter("cust_sort");
        String place=request.getParameter("cust_place");
        //时间类型转换
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
        String startTime=request.getParameter("cust_startTime");
        String endTime=request.getParameter("cust_endTime");
        Date startTimeP=new Date();
        Date endTimeP=new Date();
        try {
            startTimeP= formatter.parse(startTime);
            endTimeP=formatter.parse(endTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        int takenum=Integer.parseInt(request.getParameter("cust_takenum"));
        Sports sports =new Sports();
        sports.setSpo_name(spo_name);
        sports.setSpo_property(spo_property);
        sports.setSpo_type(spo_type);
        sports.setGender(gender);
        sports.setPlace(place);
        sports.setScoreUnit(scoreUnit);
        sports.setSort(sort);
        sports.setStartTime(startTimeP);
        sports.setEndTime(endTimeP);
        sports.getTakenum();
        // 执行Service层中的创建方法，返回的是受影响的行数
        int rows = sportsService.createSports(sports);
        if(rows > 0){
            //新添一个比赛项目，就将此项目名称添加到nameType中
            HttpSession session=request.getSession();
            List<String> nameType=(List<String>) session.getAttribute("nameType");
            nameType.add(spo_name);
            System.out.println("SportController："+nameType.get(1));
            return "OK";
        }else{
            return "FAIL";
        }
    }
    /**
     * 通过id获取比赛项目信息
     */
    @RequestMapping("/getSportsById")
    @ResponseBody
    public Sports getSportsById(Integer id) {
        Sports sports = sportsService.getSportsById(id);
        return sports;
    }
    /**
     * 更新比赛项目信息
     */
    @RequestMapping("/updateSports")
    @ResponseBody
    public String sportsUpdate(HttpServletRequest request) {
        String spo_name=request.getParameter("cust_name");
        String spo_property=request.getParameter("cust_property");
        String gender=request.getParameter("cust_gender");
        String spo_type=request.getParameter("cust_type");
        String scoreUnit=request.getParameter("cust_scoreUnit");
        String sort=request.getParameter("cust_sort");
        String place=request.getParameter("cust_place");
        //时间类型转换
        SimpleDateFormat sdf1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String startTime=request.getParameter("cust_startTime");
        System.out.println(startTime);
        String endTime=request.getParameter("cust_endTime");
        Date startTimeP=new Date();
        Date endTimeP=new Date();
        try {
            startTimeP=sdf1.parse(startTime);
            endTimeP=sdf1.parse(startTime);
            System.out.println(startTimeP);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        int takenum=Integer.parseInt(request.getParameter("cust_takenum"));
        Sports sports =new Sports();
        sports.setSpo_name(spo_name);
        sports.setSpo_property(spo_property);
        sports.setSpo_type(spo_type);
        sports.setGender(gender);
        sports.setPlace(place);
        sports.setScoreUnit(scoreUnit);
        sports.setSort(sort);
        sports.setStartTime(startTimeP);
        sports.setEndTime(endTimeP);
        sports.setTakenum(takenum);
        System.out.println("---------");
        int rows = sportsService.updateSports(sports);
        System.out.println("rows-------"+rows);
        if(rows > 0){
            return "OK";
        }else{
            return "FAIL";
        }
    }

    /**
     * 删除比赛项目
     */
    @RequestMapping("/deleteSports")
    @ResponseBody
    public String sportsDelete(Integer id) {
        int rows = sportsService.deleteSports(id);
        if(rows > 0){
            return "OK";
        }else{
            return "FAIL";
        }
    }

    @RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
    @ResponseBody
    public String fileUpload(@RequestParam("uploadfile") List<MultipartFile> uploadfile, HttpServletRequest request) {
       //判断所上传文件是否存在
        if(!uploadfile.isEmpty()&&uploadfile.size()>0){
            //循环输出上传的文件
            for(MultipartFile file:uploadfile){
                //获取上传文件的原始名称
                String originalFilename=file.getOriginalFilename();
                //设置上传文件的保存地址目录
                /*String dirPath=request.getServletContext().getRealPath("/upload/");*/
                String dirPath="E:/newFilesUpload/";
                File filePath=new File(dirPath);
                //如果保存文件的地址不存在，就先创建目录
                if(!filePath.exists()){
                    filePath.mkdirs();
                }
                //使用UUID重新命名上传的文件名称(上传人_uuid_原始文件名称)
                String newFilename= UUID.randomUUID()+"_"+originalFilename;
                try{
                    //使用MultipartFile接口的方法完成文件上传到指定位置
                    file.transferTo(new File(dirPath+newFilename));
                    System.out.println("保存地址为："+dirPath+newFilename);
                } catch (IOException e) {
                    e.printStackTrace();
                    return "index";
                }
            }
            //跳转到成功页面
            return "shoppingIndex";
       }
        return "index";
    }
}