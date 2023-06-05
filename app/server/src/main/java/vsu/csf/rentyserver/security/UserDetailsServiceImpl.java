package vsu.csf.rentyserver.security;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import vsu.csf.rentyserver.model.entity.AppUser;
import vsu.csf.rentyserver.repository.AppUsersRepository;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final AppUsersRepository usersRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        var appUser = usersRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException(username));

        return fromUser(appUser);
    }

    public static UserDetails fromUser(AppUser user) {
        return new SecurityUser(
                user.getUserId(),
                user.getEmail(),
                user.getPassword(),
                true, true,
                true, true,
                user.getRole().getAuthorities()
        );
    }

}
