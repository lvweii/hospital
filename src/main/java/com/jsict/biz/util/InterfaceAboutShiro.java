package com.jsict.biz.util;
import com.jsict.framework.utils.SysConfig;
import org.apache.shiro.web.filter.authz.RolesAuthorizationFilter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class InterfaceAboutShiro extends RolesAuthorizationFilter
{

    @Autowired
    private SysConfig sysConfig;

    public InterfaceAboutShiro(){}
    public boolean isAccessAllowed(HttpServletRequest request, HttpServletResponse response, Object mappedValue) throws
    IOException
    {
            return Boolean.TRUE;
    }

}
