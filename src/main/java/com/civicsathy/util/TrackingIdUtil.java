package com.civicsathy.util;

import java.util.Random;

// generates unique tracking IDs for complaints like CS-W5-A3B7
/**
 * Utility class providing helper methods for TrackingIdUtil.
 * 
 * @author Prashant
 * @version 1.0
 */
public class TrackingIdUtil {

	/**
	 * Executes the generate operation.
	 *
	 * @param wardNo The wardNo object/value.
	 * @return The resulting String.
	 */
	public static String generate(int wardNo) {
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		Random random = new Random();
		StringBuilder code = new StringBuilder();
		for (int i = 0; i < 4; i++) {
			code.append(chars.charAt(random.nextInt(chars.length())));
		}
		return "CS-W" + wardNo + "-" + code.toString();
	}
}
