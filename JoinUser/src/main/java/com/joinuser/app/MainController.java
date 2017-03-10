package com.joinuser.app;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.joinuser.app.CaptchaVerify;
import com.joinuser.app.User;

import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;


@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
    private SqlSession sqlSession;
	
	@Autowired
	private JavaMailSender mailSender;
	
	  @RequestMapping(value = "/email_auth", method = RequestMethod.POST)
	  @ResponseBody
	  public String mailSending(@RequestParam("receiver") String receiver) {
		int ran = new Random().nextInt(100000) + 10000;
		
	    String subject   = "회원가입 이메일인증";
	    String content = "인증코드="+ran;
	    logger.info("receiver="+receiver);
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setTo(receiver);
	      messageHelper.setSubject(subject);
	      messageHelper.setText(content);
	     
	      mailSender.send(message);
	      logger.info("message="+message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	    return ""+ran;
	  }
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "main";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@ModelAttribute User user, BindingResult result, Model model, HttpSession session, HttpServletRequest request) {
		
		MultipartFile image_file = user.getImage();
		String image_file_name = image_file.getOriginalFilename();
		String image = "C:\\Develop\\workspaces\\JoinUser\\src\\main\\webapp\\images\\"+image_file_name;
		String id = user.getId().trim();
		String name = user.getName().trim();
		String road_name_address = user.getRoad_name_address().trim();
		String detail_address = user.getDetail_address().trim();
		String lot_number = user.getLot_number().trim();
		String post_code = user.getPost_code().trim();
		String phone = user.getPhone().trim();
		String email = user.getEmail().trim();
		String password1 = user.getPassword1().trim();
		String password2 = user.getPassword2().trim();
		String joinpath = user.getJoinpath();
		String interests = user.getInterests();
		String captcha_response = user.getCaptcha_response();
		
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "id", "ID Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "name", "Name Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "road_name_address", "road_name_address Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "detail_address", "detail_address Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "lot_number", "lot_number Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "post_code", "post_code Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "phone", "phone Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "email", "email Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "password1", "password1 Can't be empty!!");
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "password2", "password2 Can't be empty!!");

		JSONObject result_json = null;
		CaptchaVerify capchaVerify = new CaptchaVerify();
		String verify_result = capchaVerify.captcha_verify("https://www.google.com/recaptcha/api/siteverify?secret=6Lf2ghcUAAAAAFzVGmFDBbGxCzWRN7r0NNTsx6aQ&response="+captcha_response);
		logger.info("verify_result="+verify_result);
		result_json = new JSONObject(verify_result);
		logger.info("result_map="+result_json.get("success"));
		String is_success = result_json.get("success").toString();
		
		if(is_success=="true" && !result.hasErrors()) {
			File f = new File(image);
		    try {
		    	image_file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			HashMap<String, String> input = new HashMap<String, String>();
			input.put("id", id);
			input.put("passwd", password1);
	        input.put("name", name);
	        input.put("road_name_address", road_name_address);
	        input.put("detail_address", detail_address);
	        input.put("lot_number", lot_number);
	        input.put("post_code", post_code);
	        input.put("phone", phone);
	        input.put("email", email);
	        input.put("joinpath", joinpath);
	        input.put("interests", interests);
	        input.put("image", image_file_name);
	        
	        int insert_result = sqlSession.insert("userControlMapper.insert_user", input);
			if(insert_result==1) return "login";
			else return "redirect:/join_fail";
		} else return "redirect:/join_fail";
	}
	
	@RequestMapping(value = "/join_fail")
	public void join_fail() {
		
		logger.info("join_fail");
	}
	
	@RequestMapping(value = "/address_popup")
	public String address_popup() {
		
		return "address_popup";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam("id") String id, @RequestParam("password") String password, Model model) {
		model.addAttribute("id", id);
		
		HashMap<String, String> input = new HashMap<String, String>();
		input.put("id", id);
		input.put("passwd", password);
	        
		HashMap<String, Long> login_result = sqlSession.selectOne("userControlMapper.check_login", input);
			
	    if(login_result.get("COUNT(*)")==1) return "welcome";
	    else return "login_fail";
	}
	
	@RequestMapping(value = "/login_form")
	public String login_form() {
		return "login";
	}
	
	@RequestMapping(value = "/check_id", method = RequestMethod.POST)
	@ResponseBody
	public String login(@RequestParam("id") String id) {
		
		HashMap<String, String> input = new HashMap<String, String>();
		input.put("id", id);
	        
		HashMap<String, Long> id_result = sqlSession.selectOne("userControlMapper.check_userid", input);
			
	    return ""+id_result.get("COUNT(*)");
	}

	@RequestMapping(value = "/error404", method = RequestMethod.GET)
    public String error404(HttpServletResponse res, Model model) {
		
		res.setStatus(HttpServletResponse.SC_OK);
		logger.warn("404 error occurred!!");
        
        return "login";
    }
	
}
