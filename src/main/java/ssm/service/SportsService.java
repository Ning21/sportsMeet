package ssm.service;

import org.springframework.stereotype.Component;
import ssm.model.Sports;
import ssm.utils.Page;

import java.util.List;

@Component
public interface SportsService {
    //查询比赛项目列表
    public Page<Sports> findSportsList(int page,int rows,
                                       String spo_name,String spo_property,
                                       String spo_type,String gender);
    //新建比赛项目
    public int createSports(Sports sports);
    // 通过id查询比赛项目
    public Sports getSportsById(Integer id);
    // 更新客户
    public int updateSports(Sports sports);
    // 删除客户
    public int deleteSports(Integer id);
    //查询所有比赛项目
    public List<Sports> getAllSports();

}