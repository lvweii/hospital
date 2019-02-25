package com.jsict.biz.controller;

import com.jsict.biz.model.Config;
import com.jsict.biz.model.User;
import com.jsict.biz.service.ConfigService;
import com.jsict.biz.util.ConfigUtil;
import com.jsict.framework.core.controller.AbstractGenericController;
import com.jsict.framework.core.controller.CSRFTokenManager;
import com.jsict.framework.core.controller.Response;
import com.jsict.framework.core.controller.RestControllerException;
import com.jsict.framework.core.security.model.IUser;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("config")
public class ConfigController extends AbstractGenericController<Config, String,Config> {
/**
 * 示例代码
 * @Override
 * @RequestMapping(value = "/save", method = RequestMethod.POST, produces = "application/json")
 * @ResponseBody
 * public Response save(@ModelAttribute Config entity, @RequestParam(value = CSRFTokenManager.CSRF_PARAM_NAME) String paramToken, HttpServletRequest request){
 *   return super.save(entity, paramToken, request);
 * }
 */
@Autowired
private ConfigService configService;

    @RequestMapping(value = "/config")
    @ModelAttribute("configs")
    private List<Config> applyGoods()
    {
        Config config = new Config();
        config.setDelFlag(0);
        //查询用户id
        IUser user = (IUser)SecurityUtils.getSubject().getPrincipal();
        User u = (User) user;
        if(!(u.isAdmin()))
        {
            config.setLevell("2");
        }
        List<Config> configs = configService.find(config);
        return configs;
    }


    @RequestMapping(
            value = {"/getMypage"},
            method = {RequestMethod.POST},
            produces = {"application/json"}
    )
    @ResponseBody
    public Page<Config> page1(@ModelAttribute Config config, @PageableDefault Pageable pageable) {
        //查询用户id
        IUser user = (IUser)SecurityUtils.getSubject().getPrincipal();
        User u = (User) user;
        if(!(u.isAdmin()))
        {
            config.setLevell("2");
        }
        try {
            return configService.findByPage(config, pageable);
        } catch (Exception var4) {
            throw new RestControllerException("翻页查询出错", var4);
        }
    }

    @RequestMapping(
            value = {"/my"},
            method = {RequestMethod.GET}
    )
    public String good(HttpServletRequest request, @RequestParam String method, @RequestParam(required = false) String id, @RequestParam(required = false) String level,@RequestParam(required = false) String moduleId) {
        String csrfToken = CSRFTokenManager.getTokenForSession(request.getSession());
        if (StringUtils.isNotBlank(id)) {
            request.setAttribute("id", id);
        }
        if (StringUtils.isNotBlank(id)) {
            request.setAttribute("level", level);
        }

        if (StringUtils.isNotBlank(moduleId)) {
            request.getSession().setAttribute("moduleId", moduleId);
        }

        request.setAttribute("CSRFToken", csrfToken);
        return  "/config/" + method;
    }

    @ResponseBody
    @RequestMapping(value = "/save")
    private Map<String,String> save(@RequestParam String id,@RequestParam String name,@RequestParam String keyy,@RequestParam String valuee ,@RequestParam String levell)
    {
        if(StringUtils.isNotEmpty(levell) && levell.length()>1)
        {
            levell = "2";
        }   else
        {
            levell = "1";
        }
        return update(id,name,keyy,valuee,"add",levell);
    }



    @ResponseBody
    @RequestMapping(value = "/update")
    private Map<String,String> update(@RequestParam String id,@RequestParam String keyy,@RequestParam String valuee ,@RequestParam String levell)
    {
        if(StringUtils.isNotEmpty(levell) && levell.length()>1)
        {
            levell = "2";
        }   else
        {
            levell = "1";
        }
        return update(id,"",keyy,valuee,"update",levell);
    }

    @Override
    @ResponseBody
    @RequestMapping(value = "/delete/{id}",method = RequestMethod.POST)
    public Response delete(@PathVariable(value="id") String id)
    {
        Response response;
        try
        {
            String  re= update(id,"","","","del","").get("responseCode");
            if ("0".equals(re)) {
                response = new Response(SUCCESS);
            } else {
                response = new Response(ERROR, "没有找到对象");
            }
        } catch (Exception var4) {
            response = new Response(ERROR, var4.getLocalizedMessage());
        }

        return response;

    }



    private Map<String,String> update( String id, String name,String keyy, String valuee  , String model,String levell)
    {
        //查询用户id
        IUser user = (IUser)SecurityUtils.getSubject().getPrincipal();
        User u = (User) user;
        if(!(u.isAdmin()))
        {
           levell="2";
        }
        Map<String,String> map = new HashMap<>();
        map.put("responseCode","1");
        if("update".equals(model))
            {
                Config config1 = new Config();
                config1.setId(id);
                Config  config2 = configService.singleResult(config1);
                config2.setKeyy(keyy);
                config2.setLevell(levell);
                config2.setValuee(valuee);
                configService.saveOrUpdate(config2);
                updateConfigMap(config2,"update");
                map.put("responseCode","0");

            }
            else if("add".equals(model))
            {
                Config config1 = new Config();
                config1.setDelFlag(0);
                config1.setKeyy(keyy);
                List<Config> configs = configService.find(config1);
                if(CollectionUtils.isEmpty(configs))
                {
                    config1.setName(name);
                    config1.setLevell(levell);
                    config1.setValuee(valuee);
                    configService.save(config1);
                    updateConfigMap(config1,"update");
                    map.put("responseCode","0");
                } else
                {
                    map.put("responseCode","1");
                    map.put("msg","key值已存在");
                }

            }
            else if("del".equals(model))
            {
                List<String> ids = new ArrayList<>();
                Config config =new Config();
                ids.add(id);
                config.setId(id);
                config = configService.singleResult(config);
                Boolean  isSucess= configService.deleteByIds(ids);
                if(isSucess)
                {
                    map.put("responseCode","0");
                    updateConfigMap(config,"del");
                    map.put("responseCode","0");
                }
            }
             return map;
    }


    private Boolean updateConfigMap (Config config,String model)
    {
        if(config==null || config.getKeyy() == null || config.getValuee() == null) {return false;}
        HashMap<String,String> configHashMap = ConfigUtil.getInstance().getHashMap();
        if("update".equals(model))
        {
            configHashMap.put(config.getKeyy(),config.getValuee());
            configHashMap.put(config.getKeyy(),config.getValuee());
        }
        else if("del".equals(model))
        {
            for (Iterator<Map.Entry<String, String>> it = configHashMap.entrySet().iterator(); it.hasNext();){
                Map.Entry<String, String> item = it.next();
               if(config.getKeyy().equals(item.getKey()))
               {
                   it.remove();
               }

            }
            configHashMap.remove(config.getKeyy());
        }
        ConfigUtil.getInstance().setHashMap(configHashMap);
        return true;
    }

}