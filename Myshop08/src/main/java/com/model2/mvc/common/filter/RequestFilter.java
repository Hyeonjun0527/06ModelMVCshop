package com.model2.mvc.common.filter;

import com.model2.mvc.service.domain.User;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;


/*
 * javax.servlet.Fiter  �� ������  Filter
 * 
 * Servlet Meta-data �� web.xml �� �Ʒ��� ���� ���
    <filter>
		<filter-name>requestFilter</filter-name>
		<filter-class>com.model2.mvc.common.filter.RequestFilter</filter-class>
	</filter>
	
	<filter-mapping>
		<filter-name>requestFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
*   
*   ��� URI �� ��� request �� ���͸� ����ϰ��Ͽ� �ѱ�ó�� 
 */
public class RequestFilter implements Filter{

	public void init(FilterConfig arg0) throws ServletException {
	}
	
	public void doFilter(	ServletRequest request , 
											ServletResponse response , 
											FilterChain filterChain) 
										throws IOException, ServletException {

		User u = new User();
		////////////////////////////////////////////////////�����////////////////////////////////////////
		u.setAddr("����� ������ ���ﵿ");
		u.setUserId("user12");//user12,admin
		u.setUserName("scott");//scott, admin
		u.setRole("user");//user, admin
		u.setEmail("immio0@naver.com");
		u.setPassword("1234");
		u.setPhone("010-1234-5678");
		u.setSsn("900101");
		((HttpServletRequest) request).getSession().setAttribute("user",u);

		filterChain.doFilter(request, response);
	}

	public void destroy() {
	}

}