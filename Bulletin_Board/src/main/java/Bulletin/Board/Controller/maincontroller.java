package Bulletin.Board.Controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
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

import Bulletin.Board.Service.UserServiceImpl;
import Bulletin.Board.Util.SHA256;

/**
 * Handles requests for the application home page.
 */
@Controller
public class maincontroller {
	@Autowired
	private UserServiceImpl userServiceImpl;
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
}
