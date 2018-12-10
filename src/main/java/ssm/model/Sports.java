package ssm.model;

import java.io.Serializable;
import java.util.Date;

public class Sports implements Serializable{
    private static final long serialVersionUID = 1L;
    private int spo_id;//项目编号
    private String spo_name;//项目名称
    private String spo_property;//项目性质（计时，高度，远度，接力，数量）
    private String gender;//项目性别
    private String spo_type;//项目类别（田赛、径赛、接力赛）
    private String scoreUnit;//成绩格式（/分/秒、/米、/个）
    private String sort;//成绩排序方式(升序、降序)
    private String place;//比赛地点
    private Date startTime;//比赛开始时间
    private Date endTime;//比赛结束时间
    private int takenum;//比赛次数
    private int start;//起始行
    private int rows;//所取行数

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public int getStart() {

        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getSpo_id() {
        return spo_id;
    }

    public void setSpo_id(int spo_id) {
        this.spo_id = spo_id;
    }

    public String getSpo_name() {
        return spo_name;
    }

    public void setSpo_name(String spo_name) {
        this.spo_name = spo_name;
    }

    public String getSpo_property() {
        return spo_property;
    }

    public void setSpo_property(String spo_property) {
        this.spo_property = spo_property;
    }

    public String getSpo_type() {
        return spo_type;
    }

    public void setSpo_type(String spo_type) {
        this.spo_type = spo_type;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getScoreUnit() {
        return scoreUnit;
    }

    public void setScoreUnit(String scoreUnit) {
        this.scoreUnit = scoreUnit;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getTakenum() {
        return takenum;
    }

    public void setTakenum(int takenum) {
        this.takenum = takenum;
    }
}