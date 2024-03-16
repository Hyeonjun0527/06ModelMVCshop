package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;

public class ControllerLogAspect {
    private static final String RESET = "\u001B[0m";
    private static final String RED = "\u001B[91m";
    private static final String ORANGE = "\u001B[38;5;208m";
    private static final String YELLOW = "\u001B[93m";
    private static final String GREEN = "\u001B[92m";
    private static final String BLUE = "\u001B[94m";
    ///Constructor
    public ControllerLogAspect() {
        System.out.println("\n ������ :: Common :: "+this.getClass()+"\n");
    }

    //Around  Advice
    public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
        // �޼��� �ñ״�ó�� ������
        Signature signature = joinPoint.getSignature();
        String methodName = signature.getName(); // �޼��� �̸�

        // ���� �α� ���
        System.out.print(GREEN);
        System.out.println("[[[[[[�α���� : " + methodName + " : ���۵Ǿ����ϴ�]]]]]]");

        Object obj;
        // Ÿ�� �޼��� ����
        obj = joinPoint.proceed();
        // ���� �α� ���
        System.out.println("[[[[[[�α���� : " + methodName + " : ����Ǿ����ϴ�]]]]]]");

        System.out.print(RESET);
        return obj;
    }
}
