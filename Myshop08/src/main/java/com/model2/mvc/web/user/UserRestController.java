package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserRestController(){
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

//	@RequestMapping(value="json/addUser/{userId}",method=RequestMethod.POST)
//	public Map addUser() throws Exception{
//
//		System.out.println("/user/json/addUser : GET");
//
//		return null;
//	}

	@RequestMapping(value="json/addUser",method = RequestMethod.POST)
	public Map<String,Object> addUser(@RequestBody User user) throws Exception{

		System.out.println("/user/json/addUser : POST");

		userService.addUser(user);

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("message","ok");
		map.put("user",user);
		return map;
	}


	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public Map<String,Object> getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		User user =userService.getUser(userId);

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user",user);
		map.put("message","ok");
		return map;
	}

	@RequestMapping(value = "json/updateUser",method = RequestMethod.GET)
	public Map<String,Object> updateUser(@RequestParam String userId) throws Exception{

		System.out.println("/user/json/updateUser : GET");

		User userToSend = userService.getUser(userId);

		Map<String,Object> map = new HashMap<String,Object>();

		map.put("user",userToSend);
		map.put("message","ok");
		return map;
	}

	@RequestMapping(value = "json/updateUser",method = RequestMethod.POST)
	public Map<String,Object> updateUser(@RequestBody User user,
										 HttpSession session) throws Exception{

		System.out.println("/user/json/updateUser : POST");

		System.out.println("BL�� user :: " + user);
		userService.updateUser(user);
		System.out.println("BL�� user :: " + user);

		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}

		Map<String,Object> map = new HashMap<String,Object>();

		map.put("user",user);
		map.put("message","ok");
		return map;
	}


	//Ŭ�� �ʿ��� �����Ͱ� ���� ����. ������ ��û�� ���� �ʿ䰡 ����.
//	@RequestMapping(value = "json/login", method = RequestMethod.GET)
//	public Map<String,Object> login() throws Exception{
//
//		System.out.println("/user/json/login : GET");
//
//		return null;
//	}

	//Ŭ�� �����͸� ����
	//��Ʈ�ѷ��� �����͸� ���ε��ϰ�, ������ �������ְ�, ��� �ǳ����� �ʾ�.
	//Ŭ��� �����͸� �޾�. �� �����͸� ������, �ڱ��� UI�� �׺���̼��� �� �ϰ���.
	@RequestMapping( value="json/login", method=RequestMethod.POST, produces = "application/json; charset=UTF-8" )
	public Map<String,Object> login(	@RequestBody User user,
									HttpSession session ) throws Exception{

		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());

		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}

		System.out.println("dbUser :: "+dbUser);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user",dbUser);
		map.put("message","ok");

		return map;
	}//�𵨾�Ʈ����Ʈ�� ���ε����ְ�, �����͸� ���߿� �����. �׷��� Ŭ��� �����̶� ������ ���
	//json���� �����͸� �����������.

	@RequestMapping(value = "json/logout",method=RequestMethod.GET)
	public Map<String,Object> logout(HttpSession session) throws Exception{

		System.out.println("/user/json/logout : GET");

		session.invalidate();

		Map<String,Object> map = new HashMap<>();
		map.put("message","ok");

		return map;
	}
	@RequestMapping(value = "json/listUser")
	public Map<String,Object> listUser(@RequestBody Search search) throws Exception{

		System.out.println("/user/json/listUser : GET / POST");

		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String,Object> userMap = userService.getUserList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer)userMap.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		Map<String,Object> map = new HashMap<>();

		map.put("list",userMap.get("list"));//list�ȿ� user����, search , resultPage �� ����.
		map.put("resultPage",resultPage);
		map.put("search",search);
		map.put("message","ok");

		return map;

	}

}