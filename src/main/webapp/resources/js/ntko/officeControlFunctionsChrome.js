var OFFICE_CONTROL_OBJ;//控件对象
var IsFileOpened;      //控件是否打开文档
var fileType ;
var fileTypeSimple;

function setFileNew(boolvalue)
{
  OFFICE_CONTROL_OBJ.FileNew=boolvalue;//是否允许新建
}
function setFileOpen(boolvalue)
{
  OFFICE_CONTROL_OBJ.FileOpen=boolvalue;//是否允许打开
}
function setFileClose(boolvalue)
{
  OFFICE_CONTROL_OBJ.FileClose=boolvalue;//是否允许关闭
}

function intializePage(fileUrl,type)
{
	//1:服务器   2:本地
	OFFICE_CONTROL_OBJ = document.all("TANGER_OCX");
	initCustomMenus();
	if (type == "1"){
    NTKO_OCX_OpenDoc(fileUrl);
	} else if (type == "2") {
    NTKO_OCX_OpenDoc_Local(fileUrl);
	}

}
function onPageClose()
{
	if(!OFFICE_CONTROL_OBJ.activeDocument.saved)
	{
		if(confirm( "文档修改过,还没有保存,是否需要保存?"))
		{
			saveFileToUrl();
		}
	}
}
function NTKO_OCX_OpenDoc(fileUrl)
{
  // OFFICE_CONTROL_OBJ.OpenLocalFile(fileUrl);
	OFFICE_CONTROL_OBJ.BeginOpenFromURL(fileUrl,true);
}

function NTKO_OCX_OpenDoc_Local(fileUrl)
{
  OFFICE_CONTROL_OBJ.OpenLocalFile(fileUrl);
}

function setFileOpenedOrClosed(bool)
{
	IsFileOpened = bool;
	fileType = OFFICE_CONTROL_OBJ.DocType ;
	// insertbookmark();
}
function trim(str)
{ //删除左右两端的空格
　　return str.replace(/(^\s*)|(\s*$)/g, "");
}
function saveFileToUrl(tzId,tmr,deptId,type)
{
	//type: 1、暂存  2、提交
  var myUrl =document.forms[0].action;

	var result;
	// console.log("IsFileOpened="+IsFileOpened);
	if(IsFileOpened)
	{
		result = OFFICE_CONTROL_OBJ.saveToURL(myUrl,//提交到的url地址
		"file",//文件域的id，类似<input type=file id=upLoadFile 中的id
		"tzId="+tzId+"&tmr="+tmr+"&deptId="+deptId+"&type="+type,
		0    //与控件一起提交的表单id，也可以是form的序列号，这里应该是0.
		);
    // document.all("statusBar").innerHTML="服务器返回信息:"+result;
    // result = $.parseJSON(result);
    // if (result.code == 0) {
    //   alert("保存成功！")
    //   $(window.parent.document.getElementById('LAY_app_tabsheader')).children(".layui-this").children(".layui-tab-close").trigger("click");
    // } else {
    //   alert("保存失败！");
    // }
		// alert(result);
		// history.back();
	}
}
function saveFileAsHtmlToUrl()
{
	var myUrl = "upLoadHtmlFile.jsp";
	var htmlFileName = document.all("fileName").value+".html";
	var result;
	if(IsFileOpened)
	{
		result=OFFICE_CONTROL_OBJ.PublishAsHTMLToURL("upLoadHtmlFile.jsp","uploadHtml","htmlFileName="+htmlFileName,htmlFileName);
		result=trim(result);
		document.all("statusBar").innerHTML="服务器返回信息:"+result;
		alert(result);
		window.close();
	}
}
function saveFileAsPdfToUrl()
{
	var myUrl = "upLoadPdfFile.jsp"	;
	var pdfFileName = document.all("fileName").value+".pdf";
	if(IsFileOpened)
	{
		OFFICE_CONTROL_OBJ.PublishAsPdfToURL(myUrl,"uploadPdf","PdfFileName="+pdfFileName,pdfFileName,"","",true,false);
	}
}
function testFunction()
{
	alert(IsFileOpened);
}
function addServerSecSign()
{
	var signUrl=document.all("secSignFileUrl").options[document.all("secSignFileUrl").selectedIndex].value;
	if(IsFileOpened)
	{
		if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2)
		{
			try
			{
			alert("正式版本用户请插入EKEY！\r\n\r\n此为电子印章系统演示功能，请购买正式版本！");
					OFFICE_CONTROL_OBJ.AddSecSignFromURL("ntko",signUrl);
			}
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}	
}
function addLocalSecSign()
{
	if(IsFileOpened)
	{
		if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2)
		{
			try
			{OFFICE_CONTROL_OBJ.AddSecSignFromLocal("ntko","");}
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}	
}
function addEkeySecSign()
{
	if(IsFileOpened)
	{
		if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2)
		{
			try
			{OFFICE_CONTROL_OBJ.AddSecSignFromEkey("ntko");}
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}
}
function addHandSecSign()
{
	if(IsFileOpened)
	{
		if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2)
		{
			try
			{OFFICE_CONTROL_OBJ.AddSecHandSign("ntko");}
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}
}

