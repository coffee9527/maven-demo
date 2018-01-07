<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/content/mytags.jsp"%>
<#include "../../ui/tdgCol.ftl"/>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding:0px;border:0px">
	<t:datagrid name="${entityName?uncap_first}rowList" chechbox="true" <#if cgformConfig.cgFormHead.isPaginatin=='Y'> pagination="true"<#else> pagination="false"</#if><#if cgformConfig.cgFormHead.isTree=='Y'> treegrid="true" treeField="${cgformConfig.cgFormHead.treeFieldnamePage}"</#if> fitColumns="true"
	title="${ftl_description}" actionUrl="${entityName?uncap_first}Controller.do?datagrid" idField="id" queryMode="group">
	<#list columns as po>
	<#if po.isShowList=='N'>
	<t:dgCol title="${po.content}" field="${po.fieldName}" hidden="true"></t:dgCol>
	<#elseif po.showType=='date'>
	<t:dgCol title="${po.content}" field="${po.fieldName}" queryMode="${po.queryMode} <#if po.isQuery=='Y'>query="true"</#if> <#if po.dictField!="">dictonary=${po.dictField}"</#if> formatter="yyyy-MM-dd" extendParams="editor:'datebox'" width="100"></t:dgCol>
	<#elseif po.showType == 'textarea'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'textarea'" width="100"></t:dgCol>
    <#elseif po.showType == 'checkbox' >
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'combobox'" width="100"></t:dgCol>
    <#elseif po.showType == 'radio'> 
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'combobox'" width="100"></t:dgCol>
    <#elseif po.showType == 'datetime'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> formatter="yyyy-MM-dd hh:mm:ss" extendParams="editor:'datebox'" width="100"></t:dgCol>
    <#elseif po.showType == 'list'> 
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'combobox'" width="100"></t:dgCol>
    <#elseif po.type == 'int'> 
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'numberbox'" width="100"></t:dgCol>
    <#elseif po.type == 'double'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'numberbox'" width="100"></t:dgCol>
    <#elseif po.type == 'BigDecimal'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'numberbox'" width="100"></t:dgCol>
    <#else> 
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if  po.dictField != "">dictionary="${po.dictField}"</#if> extendParams="editor:'text'" width="100"></t:dgCol>
	</#if>
	</#list>
	<t:dgToolBar operationCode="add" title="录入" icon="icon-add" funname="addRow"></t:dgToolBar>
	<t:dgToolBar operationCode="edit" title="编辑" icon="icon-edit" funname="editRow"></t:dgToolBar>
	<t:dgToolBar operationCode="save" title="保存" icon="icon-save" url="${entityName?uncap_first}Controller.do?saveRows funname="saveData"></t:dgToolBar>
	<t:dgToolBar operationCode="undo" title="取消编辑" icon="icon-undo" funname="reject"></t:dgToolBar>
    <t:dgToolBar title="批量删除"  icon="icon-remove" url="${entityName?uncap_first}Controller.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
  </div>
  </div>
  <script type="text/javascript">
  //添加行
  function addRow(title,addurl,gname) {
  	$('#'+gname).datagrid('appendRow',{});
  	var editIndex = $('#'+gname).datagrid('getRows').length-1;
  	$('#'+gname).datagrid('selectRow',editIndex).datagrid('beginEdit',editIndex);
  }
  //保存数据
  function saveData(title,addurl,gname) {
  	if(!endEdit()) return false;
  	var row=$('#'+gname).datagrid("getChanges","inserted");
  	var uprows=$('#'+gname).datagrid("getChanges","updated");
  	rows=rows.concat(uprows);
  	if(rows.length<=0) {
  		tip("没有需要保存的数据！");
  		return false;
  	}
  	var result={};
  	for(var i=0;i<rows.length;i++) {
  		for(var d in rows[i]) {
  			result["${entityName?uncap_first}List["+i+"]."+d]=rows[i][d];
  		}
  	}
  }
  $.ajax({
			url:"<%=basePath%>/"+addurl,
			type:"post",
			data:result,
			dataType:"json",
			success:function(data){
				tip(data.msg);
				if(data.success){
					reloadTable();
				}
			}
		})
	}
	//结束编辑
	function endEdit(gname){
		var  editIndex = $('#'+gname).datagrid('getRows').length-1;
		for(var i=0;i<=editIndex;i++){
			if($('#'+gname).datagrid('validateRow', i))
				$('#'+gname).datagrid('endEdit', i);
			else
				return false;
		}
		return true;
	}
	//编辑行
	function editRow(title,addurl,gname){
		var rows=$('#'+gname).datagrid("getChecked");
		if(rows.length==0){
			tip("请选择条目");
			return false;
		}
		for(var i=0;i<rows.length;i++){
			var index= $('#'+gname).datagrid('getRowIndex', rows[i]);
			$('#'+gname).datagrid('beginEdit', index);
		}
	}
	//取消编辑
	function reject(title,addurl,gname){
		$('#'+gname).datagrid('clearChecked');
		$('#'+gname).datagrid('rejectChanges');
	}
  </script>