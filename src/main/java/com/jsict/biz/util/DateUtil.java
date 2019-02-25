package com.jsict.biz.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import org.apache.commons.lang3.StringUtils;

/**
 * 
 * 功能: 将输入的日期转换为中文日期（例如: 2007-10-05 --> 二○○七年十月五日) 说明：此程序假定输入格式为yyyy-mm-dd,
 * 且年月日部分都为数字, 没有加上非法
 * 
 */
public class DateUtil {
	/**
	 * 
	 * @param args
	 */

	public static void main(String[] args) {
		String issueDate = "2011-10-30 12:22:27";

		StringToDate(issueDate);
		Date d = new Date();
		DateTimeToString(d);
		Calendar calendar = DateToCalendar(d);
		CalendarToDate(calendar);
		System.out.println(formatStr(issueDate));
	}

	/**
     * 获得本周一与当前日期相差的天数  
     *
     * @author Lv
     * @date 2018/10/25
     */
    public static  int getMondayPlus() {  
        Calendar cd = Calendar.getInstance();  
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);  
        if (dayOfWeek == 1) {  
            return -6;  
        } else {  
            return 2 - dayOfWeek;  
        }  
    }  
  
    /**
     * 获得当前周- 周一的日期    
     *
     * @author Lv
     * @date 2018/10/25
     */
    public static  Date getCurrentMonday() {  
        int mondayPlus = getMondayPlus();  
        GregorianCalendar currentDate = new GregorianCalendar();  
        currentDate.add(Calendar.DATE, mondayPlus);  
        Date monday = currentDate.getTime();  
        return monday;  
    }  
    
    /**
     *获得当前周- 周日  的日期     
     *
     * @author Lv
     * @date 2018/10/25
     */
    public static Date getPreviousSunday() {  
        int mondayPlus = getMondayPlus();  
        GregorianCalendar currentDate = new GregorianCalendar();  
        currentDate.add(Calendar.DATE, mondayPlus +6);  
        Date sunday = currentDate.getTime();  
        return sunday;  
    }  
    
    /**
     * 某天的开始时间
     *
     * @author Lv
     * @date 2018/10/25
     */
    public static Date getDayBegin(Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.set(c.get(Calendar.YEAR), c.get(Calendar.MONTH), c.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
        c.set(Calendar.MILLISECOND, 0);
        return c.getTime();

    }

    /**
     * 某天的最后时间
     *
     * @author Lv
     * @date 2018/10/25
     */
    public static Date getDayEnd(Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.set(c.get(Calendar.YEAR), c.get(Calendar.MONTH), c.get(Calendar.DAY_OF_MONTH), 23, 59, 59);
        c.set(Calendar.MILLISECOND, 999);
        return c.getTime();
    }
    
    /**
     * 获得某天之前/后n天的时间,正数表示该日期后n天，负数表示该日期的前n天
     *
     * @author Lv
     * @date 2018/10/25
     */
    public static Date getDateBeforeOrAfter(Date date,int days) {
    	Calendar c = Calendar.getInstance();
        c.setTime(date);
        // add方法中的第二个参数n中，正数表示该日期后n天，负数表示该日期的前n天
        c.add(Calendar.DATE, days);
        return c.getTime();
	}
	
	
	/**
	 * 判断字符串是否为空
	 * 
	 * @param str
	 * @return boolean true：不为空；false：为空
	 */
	public static boolean isNull(String str) {
		if (null != str && !"".equals(str) && !"".equals(str.trim()) && !"null".equals(str.trim())) {
			return false;
		}
		return true;
	}

	/**
	 * 日期转换为字符串，格式为：yyyy-MM-dd HH:mm:ss
	 * 
	 * @param date
	 * @return String
	 * @throws Exception
	 */
	public static String FullDateToString(Date date) {
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdf.format(date);
		}
		return "";
	}

	/**
	 * 日期转换为字符串，格式为：yyyy-MM-dd
	 * 
	 * @param date
	 * @return String
	 * @throws Exception
	 */
	public static String DateToString(Date date) {
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.format(date);
		}
		return "";
	}

	/**
	 * 日期转换为字符串，格式为：yyyy/MM/dd
	 * 
	 * @param date
	 * @return String
	 * @throws Exception
	 */
	public static String DateToStr(Date date) {
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			return sdf.format(date);
		}
		return "";
	}

	/**
	 * 日期转换成字符串,格式为：yyyyMMdd
	 * 
	 * @param date
	 * @return
	 */
	public static String DataToStringYYMMDD(Date date) {
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			return sdf.format(date);
		}
		return "";
	}

	/**
	 * 日期转换成字符串,格式为：yyyyMMddHHmmss
	 * 
	 * @param date
	 * @return
	 */
	public static String DataToStringYYMMDDHHMMSS(Date date) {
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			return sdf.format(date);
		}
		return "";
	}

	public static String TimeToString(Date date) {
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			return sdf.format(date);
		}
		return "";
	}

	public static String TimestampToString(Timestamp date) {
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			return sdf.format(date);
		}
		return "";
	}

	/**
	 * 字符串转日期
	 * 
	 * @param String
	 */
	public static Date StringToDate(String str) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (!isNull(str)) {
			try {
				return sdf.parse(str);
			} catch (ParseException e) {
				System.out.println(e.getMessage());
			}
		}
		return null;
	}

	/**
	 * 字符串转日期
	 * 
	 * @param String
	 */
	public static Date FormartStrToDate(String str, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		if (!isNull(str)) {
			try {
				return sdf.parse(str);
			} catch (ParseException e) {
				System.out.println(e.getMessage());
			}
		}
		return null;
	}

	/**
	 * 将字符串转成日期
	 * 
	 * @param str
	 * @return Date
	 */
	public static Date StringToDateTime(String str) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (!isNull(str)) {
			try {
				return sdf.parse(str);
			} catch (ParseException e) {
				System.out.println(e.getMessage());
			}
		}
		return null;
	}

	/**
	 * 包括毫秒
	 * 
	 * @param str
	 * @return
	 */
	public static Date StringToDateTimehasThree(String str) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		if (!isNull(str)) {
			try {
				return sdf.parse(str);
			} catch (ParseException e) {
				System.out.println(e.getMessage());
			}
		}
		return null;
	}

	public static Date StringToDateTimeNoSecond(String str) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if (!isNull(str)) {
			try {
				return sdf.parse(str);
			} catch (ParseException e) {
				System.out.println(e.getMessage());
			}
		}
		return null;
	}

	/**
	 * 将日期转成毫秒
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static long getTimeSecond(String date) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		long milliSecond = sdf.parse(date).getTime();
		return milliSecond;
	}

	/**
	 * 将字符串yyyyMMdd转成日期
	 * 
	 * @param str
	 * @return
	 */
	public static Date StringToDateYYMMDD(String str) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		if (!isNull(str)) {
			try {
				return sdf.parse(str);
			} catch (ParseException e) {
				System.out.println(e.getMessage());
			}
		}
		return null;
	}

	/**
	 * 将字符串转成TimeStamp格式
	 * 
	 * @param str
	 * @return
	 */
	public static Timestamp StringToTimeStamp(String str) {
		if (StringUtils.isNotBlank(str)) {
			Timestamp timestamp = new Timestamp(StringToDateYYMMDD(str).getTime());
			return timestamp;
		}

		return null;
	}

	public static Timestamp StringToTimeStampNoSecond(String str) {

		if (StringUtils.isNotBlank(str)) {
			Timestamp timestamp = new Timestamp(StringToDateTimeNoSecond(str).getTime());
			return timestamp;
		}
		return null;
	}

	public static Timestamp StringToTimeStamphasSecond(String str) {

		if (StringUtils.isNotBlank(str)) {
			Timestamp timestamp = new Timestamp(StringToDateTime(str).getTime());
			return timestamp;
		}
		return null;
	}

	/**
	 * 日期转换成字符串
	 * 
	 * @param dateTime
	 * @return str
	 */
	public static String DateTimeToString(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String string = format.format(date);
		return string;
	}

	/**
	 * 日期转日历
	 * 
	 * @param date
	 * @return Calendar
	 */
	public static Calendar DateToCalendar(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal;
	}

	/**
	 * 日历转日期
	 * 
	 * @param calendar
	 * @return Date
	 */
	public static Date CalendarToDate(Calendar calendar) {
		Date date = calendar.getTime();
		return date;
	}

	/**
	 * 
	 * 
	 * 描述：将日期转换为指定格式字符串
	 * 
	 * @param date
	 *            日期
	 * 
	 * @return
	 */
	public static String getDateStr(Date date)

	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String datestr = sdf.format(date);
		return datestr;
	}

	/**
	 * 
	 * create date:2010-5-22下午03:40:44
	 * 
	 * 描述：取出日期字符串中的年份字符串
	 * 
	 * @param str
	 *            日期字符串
	 * 
	 * @return
	 */

	public static String getYearStr(String str) {

		String yearStr = "";

		yearStr = str.substring(0, 4);

		return yearStr;

	}

	/**
	 * 
	 * create date:2010-5-22下午03:40:47 描述：取出日期字符串中的月份字符串
	 * 
	 * @param str日期字符串
	 * @return
	 */

	public static String getMonthStr(String str) {
		String m;
		int startIndex = str.indexOf("年");
		int endIndex = str.indexOf("月");
		String monthStr = str.substring(startIndex + 1, endIndex);
		return monthStr;
	}

	/**
	 * 
	 * create date:2010-5-22下午03:32:31
	 * 
	 * 描述：将源字符串中的阿拉伯数字格式化为汉字
	 * 
	 * @param sign
	 *            源字符串中的字符
	 * 
	 * @return
	 */

	public static char formatDigit(char sign) {
		if (sign == '0')
			sign = '零';
		if (sign == '1')
			sign = '一';
		if (sign == '2')
			sign = '二';
		if (sign == '3')
			sign = '三';
		if (sign == '4')
			sign = '四';
		if (sign == '5')
			sign = '五';
		if (sign == '6')
			sign = '六';
		if (sign == '7')
			sign = '七';
		if (sign == '8')
			sign = '八';
		if (sign == '9')
			sign = '九';
		return sign;
	}

	/**
	 * 
	 * create date:2010-5-22下午03:31:51
	 * 
	 * 描述： 获得月份字符串的长度
	 * 
	 * @param str
	 *            待转换的源字符串
	 * 
	 * @param pos1
	 *            第一个'-'的位置
	 * 
	 * @param pos2
	 *            第二个'-'的位置
	 * 
	 * @return
	 */

	public static int getMidLen(String str, int pos1, int pos2) {

		return str.substring(pos1 + 1, pos2).length();

	}

	/**
	 * 
	 * create date:2010-5-22下午03:32:17
	 * 
	 * 描述：获得日期字符串的长度
	 * 
	 * @param str
	 *            待转换的源字符串
	 * 
	 * @param pos2
	 *            第二个'-'的位置
	 * 
	 * @return
	 */

	public static int getLastLen(String str, int pos2) {

		return str.substring(pos2 + 1).length();

	}

	/**
	 * 
	 * create date:2010-5-22下午03:40:50
	 * 
	 * 描述：取出日期字符串中的日字符串
	 * 
	 * @param str
	 *            日期字符串
	 * 
	 * @return
	 */

	public static String getDayStr(String str)

	{

		String dayStr = "";

		int startIndex = str.indexOf("月");

		int endIndex = str.indexOf("日");

		dayStr = str.substring(startIndex + 1, endIndex);

		return dayStr;

	}

	/**
	 * 
	 * create date:2010-5-22下午03:32:46
	 * 
	 * 描述：格式化日期
	 * 
	 * @param str
	 *            源字符串中的字符
	 * 
	 * @return
	 */

	public static String formatStr(String str) {
		StringBuffer sb = new StringBuffer();
		int pos1 = str.indexOf("-");
		int pos2 = str.lastIndexOf("-");
		for (int i = 0; i < 4; i++) {
			sb.append(formatDigit(str.charAt(i)));
		}
		sb.append('年');
		if (getMidLen(str, pos1, pos2) == 1) {
			sb.append(formatDigit(str.charAt(5)) + "月");
			if (str.charAt(7) != '0') {
				if (getLastLen(str, pos2) == 1) {
					sb.append(formatDigit(str.charAt(7)) + "日");
				}
				if (getLastLen(str, pos2) == 2) {
					if (str.charAt(7) != '1' && str.charAt(8) != '0') {
						sb.append(formatDigit(str.charAt(7)) + "十" + formatDigit(str.charAt(8)) + "日");
					} else if (str.charAt(7) != '1' && str.charAt(8) == '0') {
						sb.append(formatDigit(str.charAt(7)) + "十日");
					} else if (str.charAt(7) == '1' && str.charAt(8) != '0') {
						sb.append("十" + formatDigit(str.charAt(8)) + "日");
					} else {
						sb.append("十日");
					}
				}
			} else {
				sb.append(formatDigit(str.charAt(8)) + "日");
			}
		}

		if (getMidLen(str, pos1, pos2) == 2) {

			if (str.charAt(5) != '0' && str.charAt(6) != '0') {

				sb.append("十" + formatDigit(str.charAt(6)) + "月");

				if (getLastLen(str, pos2) == 1) {

					sb.append(formatDigit(str.charAt(8)) + "日");

				}

				if (getLastLen(str, pos2) == 2) {

					if (str.charAt(8) != '0') {

						if (str.charAt(8) != '1' && str.charAt(9) != '0') {

							sb.append(formatDigit(str.charAt(8)) + "十" + formatDigit(str.charAt(9)) + "日");

						}

						else if (str.charAt(8) != '1' && str.charAt(9) == '0') {

							sb.append(formatDigit(str.charAt(8)) + "十日");

						}

						else if (str.charAt(8) == '1' && str.charAt(9) != '0') {

							sb.append("十" + formatDigit(str.charAt(9)) + "日");

						}

						else {

							sb.append("十日");

						}

					}

					else {

						sb.append(formatDigit(str.charAt(9)) + "日");

					}

				}

			}

			else if (str.charAt(5) != '0' && str.charAt(6) == '0') {

				sb.append("十月");

				if (getLastLen(str, pos2) == 1) {

					sb.append(formatDigit(str.charAt(8)) + "日");

				}

				if (getLastLen(str, pos2) == 2) {

					if (str.charAt(8) != '0') {

						if (str.charAt(8) != '1' && str.charAt(9) != '0') {

							sb.append(formatDigit(str.charAt(8)) + "十" + formatDigit(str.charAt(9)) + "日");

						}

						else if (str.charAt(8) != '1' && str.charAt(9) == '0') {

							sb.append(formatDigit(str.charAt(8)) + "十日");

						}

						else if (str.charAt(8) == '1' && str.charAt(9) != '0') {

							sb.append("十" + formatDigit(str.charAt(9)) + "日");

						}

						else {

							sb.append("十日");

						}

					}

					else {

						sb.append(formatDigit(str.charAt(9)) + "日");

					}

				}

			}

			else {

				sb.append(formatDigit(str.charAt(6)) + "月");

				if (getLastLen(str, pos2) == 1) {

					sb.append(formatDigit(str.charAt(8)) + "日");

				}

				if (getLastLen(str, pos2) == 2) {

					if (str.charAt(8) != '0') {

						if (str.charAt(8) != '1' && str.charAt(9) != '0') {

							sb.append(formatDigit(str.charAt(8)) + "十" + formatDigit(str.charAt(9)) + "日");

						}

						else if (str.charAt(8) != '1' && str.charAt(9) == '0') {

							sb.append(formatDigit(str.charAt(8)) + "十日");

						}

						else if (str.charAt(8) == '1' && str.charAt(9) != '0') {

							sb.append("十" + formatDigit(str.charAt(9)) + "日");

						}

						else {

							sb.append("十日");

						}

					}

					else {

						sb.append(formatDigit(str.charAt(9)) + "日");

					}

				}

			}

		}

		return sb.toString();

	}

}
