package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.user.response.UserResponse;
import vsu.csf.rentyserver.model.entity.AppUser;

@Mapper(config = MapperConfiguration.class)
public interface UserMapper {

    UserResponse map(AppUser user);

}
