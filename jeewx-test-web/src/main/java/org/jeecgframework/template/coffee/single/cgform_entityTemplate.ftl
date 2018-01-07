<#-- start package -->
<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.entity;
<#else>
package ${bussiPackage}.entity.${entityPackage};
</#if>
<#-- end package -->

<#-- start import -->
<#-- 1.实体属性可能的数据类型 -->
import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.xml.soap.Text;
import java.sql.Bolb;
<#-- 2.用到的注解（省去xml配置） -->
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GeneratedType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;
<#-- end import -->

<#-- 类的注释 -->
/**
* @Title: Entity
* @Description: ${ftl_description}
* @author onlineGenerator
* @date ${ftl_create_time}
* @version V1.0

<#-- 类定义 -->
@Entity
@Table(name="${tableName}",schame="")
<#if cgformConfig.cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
@SequenceGenerator(name="SEQ_GEN",sequenceName="${cgformConfig.cgFormHead.jformPkSequence}")
</#if>
@SuppressWarnings({"serial","unused"})
public class ${entityName}Entity implements java.io.Serializable {
	<#list columns as po>
	/**${po.content}*/
	<#if po.isShow != 'N'>@Excel(name="${po.content}",width=15<#if po.type == "java.util.Date">,format="yyyy-MM-dd")</#if><#if po.dictTable?if_exists?html!="">,dictTable="${po.dictTable}",dicCode="${po.dictField}",dictText="${po.dictText}"</#if><#if po.dictTable?if_exists?html==""&&po.dictField?if_exists?html!="">,dicCode="${po.dictField}"</#if>)
	private <#if po.type='java.sql.Blob'>type[]<#else>${po.type}</#if> ${po.fieldName};
	</#if>
	</#list>
	
	<#list columns as po>
	/**
	*方法: 取得${po.type}
	*@return: ${po.type} ${po.content}
	*/
	<#if po.fieldName==jeecg_table_id>
	<#if cgformConfig.cgFormHead.jformPkType?if_exists?html == "UUID">
	@Id
	@GeneratedValue(generator="paymentableGenerator")
	@GenericGenerator(name="paymentableGenerator",strategy="uuid")
	<#elseif cgformConfig.cgFormHead.jformPkType?if_exists?html=="NATIVE">
	@Id
	@GeneratedValue(startegy=GenerationType.AUTO)
	<#elseif cgformConfig.cgFormHead.jformPkType?if_exists?html=="SEQUENCE">
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="SEQ_GEN")
	<#else>
	@Id
	@GeneratedValue(generator="paymentableGenerator")
	@GenericGenerator(name="paymentableGenerator",strategy="uuid")
	</#if>
	</#if>
	
	@Column(name="${fieldMeta[po.fieldName]}",nullable=<#if po.isNull=='Y'>true<#else>false</#if><#if po.pointLength!=0>,scale=${po.pointLength}</#if><#if po.type!='java.sql.Blob'><#if po.length!=0>,length=${po.length?c}</#if></#if>)
	public <#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> get${po.fieldName?cap_first}() {
		return this.${po.fieldName};
	}
	
	/**
	*方法: 设置${po.type}
	*@param: ${po.type}  ${po.content}
	*/
	public void set${po.fieldName?cap_first}(<#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> ${po.fieldName}) {
		this.${po.fieldName} = ${po.fieldName};
	}
	</#list>
}

