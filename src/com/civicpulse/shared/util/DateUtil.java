package com.civicpulse.shared.util;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.Instant;

/** Date formatting — "time ago" strings. */
public class DateUtil {
    public static String timeAgo(Timestamp ts) {
        if (ts == null) return "";
        long sec = Duration.between(ts.toInstant(), Instant.now()).getSeconds();
        if (sec < 60) return "Just now";
        if (sec < 3600) return (sec / 60) + "m ago";
        if (sec < 86400) return (sec / 3600) + "h ago";
        if (sec < 604800) return (sec / 86400) + " days ago";
        return (sec / 2592000) + " months ago";
    }
}
