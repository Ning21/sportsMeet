package ssm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.dao.SportsDao;
import ssm.model.Sports;
import ssm.service.SportsService;
import ssm.utils.Page;
import org.apache.commons.lang3.StringUtils;
import java.util.List;
@Service("sportsService")
@Transactional
public class SportsServiceImpl implements SportsService{
    //注入UserDao
    @Autowired
    private SportsDao sportsDao;

    @Override
    public Page<Sports> findSportsList(int page, int rows, String spo_name, String spo_property, String spo_type, String gender) {
        // 创建比赛项目对象
        Sports sports = new Sports();
        // 判断项目名称,StringUtils.isNotBlank("") = false
        if(StringUtils.isNotBlank(spo_name)){
            sports.setSpo_name(spo_name);
        }
        // 判断项目性质
        if(StringUtils.isNotBlank(spo_property)){
            sports.setSpo_property(spo_property);
        }
        // 判断项目类型
        if(StringUtils.isNotBlank(spo_type)){
            sports.setSpo_type(spo_type);
        }
        // 判断项目性别
        if(StringUtils.isNotBlank(gender)){
            sports.setGender(gender);
        }
        System.out.println("接口方法中的测试："+sports.getSpo_property());
        // 当前页
        sports.setStart((page-1) * rows) ;
        // 每页数
        sports.setRows(rows);
        // 查询比赛项目列表
        List<Sports> sportsList =
                sportsDao.selectSportsList(sports);
        // 查询项目列表总记录数
        Integer count = sportsDao.selectSportsListCount(sports);
        // 创建Page返回对象
        Page<Sports> result = new Page<>();
        result.setPage(page);
        result.setRows(sportsList);
        result.setSize(rows);
        result.setTotal(count);
        return result;
    }
    /**
     * 创建新的比赛项目
     */
    @Override
    public int createSports(Sports sports) {
        return sportsDao.createSports(sports);
    }
    /**
     * 通过id查询比赛项目
     */
    @Override
    public Sports getSportsById(Integer id) {
        Sports sports = sportsDao.getSportsById(id);
        return sports;
    }
    /**
     * 更新某一比赛项目信息
     */
    @Override
    public int updateSports(Sports sports) {
        return sportsDao.updateSports(sports);
    }
    /**
     * 删除某一比赛项目
     */
    @Override
    public int deleteSports(Integer id) {
        return sportsDao.deleteSports(id);
    }

    @Override
    public List<Sports> getAllSports() {
        return sportsDao.getAllSports();
    }

}