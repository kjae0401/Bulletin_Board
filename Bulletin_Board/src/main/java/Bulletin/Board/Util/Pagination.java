package Bulletin.Board.Util;

public class Pagination {
	private int nowPage;		// 현재 페이지
	private int startPage;		// 시작 페이지
	private int endPage;		// 끝 페이지
	private int total_post;		// 게시글 총 개수
	private int countPerPage;	// 페이지당 글 개수
	private int lastPage;		// 마지막 페이지
	private int sql_start;		// sql쿼리에 사용할 start
	private int sql_end;		// end
	private int countPage = 3;	// pagination (prev, next를 제외한)버튼 개수
	
	public Pagination(int total_post, int nowPage, int countPerPage) {
		this.setNowPage(nowPage);
		this.setCountPerPage(countPerPage);
		this.setTotalPost(total_post);
		calcLastPage(getTotalPost(), getCountPerPage());
		calcStartEndPage(getNowPage(), countPage);
		calcStartEnd(getNowPage(), getCountPerPage());
	}
	
	// 마지막 페이지 계산
	public void calcLastPage(int total_post, int countPerPage) { setLastPage((int) Math.ceil((double) total_post / (double) countPerPage)); }
	// 시작, 끝 페이지 계산
	public void calcStartEndPage(int nowPage, int countPage) { 
		setEndPage(((int) Math.ceil((double) nowPage / (double) countPage)) * countPage);
		
		if (getLastPage() < getEndPage())
			setEndPage(getLastPage());
		
		setStartPage(getEndPage() - countPage + 1);
		
		if (getStartPage() < 1)
			setStartPage(1);
	}
	
	// SQL 쿼리에서 사용할 start, end 값 계산
	public void calcStartEnd(int nowPage, int countPerPage) {
		setSQLEnd(nowPage * countPerPage);
		setSQLStart(getSQLEnd() - countPerPage + 1);
	}
	
	public int getNowPage() { return nowPage; }
	public void setNowPage(int nowPage) { this.nowPage = nowPage; }
	
	public int getStartPage() { return startPage; }
	public void setStartPage(int startPage) { this.startPage = startPage; }
	
	public int getEndPage() { return endPage; }
	public void setEndPage(int endPage) { this.endPage = endPage; }
	
	public int getTotalPost() { return total_post; }
	public void setTotalPost(int total_post) { this.total_post = total_post; }
	
	public int getCountPerPage() { return countPerPage; }
	public void setCountPerPage(int countPerPage) { this.countPerPage = countPerPage; }
	
	public int getLastPage() { return lastPage; }
	public void setLastPage(int lastPage) { this.lastPage = lastPage; }
	
	public int getSQLStart() { return sql_start; }
	public void setSQLStart(int sql_start) { this.sql_start = sql_start; }
	
	public int getSQLEnd() { return sql_end; }
	public void setSQLEnd(int sql_end) { this.sql_end = sql_end; }
	
	public int getCountPage() { return countPage; }
	public void setCountPage(int countPage) { this.countPage = countPage; }
}