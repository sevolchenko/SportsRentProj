package vsu.csf.rentyserver.component;

import org.springframework.stereotype.Component;
import vsu.csf.rentyserver.model.entity.Size;

@Component
public class RentProcessor {

    // TODO: 12.05.2023
    public Integer getCountOfAvailable(Size size) {
        return 5;
    }

}
