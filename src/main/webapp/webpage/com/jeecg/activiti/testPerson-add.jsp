<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>入职员工</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css" />
  <script type="text/javascript" src="plug-in/uploadify/jquery.uploadify-3.1.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="testPersonController.do?doAdd" callback="jeecgFormFileCallBack@Override">
					<input id="id" name="id" type="hidden" value="${testPersonPage.id }"/>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							名字:
						</label>
					</td>
					<td class="value">
					     	 <input id="name" name="name" type="text" style="width: 150px" class="inputxt"  datatype="s"  ignore="checked" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">名字</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							性别:
						</label>
					</td>
					<td class="value">
								<input id="sex"   type="text"
							       style="width: 150px" class="inputxt"  datatype="*"  ignore="ignore" 
					               onclick="showSexTree();" readonly="readonly">
					               <input type="hidden" id="sexId" name="sex"  class="showSex">  
									<div id="showSexTreeContent" class="menuContent" style="display: none; position: absolute; border: 1px #CCC solid; background-color: #F0F6E4;z-index:9999;">  
									    <ul id="showSexTree" class="ztree" style="margin-top:0;"></ul>  
									</div>
								<script>
									$(function(){
										if(!$.fn.zTree){
											$("head").append('<link rel="stylesheet" href="plug-in/ztree/css/zTreeStyle.css"/>');
											$("head").append('<script type=\"text/javascript\" src=\"plug-in/ztree/js/jquery.ztree.core-3.5.min.js\"><\/script>');
											$("head").append('<script type=\"text/javascript\" src=\"plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js\"><\/script>');
										}
										var defaultVal = $("#sexId").val();
										$("#sex").val(getTreeResult(defaultVal));
										$("body").bind("mousedown", onBodyDownBySex);  
									});
									
									var sexSetting = {  
										   check: {  
								                enable: true
									        }, 
										    view: {  
										        dblClickExpand: false  
										    },  
										    data: {  
										        simpleData: {  
										            enable: true  
										        },
										        key:{
										        	name:'text'
										        }
										    },  
										    callback: {  
										        onClick: sexOnClick,
										        onCheck: sexOnCheck
										    }   
										}; 
									function sexOnCheck(e, treeId, treeNode) { 
										    var idVal = $("#sexId").val();
										    var textVal = $("#sex").val();
										    if(treeNode.checked){
										    	//选中
										    	if(idVal != null && idVal != ''){
										    		$("#sexId").val(idVal + ',' +treeNode.id);  
											    }else{
												    $("#sexId").val(treeNode.id);  
											    }
											    if(textVal != null && textVal != ''){
											    	 $("#sex").val(textVal + ',' + treeNode.text);  
											    }else{
												    $("#sex").val(treeNode.text);  
											    }
										    }else{
										    	idVal = idVal.replace(treeNode.id,"");
										    	if(idVal.indexOf(",") == 0){
										    		idVal = idVal.substring(1);
										    	}else if(idVal.indexOf(",,") > -1){
										    		idVal = idVal.replace(",,",",");
										    	}else if(idVal.indexOf(",") == idVal.length -1){
										    		idVal = idVal.substring(0,idVal.length - 1);
										    	}
										    	textVal = textVal.replace(treeNode.text,"");
										    	if(textVal.indexOf(",") == 0){
										    		textVal = textVal.substring(1);
										    	}else if(textVal.indexOf(",,") > -1){
										    		textVal = textVal.replace(",,",",");
										    	}else if(textVal.indexOf(",") == textVal.length -1){
										    		textVal = textVal.substring(0,textVal.length - 1);
										    	}
										    	$("#sex").val(textVal);
										    	 $("#sexId").val(idVal);
										    }
										    e.stopPropagation();
										}  
									function sexOnClick(e, treeId, treeNode) {  
										    var zTree = $.fn.zTree.getZTreeObj("showSexTree");  
										  	zTree.checkNode(treeNode, !treeNode.checked, true,true);
										  	e.stopPropagation();
										}    
									function showSexTree(){
										 $.ajax({  
									        url:'categoryController.do?tree',  
									        type:'POST',  
									        dataType:'JSON',
									        async:false,  
									        success:function(res){
									            var obj = res; 
									            $.fn.zTree.init($("#showSexTree"), sexSetting, obj);  
									            var deptObj = $("#sex");  
									            var deptOffset = $("#sex").offset();  
									            $("#showSexTreeContent").css({left:deptOffset.left + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");  
									            $('#showSexTree').css({width:deptObj.outerWidth() - 12 + "px"});  
									            var zTree = $.fn.zTree.getZTreeObj("showSexTree");  
									            var idVal =  $("#sexId").val();
									            if(idVal != null && idVal != ''){
										             if(idVal.indexOf(",") > -1){
										            	var idArray = idVal.split(",");
										            	for(var i = 0; i < idArray.length; i++){
										            		var node = zTree.getNodeByParam("id", idArray[i], null);
										            		zTree.checkNode(node, true, true);
										            	}
										            }else{
										            	var node = zTree.getNodeByParam("id", idVal, null);
										            		zTree.checkNode(node, true, true);
										            } 
									            } 
									            
									        }  
									    });  
									    }
									    function onBodyDownBySex(event){
									    	if(event.target.id == '' || (event.target.id.indexOf('switch') == -1 
										    	&& event.target.id.indexOf('check') == -1 
										    	&& event.target.id.indexOf('span') == -1
										    	&& event.target.id.indexOf('ico') == -1)){  
										    	$("#showSexTreeContent").fadeOut("fast");  
	   											 //$("body").unbind("mousedown", onBodyDownBySex);
   											 }
									    }
								</script>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">性别</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							生日:
						</label>
					</td>
					<td class="value">
							   <input id="birthday" name="birthday" type="text" style="width: 150px" class="Wdate" onClick="WdatePicker()"  datatype="*"  ignore="ignore" />    
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">生日</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							测性别:
						</label>
					</td>
					<td class="value">
							  <t:dictSelect field="cexs" type="list"  typeGroupCode="sex"  defaultVal="${testPersonPage.cexs}" hasLabel="false"  title="测性别" ></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">测性别</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							工资:
						</label>
					</td>
					<td class="value">
					     	 <input id="salary" name="salary" type="text" style="width: 150px" class="inputxt"  datatype="d"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">工资</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							简历附件:
						</label>
					</td>
					<td class="value">
								<table></table>
								<div class="form jeecgDetail"> 
									<script type="text/javascript">
										var serverMsg="";
										$(function(){
											$('#fielJls').uploadify({
												buttonText:'添加文件',
												auto:false,
												progressData:'speed',
												multi:true,
												height:25,
												overrideEvents:['onDialogClose'],
												fileTypeDesc:'文件格式:',
												queueID:'filediv_fielJls',
												fileSizeLimit:'15MB',
												swf:'plug-in/uploadify/uploadify.swf',	
												uploader:'cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
												onUploadStart : function(file) { 
													var cgFormId=$("input[name='id']").val();
													$('#fielJls').uploadify("settings", "formData", {
														'cgFormId':cgFormId,
														'cgFormName':'test_person',
														'cgFormField':'FIEL_JLS'
													});
												} ,
												onQueueComplete : function(queueData) {
													 var win = frameElement.api.opener;
													 win.reloadTable();
													 win.tip(serverMsg);
													 frameElement.api.close();
												},
												onUploadSuccess : function(file, data, response) {
													var d=$.parseJSON(data);
													if(d.success){
														var win = frameElement.api.opener;
														serverMsg = d.msg;
													}
												},
												onFallback: function() {
								                    tip("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试")
								                },
								                onSelectError: function(file, errorCode, errorMsg) {
								                    switch (errorCode) {
								                    case - 100 : tip("上传的文件数量已经超出系统限制的" + $('#file').uploadify('settings', 'queueSizeLimit') + "个文件！");
								                        break;
								                    case - 110 : tip("文件 [" + file.name + "] 大小超出系统限制的" + $('#file').uploadify('settings', 'fileSizeLimit') + "大小！");
								                        break;
								                    case - 120 : tip("文件 [" + file.name + "] 大小异常！");
								                        break;
								                    case - 130 : tip("文件 [" + file.name + "] 类型不正确！");
								                        break;
								                    }
								                },
								                onUploadProgress: function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) {}
											});
										});
									</script>
									<span id="file_uploadspan"><input type="file" name="fielJls" id="fielJls" /></span> 
								</div> 
								<div class="form" id="filediv_fielJls"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">简历附件</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							个人头像:
						</label>
					</td>
					<td class="value">
								<table></table>
								<div class="form jeecgDetail"> 
									<script type="text/javascript">
										var serverMsg="";
										$(function(){
											$('#touPic').uploadify({
												buttonText:'添加图片',
												auto:false,
												progressData:'speed',
												multi:true,
												height:25,
												overrideEvents:['onDialogClose'],
												fileTypeDesc:'文件格式:',
												queueID:'filediv_touPic',
												fileSizeLimit:'15MB',
												swf:'plug-in/uploadify/uploadify.swf',	
												uploader:'cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
												onUploadStart : function(file) { 
													var cgFormId=$("input[name='id']").val();
													$('#touPic').uploadify("settings", "formData", {
														'cgFormId':cgFormId,
														'cgFormName':'test_person',
														'cgFormField':'TOU_PIC'
													});
												} ,
												onQueueComplete : function(queueData) {
													 var win = frameElement.api.opener;
													 win.reloadTable();
													 win.tip(serverMsg);
													 frameElement.api.close();
												},
												onUploadSuccess : function(file, data, response) {
													var d=$.parseJSON(data);
													if(d.success){
														var win = frameElement.api.opener;
														serverMsg = d.msg;
													}
												},
												onFallback: function() {
								                    tip("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试")
								                },
								                onSelectError: function(file, errorCode, errorMsg) {
								                    switch (errorCode) {
								                    case - 100 : tip("上传的文件数量已经超出系统限制的" + $('#file').uploadify('settings', 'queueSizeLimit') + "个文件！");
								                        break;
								                    case - 110 : tip("文件 [" + file.name + "] 大小超出系统限制的" + $('#file').uploadify('settings', 'fileSizeLimit') + "大小！");
								                        break;
								                    case - 120 : tip("文件 [" + file.name + "] 大小异常！");
								                        break;
								                    case - 130 : tip("文件 [" + file.name + "] 类型不正确！");
								                        break;
								                    }
								                },
								                onUploadProgress: function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) {}
											});
										});
									</script>
									<span id="file_uploadspan"><input type="file" name="touPic" id="touPic" /></span> 
								</div> 
								<div class="form" id="filediv_touPic"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">个人头像</label>
						</td>
				</tr>
				
				
				<tr>
					<td align="right">
						<label class="Validform_label">
							个人简介:
						</label>
					</td>
					<td class="value" >
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
						    	<textarea name="conets" id="conets" style="width: 650px;height:300px"></textarea>
							    <script type="text/javascript">
							        var conets_editor = UE.getEditor('conets');
							    </script>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">个人简介</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/commonms/testPerson.js"></script>		
	  	<script type="text/javascript">
	  		function jeecgFormFileCallBack(data){
	  			if (data.success == true) {
					uploadFile(data);
				} else {
					if (data.responseText == '' || data.responseText == undefined) {
						$.messager.alert('错误', data.msg);
						$.Hidemsg();
					} else {
						try {
							var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
							$.messager.alert('错误', emsg);
							$.Hidemsg();
						} catch(ex) {
							$.messager.alert('错误', data.responseText + '');
						}
					}
					return false;
				}
				if (!neibuClickFlag) {
					var win = frameElement.api.opener;
					win.reloadTable();
				}
	  		}
	  		function upload() {
					$('#fielJls').uploadify('upload', '*');	
					$('#touPic').uploadify('upload', '*');	
			}
			
			var neibuClickFlag = false;
			function neibuClick() {
				neibuClickFlag = true; 
				$('#btn_sub').trigger('click');
			}
			function cancel() {
					$('#fielJls').uploadify('cancel', '*');
					$('#touPic').uploadify('cancel', '*');
			}
			function uploadFile(data){
				if(!$("input[name='id']").val()){
					if(data.obj!=null && data.obj!='undefined'){
						$("input[name='id']").val(data.obj.id);
					}
				}
				if($(".uploadify-queue-item").length>0){
					upload();
				}else{
					if (neibuClickFlag){
						alert(data.msg);
						neibuClickFlag = false;
					}else {
						var win = frameElement.api.opener;
						win.reloadTable();
						win.tip(data.msg);
						frameElement.api.close();
					}
				}
			}
	  	</script>
