package test;

import java.math.BigDecimal;

import com.table.util.NumberArithmeticUtils;

public class testBigDecimal {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		NumberArithmeticUtils util=new NumberArithmeticUtils();
		BigDecimal b1=new BigDecimal("12.98");
		BigDecimal b2=new BigDecimal("10");
		BigDecimal b3=new BigDecimal("10");
		BigDecimal b=util.safeAdd(b1, b2);
		BigDecimal b0=util.safeAdd(b1, b2,b);
		BigDecimal  aa=util.safeDivide(util.safeAdd(b1, b2,b), b1);
		System.out.println(b);
		System.out.println(b0);
		System.out.println(aa);

	}

}
