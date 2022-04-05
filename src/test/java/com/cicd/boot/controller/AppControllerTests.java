package com.cicd.boot.controller;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(SpringExtension.class)
@WebMvcTest(AppController.class)
public class AppControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testFindByCompanyId() throws Exception {
        mockMvc.perform(get("/api/helloWorld")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }
}