function addServerSign(signUrl)
{
	if(IsFileOpened)
	{
			try
			{
				OFFICE_CONTROL_OBJ.AddSignFromURL("ntko",//印章的用户名
				signUrl,//印章所在服务器相对url
				100,//左边距
				100,//上边距 根据Relative的设定选择不同参照对象
				"ntko",//调用DoCheckSign函数签名印章信息,用来验证印章的字符串
				3,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
				100,//缩放印章,默认100%
				1);   //0印章位于文字下方,1位于上方
				
			}
			catch(error){}
	}		
}

function addLocalSign()
{
	if(IsFileOpened)
	{
			try
			{
				OFFICE_CONTROL_OBJ.AddSignFromLocal("ntko",//印章的用户名
					"",//缺省文件名
					true,//是否提示选择
					100,//左边距
					100,//上边距 根据Relative的设定选择不同参照对象
					"ntko",//调用DoCheckSign函数签名印章信息,用来验证印章的字符串
					3,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
					100,//缩放印章,默认100%
					1);   //0印章位于文字下方,1位于上方
			}
			catch(error){}
	}
}
function addPicFromUrl(picURL)
{
	if(IsFileOpened)
	{
		if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2)
		{
			try
			{
				OFFICE_CONTROL_OBJ.AddPicFromURL(picURL,//图片的url地址可以时相对或者绝对地址
				false,//是否浮动,此参数设置为false时,top和left无效
				100,//left 左边距
				100,//top 上边距 根据Relative的设定选择不同参照对象
				1,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
				100,//缩放印章,默认100%
				1);   //0印章位于文字下方,1位于上方
				
			}
			catch(error){}
		}
		else
		{alert("不能在该类型文档中使用安全签名印章.");}
	}		
}
function addPicFromLocal()
{
	if(IsFileOpened)
	{
			try
			{
				OFFICE_CONTROL_OBJ.AddPicFromLocal("",//印章的用户名
					true,//缺省文件名
					false,//是否提示选择
					100,//左边距
					100,//上边距 根据Relative的设定选择不同参照对象
					1,  //Relative,取值1-4。设置左边距和上边距相对以下对象所在的位置 1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落
					100,//缩放印章,默认100%
					1);   //0印章位于文字下方,1位于上方
			}
			catch(error){}
	}
}

function insertRedHeadFromUrl(headFileURL)
{
	if(OFFICE_CONTROL_OBJ.doctype!=1)//OFFICE_CONTROL_OBJ.doctype=1为word文档
	{return;}
	OFFICE_CONTROL_OBJ.ActiveDocument.Application.Selection.HomeKey(6,0);//光标移动到文档开头
	OFFICE_CONTROL_OBJ.addtemplatefromurl(headFileURL);//在光标位置插入红头文档
}
function openTemplateFileFromUrl(templateUrl)
{
	OFFICE_CONTROL_OBJ.openFromUrl(templateUrl);
}
function doHandSign()
{
	/*if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2)//此处设置只允许在word和excel中盖章.doctype=1是"word"文档,doctype=2是"excel"文档
	{*/
		OFFICE_CONTROL_OBJ.DoHandSign2(
		"ntko",//手写签名用户名称
		"ntko",//signkey,DoCheckSign(检查印章函数)需要的验证密钥。
		0,//left
		0,//top
		1,//relative,设定签名位置的参照对象.0：表示按照屏幕位置插入，此时，Left,Top属性不起作用。1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落（为兼容以前版本默认方式）
		100);
	//}
}

//验证文档控件自带印章功能盖的章
function DoCheckSign()
{
   if(IsFileOpened)
   {	
			var ret = OFFICE_CONTROL_OBJ.DoCheckSign
			(
			false,/*可选参数 IsSilent 缺省为FAlSE，表示弹出验证对话框,否则，只是返回验证结果到返回值*/
			"ntko"//使用盖章时的signkey,这里为"ntko"
			);//返回值，验证结果字符串
			//alert(ret);
   }	
}
//设置工具栏
function setToolBar()
{
	OFFICE_CONTROL_OBJ.ToolBars=!OFFICE_CONTROL_OBJ.ToolBars;
}
//控制是否显示所有菜单
function setMenubar()
{
		OFFICE_CONTROL_OBJ.Menubar=!OFFICE_CONTROL_OBJ.Menubar;
}
//控制”插入“菜单栏
function setInsertMemu()
{
		OFFICE_CONTROL_OBJ.IsShowInsertMenu=!OFFICE_CONTROL_OBJ.IsShowInsertMenu;
	}
