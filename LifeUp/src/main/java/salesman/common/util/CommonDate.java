package salesman.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

public class CommonDate {

	 /*
	  * Comment  : 1. 입력받은 값 만큼의 날자를 더하기, 빼기 연산을 처리한다.
	  *            2. plus : 입력받은 수 만큼 더한 날자를 반환.
	  *            3. minus : 입력받은 수 만큼 뺀 날자를 반환.
	  * @version : 1.0
	  * @tags    : @param value
	  * @tags    : @return
	  * @date    : 2009. 8. 17.
	  */
	
	 public static String setOperationDate(String mode, int value){
	  SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd"); 
	  GregorianCalendar cal = new GregorianCalendar();

	  if(mode.equals("plus")){
	   cal.add(cal.DATE,value); //현재날짜에 value 값을 더한다. 
	  }else if(mode.equals("minus")){
	   cal.add(cal.DATE,-value); //현재날짜에 value 값을 뺀다. 
	  }

	  Date date = cal.getTime(); //연산된 날자를 생성. 
	  String setDate = fmt.format(date);

	  return setDate;
	 }
	}