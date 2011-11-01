function MipArchieve(){
	/**
	 * Description: 操作公文的基础类
	 * @Version1.0 Mar 3, 2008 5:19:24 PM 吴亮（wuliang1@d-heaven.com）创建
	 */
	var id = "";
	var subject="";
	var content="";
	var requesttype="";
	var starttime="";
	var endtime="";
	var vto="";
	var cc="";
	var workflowid="";
	var att="";
	var priority="";
	var filenum="";
	var productcount="";
	var phone="";
	var writer = "";
	var priority = "";
	var safetydegree = "";
	var folderid="";
	var signcontent="";
	var pageid="";
	var pagesize="";
	var sourceType="";
	var sourceCount="";
	var nodetime="";
	var alerttime =""
	var meettingroom ="";
	var meettingtime ="";
	var stampname="";
	var reason ="";
	this.toString=function(){
		return "subject="+this.subject+"&content="+this.content+"&requesttype="+this.requesttype+"&starttime="+this.starttime+"&endtime="+this.endtime+"&vto="+this.vto+"&cc="+this.cc+"&workflowid="+this.workflowid;
	}
	
		//创建公文
	this.create = function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		var pars = "";
		progressBar.SetStatus("正在校验数据....");
		if(this.vto.indexOf("部门") > -1)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "lbvto";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 收件人必须为用户！");
			return;
		}
			
		if(this.vto.length == 0)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "lbvto";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有选择接收公文的用户！");
			return;
		}
			
		if(this.workflowid=="402880cc186964c40118696b9b01002c"){
			//创建请假公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写请假事由！");
				return;
		     }
			 
			 if(checkform.Trim(this.requesttype) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "requesttype";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有选择请假类型！");
				return;
		     }
	          if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		     if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		
		}else if(this.workflowid=="402880cc186964c40118696b12a70029"){
			//创建加班公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写加班事由！");
				return;
		     }
			 
			 if(checkform.Trim(this.requesttype) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "requesttype";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有选择加班类型！");
				return;
		     }
		     if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		}else if(this.workflowid=="402880cc186964c40118696a67540026"){
			//创建出差公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写出差事由！");
				return;
		     }
		     if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		}else if(this.workflowid=="402880cc186964c40118696bf353002f"){
			//创建外出公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写外出事由！");
				return;
		     }
		     if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		}else if(this.workflowid=="ff8080811af8778b011af8925ba200c9"){
			//会议管理
			if(checkform.Trim(this.meettingroom) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写会议室！");
				return;
		     }
		     if(this.meettingtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 会议时间不可为空！");
				return;
		     }
		}else if(this.workflowid=="ff8080811af8778b011af892b90f00ca"){
			//公章管理
			if(checkform.Trim(this.stampname) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有选择公章！");
				return;
		     }
		     if(this.reason==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "reason";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 申请缘由不可为空！");
				return;
		     }
		      if(this.startdate==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 预计使用时间不可为空！");
				return;
		     }
	        if(this.enddate==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "enddate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 预计归还时间不可为空！");
				return;
		     }
		}
		else{
			//创建普通公文
			if(checkform.Trim(this.subject) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "subject";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写标题！");
				return;
		     }
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写内容！");
				return;
		     }
		}
		if(this.workflowid=="ff80818119ea4bb70119ea5005940015"){//创建资源申购公文
			if(checkform.Trim(this.sourceCount) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "sourceCount";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写申购数量！");
				return;
		     }
		}
		if(this.workflowid=="402880cc1884b55e011884b620a00011"){//创建工作汇报公文
			if(checkform.Trim(this.nodetime) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "nodetime";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写工作汇报时间！");
				return;
		     }
		}
		pars = "action=createArchieve&id="+this.id+"&workflowid=" + this.workflowid+"&vto=" + this.vto+"&cc=" + this.cc+"&att=" + this.att+"&content=" + this.content+"&filenum="+ this.filenum+"&phone=" + this.phone+"&priority="+this.priority+"&writer=" +this.writer+"&subject=" + this.subject + "&safetydegree=" + this.safetydegree+"&requesttype="+this.requesttype+"&productcount="+this.productcount+"&starttime="+this.starttime+"&endtime="+this.endtime+"&sourceType="+this.sourceType+"&sourceCount="+this.sourceCount+"&nodetime="+this.nodetime+"&alerttime="+this.alerttime+"&meettingroom="+this.meettingroom+"&meettingtime="+this.meettingtime+"&reason="+this.reason+"&stampname="+this.stampname;
		var url = '../archieveAction.do';
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: create_CallBack});
	}
	
	//删除公文
	this.del= function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		var url = '../archieveAction.do';
		var pars = 'action=archieveDelete&id='+this.id;
		var myAjax = new Ajax.Request(url,{method: 'post', parameters: pars, onComplete: del_CallBack});
	}
	
	//读取公文
	this.read = function(){
		var url = '../archieveAction.do';
		var pars = 'action=archieveShow&id='+this.id;
		var myAjax = new Ajax.Request(url,{method: 'post', parameters: pars, onComplete: read_CallBack});
	}

	//修改公文
	this.modify = function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		var url = '../archieveAction.do';
		pars = "action=archieveModify&workflowid=" + this.workflowid+"&vto=" + this.vto+"&cc=" + this.cc+"&att=" + this.att+"&content=" + this.content+"&filenum="+ this.filenum+"&phone=" + this.phone+"&priority='"+this.priority+"&writer=" +this.writer+"&subject=" + this.subject + "&safetydegree=" + this.safetydegree+"&requesttype="+this.requesttype+"&productcount="+this.productcount+"&starttime="+this.starttime+"&endtime="+this.endtime;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: modify_CallBack});
	}
	
	//取需要创建的模板
	this.getTemplate= function(){
		if(this.workflowid==""||this.workflowid=="-1"){
			alert("请选择相应模板");
		}else{
			progressBar = new ProgressBar();
			var checkform = new CheckForm();
			progressBar.SetStatus("正在校验数据....");
			var url = "../archieveAction.do";
			var pars = "action=getTemplate&workflowid="+this.workflowid;
			var myAjax = new Ajax.Request(url,{method: 'post', parameters: pars, onComplete: getTemplate_CallBack});
		}	
	}
	
	//保存草稿
	this.saveAsDraft=function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		if(this.vto.indexOf("部门") > -1)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "lbvto";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 收件人必须为用户！");
			return;
		}
			
		if(this.vto.length == 0)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "lbvto";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有选择接收公文的用户！");
			return;
		}
			
		if(this.workflowid=="402880cc186964c40118696b9b01002c"){
			//创建请假公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写请假事由！");
				return;
		     }
			 
			 if(checkform.Trim(this.requesttype) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "requesttype";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有选择请假类型！");
				return;
		     }
		     if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		}else if(this.workflowid=="402880cc186964c40118696b12a70029"){
			//创建加班公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写加班事由！");
				return;
		     }
			 
			 if(checkform.Trim(this.requesttype) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "requesttype";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有选择加班类型！");
				return;
		     }
		     if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		}else if(this.workflowid=="402880cc186964c40118696a67540026"){
			//创建出差公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写出差事由！");
				return;
		     }
		     if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		}else if(this.workflowid=="402880cc186964c40118696bf353002f"){
			//创建外出公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写外出事由！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		     if(this.starttime==""||this.endtime==""){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间和结束均不可为空！");
				return;
		     }
		       if(this.starttime>this.endtime){
		     	progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "startdate";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 起始时间不能晚于结束时间！");
				return;
		     }
		}else{
			//创建普通公文
			if(checkform.Trim(this.content) == "")
		    {
				progressBar.isNeedConfirmButton = true;
				progressBar.focusItem = "content";
				progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 没有填写内容！");
				return;
		     }
		     
		}
		var pars = "";
		pars = "action=saveAsDraft&id="+this.id+"&workflowid=" + this.workflowid+"&vto=" + this.vto+"&cc=" + this.cc+"&att=" + this.att+"&content=" + this.content+"&filenum="+ this.filenum+"&phone=" + this.phone+"&priority="+this.priority+"&writer=" +this.writer+"&subject=" + this.subject + "&safetydegree=" + this.safetydegree+"&requesttype="+this.requesttype+"&starttime="+this.starttime+"&endtime="+this.endtime;
		var url = '../archieveAction.do';
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: saveAsDraft_CallBack});
	}
	
	//读取草稿公文
	this.modifyDraft = function(){	
		var url = '../archieveAction.do';
		var pars = "action=modifyDraft&id="+this.id;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: modifyDraft_CallBack});
	}
	
	//读取公文列表
	this.getArchievesBySameFolderidAndWorkflowid=function(){
		var url = '../archieveAction.do';
		var pars = "action=getArchievesBySameFolderid&folderid="+this.folderid+"&workflowid="+this.workflowid;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: getArchievesBySameFolderidAndWorkflowid_CallBack});
	}
	
	//跳转至xx文件夹
	this.truntoFolderByFolderid = function(archievefolderid){
		var url = '../archieveAction.do';
		var pars = "action=truntoFolderByFolderid&folderid="+archievefolderid;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: truntoFolderByFolderid_CallBack});
	}
	
	//同意公文
	this.agree = function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		var url = '../archieveAction.do';
		var pars = "action=agreeArchieve&id="+this.id+"&signcontent="+this.signcontent+"&vto="+this.vto;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: agree_CallBack});
	}
	
	//驳回
	this.refuse=function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		var url = '../archieveAction.do';
		var pars = "action=refuseArchieve&id="+this.id+"&signcontent="+this.signcontent;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: refuse_CallBack});
	}
	
	//已经保存的草稿发送
	this.draftSend=function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		var url = '../archieveAction.do';
		var pars = "action=draftSend&id="+this.id;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: draftSend_CallBack});
	}
	
	//转办
	this.forward=function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		var url = '../archieveAction.do';
		var pars = "action=forwardArchieve&id="+this.id+"&signcontent="+this.signcontent+"&vto="+this.vto+"&att="+this.att;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: forward_CallBack});		
	}
	//搜索
	this.search=function(){
		progressBar = new ProgressBar();
		var checkform = new CheckForm();
		progressBar.SetStatus("正在校验数据....");
		if(this.subject.length == 0)
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "search_content";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 请填如公文标题或者关键字进行搜索！");
			return;
		}
		if(this.subject=="请输入标题或关键字进行查询...")
		{
			progressBar.isNeedConfirmButton = true;
			progressBar.focusItem = "search_content";
			progressBar.SetStatus("<img src='images/error.gif' align='absmiddle'> 请填如公文标题或者关键字进行搜索！");
			return;
		}
		var url = '../archieveAction.do';
		var pars = "action=search&titile="+this.subject+"&page="+this.pageid+"&pagesize="+this.pagesize;
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: search_CallBack});
	}
	
	this.viewsetting=function(){
		var url = "../archieve.do";
		var pars = "action=checkWorkTime";
		//alert(pars);
		var myAjax = new Ajax.Request(url,	{method: 'post', parameters: pars, onComplete: viewsetting_back});
	}
}