package vsu.csf.rentyserver.model.entity.enumeration;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

@AllArgsConstructor
@Getter
public enum Permission {

    READ("read"),
    WRITE("write");

    private final String permission;

    public SimpleGrantedAuthority getAuthority() {
        return new SimpleGrantedAuthority(permission);
    }

}
