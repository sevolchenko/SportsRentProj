package vsu.csf.rentyserver.exception;

public class DuplicateElementException extends DataSourceConstraintsException{

    public DuplicateElementException(String varName, Class<?> clazz, Object entityId) {
        super("Element %s %s (%s) already exists in data source"
                        .formatted(varName, clazz.toString(), entityId.toString()),
                varName, clazz, entityId);
    }

}
