package vsu.csf.rentyserver.model.entity.enumeration;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Set;
import java.util.stream.Collectors;

@AllArgsConstructor
@Getter
public enum Role {

    USER(Set.of(Permission.READ)),
    EMPLOYEE(Set.of(Permission.READ, Permission.WRITE));

    private final Set<Permission> permissions;

    public Set<SimpleGrantedAuthority> getAuthorities() {
        return permissions.stream()
                .map(Permission::getAuthority)
                .collect(Collectors.toSet());
    }

}
