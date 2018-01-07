<#if packageStyle=="service">
package ${bussiPackage}.${fentityPackage}.service.impl;
import ${bussiPackage}.${entityPackage}.service.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.${fentityPackage}.entity.${entityName}Entity;
<#else>
package ${bussiPackage}.service.impl.${entityPackage};
import ${bussiPackage}.service.${entityPackage}.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
</#if>
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotain.Transactional;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.io.Serializable;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.MyClassLoader;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.cgform.enhance.CgformEnhanceJavaInter;
@Service("${entityName?uncap_first}Service")
@Transactional
public class ${entityName}ServiceImpl extends CommonServiceImpl implements ${entityName}ServiceI {
	public void delete(${entityName}Entity entity) throws Exception {
		super.delete(entity);
		this.doDelBus(entity);
	}
	
	public Serializable save(${entityName}Entity entity) throws Exception {
		Serializable t = super.save(entity);
		this.doAddBus(entity);
		return t;
	}
	
	public void saveOrUpdate(${entityName}Entity entity) throws Exception {
		super.saveOrUpdate(entity);
		this.doUpdateBus(entity);
	}
	
	<#-- TODO 增强操作 -->
}