//控制”编辑“菜单栏
function setEditMenu()
{
		OFFICE_CONTROL_OBJ.IsShowEditMenu=!OFFICE_CONTROL_OBJ.IsShowEditMenu;
	}
//控制”工具“菜单栏
function setToolMenu()
{
	OFFICE_CONTROL_OBJ.IsShowToolMenu=!OFFICE_CONTROL_OBJ.IsShowToolMenu;
	}
	
//自定义菜单功能函数
function initCustomMenus()
{
	var myobj = OFFICE_CONTROL_OBJ;	
	
	//for(var menuPos=0;menuPos<3;menuPos++)
	//{
	//	myobj.AddCustomMenu2(menuPos,"菜单"+menuPos+"(&"+menuPos+")");
	//	for(var submenuPos=0;submenuPos<10;submenuPos++)
	//	{
	//		if(1 ==(submenuPos % 3)) //主菜单增加分隔符。第3个参数是-1是在主菜单增加
	//		{
	//			myobj.AddCustomMenuItem2(menuPos,submenuPos,-1,false,"-",true);
	//		}
	//		else if(0 == (submenuPos % 2)) //主菜单增加子菜单，第3个参数是-1是在主菜单增加
	//		{
	//			myobj.AddCustomMenuItem2(menuPos,submenuPos,-1,true,"子菜单"+menuPos+"-"+submenuPos,false);
	//			//增加子菜单项目
	//			for(var subsubmenuPos=0;subsubmenuPos<9;subsubmenuPos++)
	//			{
	//				if(0 == (subsubmenuPos % 2))//增加子菜单项目
	//				{
	//					myobj.AddCustomMenuItem2(menuPos,submenuPos,subsubmenuPos,false,
	//						"子菜单项目"+menuPos+"-"+submenuPos+"-"+subsubmenuPos,false,menuPos*100+submenuPos*20+subsubmenuPos);
	//				}
	//				else //增加子菜单分隔
	//				{
	//					myobj.AddCustomMenuItem2(menuPos,submenuPos,subsubmenuPos,false,
	//						"-"+subsubmenuPos,true);
	//				}
	//				//测试禁用和启用
	//				if(2 == (subsubmenuPos % 4))
	//				{
	//					myobj.EnableCustomMenuItem2(menuPos,submenuPos,subsubmenuPos,false);
	//				}
	//			}
	//		}
	//		else //主菜单增加项目，第3个参数是-1是在主菜单增加
	//		{
	//			myobj.AddCustomMenuItem2(menuPos,submenuPos,-1,false,"菜单项目"+menuPos+"-"+submenuPos,false,menuPos*100+submenuPos);
	//		}
	//
	//		//测试禁用和启用
	//		if(1 == (submenuPos % 4))
	//		{
	//			myobj.EnableCustomMenuItem2(menuPos,submenuPos,-1,false);
	//		}
	//	}
	//}
}
function insertbookmark() {
	var a = OFFICE_CONTROL_OBJ.activedocument.Bookmarks.count,
	b = "",
	c = "<table width='100%'>",
	d = "";
	var e="";
	var f="";
	for (i = 1; a >= i; i++) {
		d = OFFICE_CONTROL_OBJ.activedocument.Bookmarks.item(i).name;
		f = d.substring(0, d.length-1);
		if(e==f){
			b = OFFICE_CONTROL_OBJ.getbookmarkvalue(d);
			c += "<tr style='display:none;'><td width='15%'>" + e + "1" + "：</td><td><input type='text' class='form-control' placeholder='请输入书签内容' id='" + d + "' value='" + b + "'/></td></tr>";
		}else{
		 	var g=d.substring(d.length-1);
		 	if(/^\d+$/.test(g)){ 
		 		b = OFFICE_CONTROL_OBJ.getbookmarkvalue(d);
				c += "<tr><td width='15%'>" + f + "：</td><td><input type='text' class='form-control' placeholder='请输入书签内容' id='" + d + "' value='" + b + "'/></td></tr>";
		 	}else{
		 		b = OFFICE_CONTROL_OBJ.getbookmarkvalue(d);
				c += "<tr><td width='15%'>" + d + "：</td><td><input type='text' class='form-control' placeholder='请输入书签内容' id='" + d + "' value='" + b + "'/></td></tr>";
		 	}
		}
		e = d.substring(0, d.length-1);
	}
	$("#bookmarks").html(c + "</table>")
	$("#bookmarks").find("input[type='text']").change( function() {
		var bookmarkId = $(this).attr("id");
		var bookmarkValue = $(this).val();
		try {
			OFFICE_CONTROL_OBJ.SetBookmarkValue(bookmarkId, bookmarkValue);
			for(j=0;j<=9;j++){
				var book=bookmarkId.substring(0,bookmarkId.length-1);
				book=book+j;
				OFFICE_CONTROL_OBJ.SetBookmarkValue(book, bookmarkValue);
			}
		} catch(b) {
		}
	});
}