package vsu.csf.rentyserver.controller.impl.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

@Controller
@RequestMapping("/pay")
public class PayController {

    @GetMapping()
    public String getPayPage(@RequestParam("receipt_id") UUID receiptId) {
        return "pay/index.html";
    }

}
