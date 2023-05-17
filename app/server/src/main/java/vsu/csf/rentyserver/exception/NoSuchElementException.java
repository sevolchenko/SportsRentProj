package vsu.csf.rentyserver.exception;

public class NoSuchElementException extends DataSourceConstraintsException {

    public NoSuchElementException(String varName, Class<?> clazz, Object entityId) {
        super("Element %s %s (%s) not found in data source"
                        .formatted(varName, clazz.toString(), entityId),
                varName, clazz, entityId);
    }

}
