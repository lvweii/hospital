package com.jsict.biz.dao.impl;

import com.jsict.biz.dao.RegisterDao;
import com.jsict.biz.model.Register;
import com.jsict.framework.core.dao.hibernate.GenericHibernateDaoImpl;
import org.springframework.stereotype.Repository;

/**
 * RegisterDaoImpl ：
 *
 * @author Lv
 * @since 2019/2/28 20:24
 */
@Repository
public class RegisterDaoImpl extends GenericHibernateDaoImpl<Register, String> implements
    RegisterDao {

}
