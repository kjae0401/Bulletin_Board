package Bulletin.Board.Controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Bulletin.Board.Service.CommentServiceImpl;
import Bulletin.Board.Service.PostServiceImpl;
import Bulletin.Board.Service.UserServiceImpl;
import Bulletin.Board.Util.Pagination;
import Bulletin.Board.Util.SHA256;
import Bulletin.Board.DaoValidation.UserDaoValidation;
import Bulletin.Board.DaoValidation.PostDaoValidation;

/**
 * Handles requests for the application home page.
 */
@Controller
public class maincontroller {
	@Autowired
	private UserServiceImpl userServiceImpl;
	@Autowired
	private PostServiceImpl postServiceImpl;
	@Autowired
	private CommentServiceImpl commentServiceImpl;
	private static final Logger logger = LoggerFactory.getLogger(maincontroller.class);
	
	@RequestMapping(value = "/error_page.do")
	public String error_page() {
		return "error_page";
	}
	
	@RequestMapping(value = "/login_page.do")
	public ModelAndView login_page(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("login_page");
		request.getSession().setAttribute("Prev_Url", request.getHeader("referer"));
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/login_page_action.do")
	public String login_page_action(String user_id, String user_password, HttpServletRequest request) throws Exception {
		String view = "";
		boolean result = false;
		
		HashMap<String, String> input_data = new HashMap<String, String>();
		input_data.put("user_id", user_id);
		input_data.put("user_password", SHA256.encrypt(user_password));
		result = userServiceImpl.id_pwd_check(input_data);
		
		if (result) {
			HttpSession session = request.getSession();
			session.setAttribute("user_id", user_id);
			String prev_url = (String) session.getAttribute("Prev_Url");
			
			try {
				if (prev_url.equals("")) {
					view = "bulletin_board_main_page.do";
				} else {
					view = prev_url;
					session.setAttribute("Prev_Url", "");
				}
			} catch (Exception e) {
				view = "bulletin_board_main_page.do";
			}
		}
			
		return view;
	}
	
	@RequestMapping(value = "/logout_action.do")
	public ModelAndView logout_action(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:bulletin_board_main_page.do");
		
		request.getSession().removeAttribute("user_id");
		
		return mv;
	}
	
	@RequestMapping(value = "/signup_page.do")
	public ModelAndView signup_page() throws Exception {
		ModelAndView mv = new ModelAndView("signup_page");
		
		return mv;
	}
	// id 중복 체크를 위한 메소드
	@ResponseBody
	@RequestMapping(value = "/signup_page_idcheck.do")
	public int signup_page_idcheck(String signup_input_id) throws Exception {
		String query_data = signup_input_id;
		int result = userServiceImpl.signup_page_idcheck(query_data);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/signup_page_action.do")
	public String signup_page_action(String signup_id, String signup_password, String signup_password_check, String signup_email) throws Exception {
		String result = UserDaoValidation.signup_validation(signup_id, signup_password, signup_password_check, signup_email);
		
		if (result.equals("fail")) {
			return result;
		}
		
		result = "";
		HashMap<String, String> input_data = new HashMap<String, String>();
		input_data.put("signup_id", signup_id);
		input_data.put("signup_password", SHA256.encrypt(signup_password));
		input_data.put("signup_email", signup_email);
		result = ((boolean) userServiceImpl.signup(input_data)) ? "success" : "fail";
				
		return result;
	}
	
	@RequestMapping(value = "/find_id_page.do")
	public void find_id_page() throws Exception { }
	
	@ResponseBody
	@RequestMapping(value = "/find_id_page_action.do")
	public String find_id_page_action(HttpServletRequest httpServletRequest) throws Exception {
		String query_data = httpServletRequest.getParameter("input_email");
		String result = "";
		
		result = userServiceImpl.find_id_page_action(query_data);
		return result;
	}
	
	@RequestMapping(value = "/find_pwd_page.do")
	public void find_pwd_page() throws Exception { }
	
	@ResponseBody
	@RequestMapping(value = "/find_pwd_page_action.do")
	public boolean find_pwd_page_action(HttpServletRequest httpServletRequest) throws Exception {
		HashMap<String, String> query_data = new HashMap<String, String>();
		query_data.put("input_id", httpServletRequest.getParameter("input_id"));
		query_data.put("input_email", httpServletRequest.getParameter("input_email"));
		boolean result = false;
		
		result = userServiceImpl.find_pwd_page_action(query_data);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/find_pwd_page_last_action.do")
	public boolean find_pwd_page_last_action(HttpServletRequest httpServletRequest) throws Exception {
		HashMap<String, String> query_data = new HashMap<String, String>();
		query_data.put("user_id", httpServletRequest.getParameter("user_id"));
		query_data.put("input_pwd", SHA256.encrypt(httpServletRequest.getParameter("input_pwd")));

		boolean result = userServiceImpl.change_pwd_action(query_data);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/change_pwd_page_action.do")
	public String change_pwd_page_action(HttpServletRequest httpServletRequest, String user_id, String change_current_pwd, String change_input_pwd,
			String change_input_pwd_check) throws Exception {
		String result = "";

		switch (UserDaoValidation.change_pwd_validation(change_current_pwd, change_input_pwd, change_input_pwd_check)) {
			case "change_current_pwd empty":
				result = "change_current_pwd empty";
				return result;
				
			case "change_input_pwd emtpy":
				result = "change_input_pwd emtpy";
				return result;
				
			case "change_input_pwd_check empty":
				result = "change_input_pwd_check empty";
				return result;
				
			case "change_input_pwd pattern error":
				result = "change_input_pwd pattern error";
				return result;
				
			case "change_input_pwd not equals":
				result = "change_input_pwd not equals";
				return result;
				
			case "validation success":
				result = "validation success";
				break;
		}
		
		HashMap<String, String> infomation_check_query_data = new HashMap<String, String>();
		infomation_check_query_data.put("user_id", user_id);
		infomation_check_query_data.put("user_password", SHA256.encrypt(change_current_pwd));
		boolean information_flag = userServiceImpl.id_pwd_check(infomation_check_query_data);

		if (!information_flag) {
			result = "pwd_fail";
		} else {
			HashMap<String, String> pwd_change_query_data = new HashMap<String, String>();
			pwd_change_query_data.put("user_id", user_id);
			pwd_change_query_data.put("input_pwd", SHA256.encrypt(change_input_pwd));
			boolean information_change_flag = userServiceImpl.change_pwd_action(pwd_change_query_data);
		
			if (information_change_flag) {
				result = "success";
				httpServletRequest.getSession().removeAttribute("user_id");
			} else {
				result = "fail";
			}
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/change_email_page_action.do")
	public String change_email_page_action(HttpServletRequest httpServletRequest) throws Exception {
		String result = "";
		HashMap<String, String> email_change_query_data = new HashMap<String, String>();
		email_change_query_data.put("user_id", httpServletRequest.getParameter("user_id"));
		email_change_query_data.put("change_input_email", httpServletRequest.getParameter("change_input_email"));
		boolean flag = userServiceImpl.change_email_page_action(email_change_query_data);
		
		if (flag) {
			result = "success";
		} else {
			result = "fail";
		}
		
		return result;
	}
	
	@RequestMapping(value = "/bulletin_board_main_page.do", method=RequestMethod.GET)
	public ModelAndView bulletin_board_main_page(@RequestParam(required=false, value="nowPage") String nowPage, @RequestParam(required=false, value="countPerPage") String countPerPage,
			HttpServletRequest post_keyword, @RequestParam(value="post_write_message", required=false, defaultValue="") String post_write_message,
			@RequestParam(value="post_detail_fail_message", required=false, defaultValue="") String post_detail_fail_message,
			@RequestParam(value="post_delete_message", required=false, defaultValue="") String post_delete_message,
			@RequestParam(value="post_update_message", required=false, defaultValue="") String post_update_message) throws Exception {
		ModelAndView mv = new ModelAndView("bulletin_board_main_page");
		String keyword = post_keyword.getParameter("post_keyword");
		HashMap<String, Object> post_list_range = new HashMap<String, Object>();
		
		// 전체 게시글 수를 dao로 부터 받아온다.
		int post_count;
		
		if (keyword != null) {
			post_list_range.put("post_keyword", "%"+keyword+"%");
			mv.addObject("post_keyword", keyword);
			post_count = postServiceImpl.post_count("%"+keyword+"%");
		} else {
			post_count = postServiceImpl.post_count();
		}
		// countPerPage 개수 변경으로 한 페이지에 표시되는 게시글의 수를 조절할 수 있도록 만들 수 있다.
		if (nowPage == null && countPerPage == null) {
			nowPage = "1";
			countPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (countPerPage == null) {
			countPerPage = "10";
		}
		
		post_list_range.put("startIndex", (Integer.parseInt(nowPage)-1) * Integer.parseInt(countPerPage));
		post_list_range.put("countPerPage", Integer.parseInt(countPerPage));
		
		List<HashMap<String, String>> post_list_contents = postServiceImpl.post_list(post_list_range);
		
		Pagination pagination = new Bulletin.Board.Util.Pagination(post_count, Integer.parseInt(nowPage), Integer.parseInt(countPerPage));
		mv.addObject("pagination", pagination);
		mv.addObject("post_list_contents", post_list_contents);
		
		if (!post_write_message.equals(""))
			mv.addObject("post_write_message", post_write_message);
		
		if (!post_detail_fail_message.equals(""))
			mv.addObject("post_detail_fail_message", post_detail_fail_message);
		
		if (!post_delete_message.equals(""))
			mv.addObject("post_delete_message", post_delete_message);
		
		if (!post_update_message.equals(""))
			mv.addObject("post_update_message", post_update_message);
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_detail_page.do", method=RequestMethod.GET)
	public ModelAndView bulletin_board_detail_page(HttpServletRequest data, RedirectAttributes redirectAttributes,
			@RequestParam(value="comment_write_fail", required=false, defaultValue="") String comment_write_message,
			@RequestParam(value="comment_delete_fail", required=false, defaultValue="") String comment_delete_message) throws Exception {
		ModelAndView mv;
		
		String post_writter_id = data.getParameter("post_writter_id");
		String user_id = (String) data.getSession().getAttribute("user_id");
		int post_index = Integer.parseInt(data.getParameter("post_index"));
		
		if (user_id != null) {
			if (!post_writter_id.equals(user_id)) {
				postServiceImpl.post_detail_view_update(post_index);
			}
		} else {
			postServiceImpl.post_detail_view_update(post_index);
		}
		
		HashMap<String, String> post_detail = postServiceImpl.post_detail(post_index);
		
		if (post_detail == null) {
			mv = new ModelAndView("redirect:bulletin_board_main_page.do");
			redirectAttributes.addFlashAttribute("post_detail_fail_message", "post_detail_fail");
		} else {
			mv = new ModelAndView("bulletin_board_detail_page");
			mv.addObject("post_detail", post_detail);
			
			if (post_writter_id.equals(user_id))
				mv.addObject("Writer", true);
			else
				mv.addObject("Writer", false);
			
			List<HashMap<String, String>> post_detail_comment = commentServiceImpl.post_detail_comment(post_index);
			
			if (post_detail_comment != null)
				mv.addObject("post_detail_comment", post_detail_comment);
		}
		
		
		// 댓글 작성 실패 메시지 전송
		if (comment_write_message.equals("comment_write_fail")) {
			mv.addObject("comment_write_fail", "comment_write_fail");
		}
		// 댓글 삭제 실패 메시지 전송
		if (comment_delete_message.equals("comment_delete_fail")) {
			mv.addObject("comment_delete_fail", "comment_delete_fail");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_detail_page_comment_action.do")
	public ModelAndView bulletin_board_detail_page_comment_action(String post_comment, String current_index, HttpServletRequest data, RedirectAttributes redirectAttributes) throws Exception {
		// 인터셉터 추가로 session id 체크					// 이전 url의 파라미터를 포함한 전체 url을 받아온다.
		ModelAndView mv = new ModelAndView("redirect:"+ data.getHeader("referer"));
		
		String user_id = (String) data.getSession().getAttribute("user_id");
		String post_index = current_index;

		if (post_index == null) {
			redirectAttributes.addFlashAttribute("comment_write_fail", "comment_write_fail");
		} else {
			HashMap<String, String> comment_write_data = new HashMap<String, String>();
			comment_write_data.put("comment_writter_id", user_id);
			comment_write_data.put("comment_contents", post_comment);
			comment_write_data.put("comment_post_index", post_index);
			boolean result = commentServiceImpl.comment_write(comment_write_data);
			
			if (!result) {
				redirectAttributes.addFlashAttribute("comment_write_fail", "comment_write_fail");
			}
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_detail_page_comment_delete_action.do")
	public ModelAndView bulletin_board_detail_page_comment_delete_action(String comment_index, String current_parameter, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:bulletin_board_detail_page.do?" + current_parameter);
		
		boolean result = commentServiceImpl.comment_delete(comment_index);
		
		if (!result)
			redirectAttributes.addFlashAttribute("comment_delete_fail", "comment_delete_fail");
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_write_page.do")
	public ModelAndView bulletin_board_write_page() throws Exception {
		ModelAndView mv = new ModelAndView("bulletin_board_write_page");
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_write_page_action.do")
	public ModelAndView bulletin_board_write_page_action(String post_title, String post_contents, HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:bulletin_board_main_page.do");
		boolean validation_flag = PostDaoValidation.post_write_validation((String) request.getSession().getAttribute("user_id"), post_title, post_contents);
		
		if (!validation_flag) {
			redirectAttributes.addFlashAttribute("post_write_message", "post_write_fail");
		} else {
			HashMap<String, String> post_write_data = new HashMap<String, String>();
			post_write_data.put("post_writter_id", (String) request.getSession().getAttribute("user_id"));
			post_write_data.put("post_title", post_title);
			post_write_data.put("post_contents", post_contents);
			
			boolean flag = postServiceImpl.post_write(post_write_data);
			
			if (flag)
				redirectAttributes.addFlashAttribute("post_write_message", "post_write_success");
			else
				redirectAttributes.addFlashAttribute("post_write_message", "post_write_fail");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_delete_action.do", method=RequestMethod.GET)
	public ModelAndView bulletin_board_delete_action(HttpServletRequest post_index_data, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:bulletin_board_main_page.do");
		int post_index = Integer.valueOf(post_index_data.getParameter("post_index"));
		
		if (postServiceImpl.post_delete(post_index)) {
			redirectAttributes.addFlashAttribute("post_delete_message", "post_delete_success");
		} else {
			redirectAttributes.addFlashAttribute("post_delete_message", "post_delete_fail");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_update_page.do")
	public ModelAndView bulletin_board_update_page(int post_index, String post_title, String post_contents) throws Exception {
		ModelAndView mv = new ModelAndView("bulletin_board_update_page");
		
		mv.addObject("post_index", post_index);
		mv.addObject("post_title", post_title);
		mv.addObject("post_contents", post_contents);
		
		return mv;
	}
	
	@RequestMapping(value = "bulletin_board_update_page_action.do")
	public ModelAndView bulletin_board_update_page_action(String post_index, String post_contents, HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mv;
		boolean validation_flag = PostDaoValidation.post_update_validation(post_index, post_contents);
		
		if (!validation_flag) {
			mv = new ModelAndView("redirect:bulletin_board_main_page.do");
			redirectAttributes.addFlashAttribute("post_update_message", "post_update_fail");
		} else {
			HashMap<String, String> update_data = new HashMap<String, String>();
			update_data.put("post_index", post_index);
			update_data.put("post_contents", post_contents);
			boolean result = postServiceImpl.post_contents_update(update_data);
			
			if (result) {
				String url = "redirect:bulletin_board_detail_page.do?post_index=" + post_index + "&post_writter_id=" + (String) request.getSession().getAttribute("user_id");
				mv = new ModelAndView(url);
				
			} else {
				mv = new ModelAndView("redirect:bulletin_board_main_page.do");
				redirectAttributes.addFlashAttribute("post_update_message", "post_update_fail");
			}
		}
		
		return mv;
	}
}