package com.terraform_aws_demo;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
public class HelloController {
    
    @GetMapping("/hello")
    public String sayHello() {
        return "Hello, Terraform AWS Demo!";
    }
}
