package vsu.csf.rentyserver.util;

import java.time.Duration;

public final class DurationUtils {

    private DurationUtils() {}

    public static String formatDuration(Duration duration) {
        long days = duration.toDays();
        long hours = duration.toHours() % 24;
        long minutes = duration.toMinutes() % 60;

        StringBuilder builder = new StringBuilder();

        if (days > 0) {
            builder.append(days).append(" ").append(getPlural(days, "день", "дня", "дней")).append(" ");
        }

        if (hours > 0) {
            builder.append(hours).append(" ").append(getPlural(hours, "час", "часа", "часов")).append(" ");
        }

        if (minutes > 0) {
            builder.append(minutes).append(" ").append(getPlural(minutes, "минута", "минуты", "минут")).append(" ");
        }

        return builder.toString().trim();
    }

    private static String getPlural(long number, String one, String two, String many) {
        if (number % 10 == 1 && number % 100 != 11) {
            return one;
        } else if (number % 10 >= 2 && number % 10 <= 4 && (number % 100 < 10 || number % 100 >= 20)) {
            return two;
        } else {
            return many;
        }
    }

}
