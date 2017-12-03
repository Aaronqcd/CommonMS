<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="testPersonList" checkbox="true" pagination="true" fitColumns="true" title="入职员工" actionUrl="activitiController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属部门"  field="sysOrgCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属公司"  field="sysCompanyCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="流程状态"  field="bpmStatus"  queryMode="single"  dictionary="bpm_status"  width="120"></t:dgCol>
   <t:dgCol title="名字"  field="name"  query="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="性别"  field="sex"  query="true"  queryMode="single"  dictionary="A01"  formatterjs="treeFormater" width="120"></t:dgCol>
   <t:dgCol title="生日"  field="birthday"  formatter="yyyy-MM-dd"  query="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="个人简介"  field="conets"  hidden="true"  queryMode="single"  width="500"></t:dgCol>
   <t:dgCol title="测性别"  field="cexs"  queryMode="single"  dictionary="sex"  width="120"></t:dgCol>
   <t:dgCol title="工资"  field="salary"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="简历附件"  field="fielJls"  queryMode="single"  downloadName="附件下载"  width="120"></t:dgCol>
   <t:dgCol title="个人头像"  field="touPic"  queryMode="single"  image="true" imageSize="50,50"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="activitiController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
    	<t:dgFunOpt funname="doOnbb(id)" title="Link按钮" urlclass="ace_button"
				urlfont="fa-wrench"
    	  />
   <t:dgToolBar title="录入" icon="icon-add" url="activitiController.do?goAdd" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="activitiController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="activitiController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="activitiController.do?goUpdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
		<t:dgToolBar title="上方按钮" icon="icon-edit" funname="doBb"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/com/jeecg/activiti/testPersonList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
		//自定义按钮-上方按钮
	 	function doBb(title,url,gridname){
	 		bb();
	 	}
   
		//自定义按钮-Link按钮
	 	function doOnbb(id,index){
	 		onbb(id);
	 	}
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'activitiController.do?upload', "testPersonList");
}

//导出
function ExportXls() {
	JeecgExcelExport("activitiController.do?exportXls","testPersonList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("activitiController.do?exportXlsByT","testPersonList");
}

 </script>