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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Bulletin.Board.Service.UserServiceImpl;

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
	public ModelAndView login_page(HttpServletRequest request, @RequestParam(value="login_fail_message", required=false, defaultValue="") String login_fail_message) throws Exception {
		ModelAndView mv = new ModelAndView("login_page");
		
		if (login_fail_message.equals("login_fail"))
			mv.addObject("login_fail_message", login_fail_message);
		
		return mv;
	}
	
	@RequestMapping(value = "/login_page_action.do")							// redirect 시 값 전달을 위해 사용
	public ModelAndView login_page_action(String user_id, String user_password, RedirectAttributes redirectAttributes, HttpServletRequest request) throws Exception {
		ModelAndView mv;
		
		HashMap<String, String> input_data = new HashMap<String, String>();
		input_data.put("user_id", user_id);
		input_data.put("user_password", user_password);
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
}
