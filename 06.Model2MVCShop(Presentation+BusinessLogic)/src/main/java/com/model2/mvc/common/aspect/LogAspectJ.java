package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

/*
 * FileName : PojoAspectJ.java
 *	:: XML �� ���������� aspect �� ����   
  */
public class LogAspectJ {
	///Field
	private static final String RESET = "\u001B[0m";
	private static final String RED = "\u001B[91m";
	private static final String ORANGE = "\u001B[38;5;208m";
	private static final String YELLOW = "\u001B[93m";
	private static final String GREEN = "\u001B[92m";
	private static final String BLUE = "\u001B[94m";
	///Constructor
	public LogAspectJ() {
		System.out.println("\n ������ :: Common :: "+this.getClass()+"\n");		
	}
	
	//Around  Advice
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			
		System.out.println(RED);
		System.out.println("[Around before] Ÿ�ٰ�ü.�޼��� :"+
													joinPoint.getTarget().getClass().getName() +"."+
													joinPoint.getSignature().getName());
		if(joinPoint.getArgs().length !=0){
			System.out.println("[Around before]method�� ���޵Ǵ� ���� : "+ joinPoint.getArgs()[0]);
		}
		//==> Ÿ�� ��ü�� Method �� ȣ�� �ϴ� �κ� 
		Object obj = joinPoint.proceed();

		System.out.println("[Around after] Ÿ�� ��üreturn value  : "+obj);
		System.out.println(RESET);
		
		return obj;
	}
	
}//end of class