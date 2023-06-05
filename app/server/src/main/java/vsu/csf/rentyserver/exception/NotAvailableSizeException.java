package vsu.csf.rentyserver.exception;

import lombok.Getter;

@Getter
public class NotAvailableSizeException extends RuntimeException{

    public NotAvailableSizeException(String sizeName, Integer requestedCount, Integer actualCount) {

        super("Size %s has only %d available items, but requested %d"
                .formatted(sizeName, actualCount, requestedCount));

        this.sizeName = sizeName;
        this.requestedCount = requestedCount;
        this.actualCount = actualCount;

    }

    private final String sizeName;
    private final Integer requestedCount;
    private final Integer actualCount;


}
