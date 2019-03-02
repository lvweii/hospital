package com.jsict.biz.service.impl;

import com.jsict.biz.model.Register;
import com.jsict.biz.service.RegisterService;
import com.jsict.framework.core.service.impl.GeneriServiceImpl;
import org.springframework.stereotype.Service;

/**
 * RegisterServiceImpl ：
 *
 * @author Lv
 * @since 2019/2/28 20:22
 */
@Service
public class RegisterServiceImpl extends GeneriServiceImpl<Register, String> implements
    RegisterService {

}
