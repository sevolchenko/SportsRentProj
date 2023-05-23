package vsu.csf.rentyserver.model.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum Permission {

    READ("read"),
    WRITE("write");

    private final String permission;

}
