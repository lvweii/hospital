package com.jsict.biz.service;

import com.jsict.biz.model.Register;
import com.jsict.framework.core.controller.Response;
import com.jsict.framework.core.service.GeneriService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * RegisterService ：
 *
 * @author Lv
 * @since 2019/2/28 20:22
 */
public interface RegisterService extends GeneriService<Register, String> {

  Response saveRegister(Register register);

  Page<Register> findByPageForDoctor(Register register, Pageable pageable);
}
