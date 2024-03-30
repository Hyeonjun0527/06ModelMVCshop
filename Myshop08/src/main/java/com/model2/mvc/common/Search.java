package com.model2.mvc.common;


import java.util.Arrays;

//==>����Ʈȭ���� �𵨸�(�߻�ȭ/ĸ��ȭ)�� Bean
public class Search {

    ///Field
    private int currentPage;
    private String searchCondition;//��ǰ��ȣ,��ǰ��,��ǰ����
    private String searchKeyword;//�˻���
    private String searchType;//���ݳ�����
    private int searchBoundFirst;
    private int searchBoundEnd;
    private int pageSize;
    //==> ����Ʈȭ�� currentPage�� �ش��ϴ� ȸ�������� ROWNUM ��� SELECT ���� �߰��� Field
    //==> UserMapper.xml ��
    //==> <select  id="getUserList"  parameterType="search"	resultMap="userSelectMap">
    //==> ����
    private int endRowNum;
    private int startRowNum;

    ///Constructor
    public Search() {
    }

    ///Method
    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int paseSize) {
        this.pageSize = paseSize;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }
    public int getSearchBoundFirst() {
        return searchBoundFirst;
    }

    public void setSearchBoundFirst(int searchBoundFirst) {
        this.searchBoundFirst = searchBoundFirst;
    }

    public int getSearchBoundEnd() {
        return searchBoundEnd;
    }

    public void setSearchBoundEnd(int searchBoundEnd) {
        this.searchBoundEnd = searchBoundEnd;
    }

    //==> Select Query �� ROWNUM ������ �� 3*5 = 15��
    public int getEndRowNum() {
        return getCurrentPage() * getPageSize();
    }

    //==> Select Query �� ROWNUM ���� �� 2 *5 + 1 = 11�� Ŀ���� 1 pageSize �ִ밪�ϸ�
    public int getStartRowNum() {
        return (getCurrentPage() - 1) * getPageSize() + 1;
    }

    @Override
    public String toString() {
        return "Search [currentPage=" + currentPage + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", searchType=" + searchType + ", pageSize=" + pageSize + ", endRowNum=" + endRowNum
				+ ", startRowNum=" + startRowNum + "]";
    }

}