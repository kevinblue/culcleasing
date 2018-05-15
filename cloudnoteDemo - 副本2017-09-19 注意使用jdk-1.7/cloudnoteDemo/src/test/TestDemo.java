package test;


import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class TestDemo {
	@Test
	public void testFindNomalNoteBook() {
		ApplicationContext ctx = 
			new ClassPathXmlApplicationContext(
					"ac1.xml");
		System.out.println(ctx);
	}

}
