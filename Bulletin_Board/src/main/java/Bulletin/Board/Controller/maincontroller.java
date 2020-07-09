package Bulletin.Board.Controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Bulletin.Board.Service.PostServiceImpl;
import Bulletin.Board.Service.UserServiceImpl;
import Bulletin.Board.Util.Pagination;
import Bulletin.Board.Util.SHA256;

/**
 * Handles requests for the application home page.
 */
@Controller
public class maincontroller {
	@Autowired
	private UserServiceImpl userServiceImpl;
	@Autowired
	private PostServiceImpl postServiceImpl;
	private static final Logger logger = LoggerFactory.getLogger(maincontroller.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/homepage.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/login_page.do") // redirect할 때 값을 주고받기위해 사용 RequestParam 및의 형식대로 해야 값이 없을 때 오류가 나지않음.
	public ModelAndView login_page(HttpServletRequest request, @RequestParam(value="login_fail_message", required=false, defaultValue="") String login_fail_message,
			@RequestParam(value="signup_result_message", required=false, defaultValue="") String signup_result_message) throws Exception {
		ModelAndView mv = new ModelAndView("login_page");
		
		if (!login_fail_message.equals(""))
			mv.addObject("login_fail_message", login_fail_message);
		if (!signup_result_message.equals(""))
			mv.addObject("signup_result_message", signup_result_message);
		
		return mv;
	}
	
	@RequestMapping(value = "/login_page_action.do")							// redirect 시 값 전달을 위해 사용
	public ModelAndView login_page_action(String user_id, String user_password, RedirectAttributes redirectAttributes, HttpServletRequest request) throws Exception {
		ModelAndView mv;
		
		HashMap<String, String> input_data = new HashMap<String, String>();
		input_data.put("user_id", user_id);
		input_data.put("user_password", SHA256.encrypt(user_password));
		boolean result = (boolean) userServiceImpl.login(input_data);
		
		if (result) {
			request.getSession().setAttribute("user_id", user_id);
			mv = new ModelAndView("redirect:homepage.do");
		} else {
			redirectAttributes.addFlashAttribute("login_fail_message", "login_fail");
			mv = new ModelAndView("redirect:login_page.do");
		}
			
		return mv;
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
	public int signup_page_idcheck(HttpServletRequest httpServletRequest) throws Exception {
		String query_data = httpServletRequest.getParameter("signup_input_id");
		int result = userServiceImpl.signup_page_idcheck(query_data);
		return result;
	}
	
	
	@RequestMapping(value = "/signup_page_action.do")
	public ModelAndView signup_page_action(String signup_id, String signup_password, String signup_email, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mv;
		
		HashMap<String, String> input_data = new HashMap<String, String>();
		input_data.put("signup_id", signup_id);
		input_data.put("signup_password", SHA256.encrypt(signup_password));
		input_data.put("signup_email", signup_email);
		boolean result = (boolean) userServiceImpl.signup(input_data);
		
		if (result) {
			redirectAttributes.addFlashAttribute("signup_result_message", "signup_success");
		} else {
			redirectAttributes.addFlashAttribute("signup_result_message", "signup_fail");
		}
		mv = new ModelAndView("redirect:login_page.do");
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_main_page.do", method=RequestMethod.GET)
	public ModelAndView bulletin_board_main_page(@RequestParam(required=false, value="nowPage") String nowPage, @RequestParam(required=false, value="countPerPage") String countPerPage,
			HttpServletRequest post_keyword, @RequestParam(value="post_write_message", required=false, defaultValue="") String post_write_message,
			@RequestParam(value="post_detail_fail_message", required=false, defaultValue="") String post_detail_fail_message,
			@RequestParam(value="post_delete_message", required=false, defaultValue="") String post_delete_message) throws Exception {
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
		
		return mv;
	}
	
	@RequestMapping(value = "/bulletin_board_detail_page.do", method=RequestMethod.GET)
	public ModelAndView bulletin_board_detail_page(HttpServletRequest data, RedirectAttributes redirectAttributes) throws Exception {
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
		}
		
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
		
		HashMap<String, String> post_write_data = new HashMap<String, String>();
		post_write_data.put("post_writter_id", (String) request.getSession().getAttribute("user_id"));
		post_write_data.put("post_title", post_title);
		post_write_data.put("post_contents", post_contents);
		
		boolean flag = postServiceImpl.post_write(post_write_data);
		
		if (flag)
			redirectAttributes.addFlashAttribute("post_write_message", "post_write_success");
		else
			redirectAttributes.addFlashAttribute("post_write_message", "post_write_fail");
		
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
}