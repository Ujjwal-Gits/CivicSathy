package com.civicpulse.shared.util;

import com.civicpulse.shared.config.AppConstants;

/** Pagination calculation. */
public class PaginationUtil {
    public static int getOffset(int page) { return (Math.max(page, 1) - 1) * AppConstants.PAGE_SIZE; }
    public static int getTotalPages(int total) { return (int) Math.ceil((double) total / AppConstants.PAGE_SIZE); }
    public static int clampPage(int page, int totalPages) {
        if (page < 1) return 1;
        if (page > totalPages && totalPages > 0) return totalPages;
        return page;
    }
}
