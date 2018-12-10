package ssm.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import ssm.model.Sports;
import java.util.List;

@Component
public interface SportsDao {
    //比赛项目列表
    public List<Sports> selectSportsList(Sports sports);
    //项目数
    public int selectSportsListCount(Sports sports);
    // 创建新的比赛项目
    public int createSports(Sports sports);
    // 通过id查询比赛项目
    public Sports getSportsById(Integer id);
    // 更新比赛项目信息
    public int updateSports(Sports sports);
    // 删除比赛项目
    int deleteSports (Integer id);
    //查询所有比赛项目
    public List<Sports> getAllSports();
}