package vsu.csf.rentyserver.exception;

import lombok.Getter;

@Getter
public class DataSourceConstraintsException extends RuntimeException{

    public DataSourceConstraintsException(String message, String varName, Class<?> clazz, Object entityId) {
        super(message);
        this.varName = varName;
        this.clazz = clazz;
        this.entityId = entityId;
    }

    private final String varName;
    private final Class<?> clazz;
    private final Object entityId;

}
