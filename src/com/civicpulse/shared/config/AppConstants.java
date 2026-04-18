package com.civicpulse.shared.config;

/** App-wide constants. Change here → changes everywhere. */
public final class AppConstants {
    private AppConstants() {}

    public static final String STATUS_PENDING = "PENDING";
    public static final String STATUS_IN_PROGRESS = "IN_PROGRESS";
    public static final String STATUS_RESOLVED = "RESOLVED";
    public static final String STATUS_REJECTED = "REJECTED";

    public static final String ROLE_CITIZEN = "CITIZEN";
    public static final String ROLE_ADMIN = "ADMIN";

    public static final String SESSION_USER = "loggedInUser";
    public static final String SESSION_USER_ID = "userId";
    public static final String SESSION_USER_ROLE = "userRole";

    public static final String UPLOADS_DIR = "/uploads/complaints/";
    public static final int MAX_IMAGE_SIZE_MB = 5;
    public static final long MAX_IMAGE_SIZE_BYTES = MAX_IMAGE_SIZE_MB * 1024L * 1024L;
    public static final int PAGE_SIZE = 10;
    public static final String TRACKING_PREFIX = "MET";
}
