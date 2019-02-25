package com.jsict.biz.util;

import com.jsict.biz.model.Config;
import com.jsict.biz.service.ConfigService;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Component
public  class ConfigUtil
{

    @Resource
    private ConfigService configService;

    private static HashMap<String ,String> hashMap = new HashMap<>();

    private void setConfigService(ConfigService configService){
       this.configService = configService;
    }


    private static ConfigUtil configUtil ;
    private ConfigUtil()
    {

    }
    public static ConfigUtil getInstance()
    {
        return configUtil;
    }

    public  HashMap<String, String> getHashMap() {
        return hashMap;
    }

    public   void setHashMap(HashMap<String, String> hashMap) {
        ConfigUtil.hashMap = hashMap;
    }

    @PostConstruct
    public void init(){
        configUtil = this;
        configUtil.configService = this.configService;
        Config config = new Config();
        config.setDelFlag(0);
        List<Config> configs = configUtil.configService.find(config);
        HashMap<String,String> hashMap = new HashMap<>();
        for(int i=0;i<configs.size();i++)
        {
            hashMap.put(configs.get(i).getKeyy(),configs.get(i).getValuee());
        }
        configUtil.setHashMap(hashMap);
    }

    public static String getValueFromConfig(String key)
    {
        ConfigUtil configUtil = ConfigUtil.getInstance();
        HashMap hashMap = configUtil.getHashMap();
        Object value = hashMap.get(key);
        return value==null?"":value.toString();
    }
}
