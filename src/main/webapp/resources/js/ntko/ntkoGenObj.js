// document.write('<object id="TANGER_OCX" '
//     + 'classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" '
//     + 'codebase="${ctxPath}/resources/OfficeControl.cab#version=4,0,0,6" width="100%" height="100%">');
// document.write('<param name="Toolbars" value="-1">');
// document.write('<param name="BorderStyle" value="1">');
// document.write('<param name="Titlebar" value="0">');
// document.write('<param name="Menubar" value="-1">');
// document.write('<span style="color:red">不能装载NTKO OFFICE文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</span>');
// document.write('</object>');

//请勿修改，否则可能出错
var userAgent = navigator.userAgent,
    rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
    rFirefox = /(firefox)\/([\w.]+)/,
    rOpera = /(opera).+version\/([\w.]+)/,
    rChrome = /(chrome)\/([\w.]+)/,
    rSafari = /version\/([\w.]+).*(safari)/;
var browser;
var version;
var ua = userAgent.toLowerCase();
console.log("ua="+ua);
function uaMatch(ua) {
  var match = rMsie.exec(ua);
  if (match != null) {
    return { browser : "IE", version : match[2] || "0" };
  }
  var match = rFirefox.exec(ua);
  if (match != null) {
    return { browser : match[1] || "", version : match[2] || "0" };
  }
  var match = rOpera.exec(ua);
  if (match != null) {
    return { browser : match[1] || "", version : match[2] || "0" };
  }
  var match = rChrome.exec(ua);
  if (match != null) {
    return { browser : match[1] || "", version : match[2] || "0" };
  }
  var match = rSafari.exec(ua);
  if (match != null) {
    return { browser : match[2] || "", version : match[1] || "0" };
  }
  if (match != null) {
    return { browser : "", version : "0" };
  }
}
var browserMatch = uaMatch(userAgent.toLowerCase());
if (browserMatch.browser) {
  browser = browserMatch.browser;
  version = browserMatch.version;
  console.log(browser);
  console.log(version);
}

if (browser=="IE"){
// if (true){
  document.write('<!-- 用来产生编辑状态的ActiveX控件的JS脚本-->   ');
  document.write('<!-- 因为微软的ActiveX新机制，需要一个外部引入的js-->   ');
  // document.write('<object id="TANGER_OCX" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404"');
  // document.write('codebase="${ctxPath}/resources/OfficeControl.cab#version=4,0,0,6" width="100%" height="100%">');
  // document.write('<object id="TANGER_OCX" classid="clsid:A39F1330-3322-4a1d-9BF0-0BA2BB90E970"');
  // document.write('<object id="TANGER_OCX" classid="clsid:A39F1330-3322-4a1d-9BF0-0BA2BB90E970"');
  // document.write('codebase="http://www.ntko.com/control/officecontrol/OfficeControl.cab#version=5,0,3,1" width="100%" height="100%">');
  document.write('<object id="TANGER_OCX" classid="clsid:A64E3073-2016-4baf-A89D-FFE1FAA10EC0"');
  document.write('codebase="'+ ctxPath +'/resources/OfficeControl.cab#version=5,0,4,0" width="100%" height="100%">');
  document.write('<param name="ProductCaption" value="江阴市水利局">');
  document.write('<param name="ProductKey" value="7C159058552F836EE3FE8EFE474D58E1C191A2CE">');
  document.write('<param name="Toolbars" value="-1">');
  document.write('<param name="IsUseUTF8URL" value="-1">   ');
  document.write('<param name="IsUseUTF8Data" value="-1">   ');
  document.write('<param name="BorderStyle" value="1">   ');
  document.write('<param name="BorderColor" value="14402205">   ');
  document.write('<param name="TitlebarColor" value="15658734">   ');
  document.write('<param name="isoptforopenspeed" value="0">   ');
  document.write('<param name="TitlebarTextColor" value="0">   ');
  document.write('<param name="MenubarColor" value="14402205">   ');
  document.write('<param name="MenuButtonColor" VALUE="16180947">   ');
  document.write('<param name="MenuBarStyle" value="3">   ');
  document.write('<param name="MenuButtonStyle" value="7">   ');
  document.write('<param name="WebUserName" value="NTKO">   ');
  document.write('<param name="Caption" value="白屈港水利工程运行管理系统">   ');
  document.write('<SPAN STYLE="color:red">尚未安装NTKO插件。请点击<a href="'+ ctxPath +'/resources/ntko.exe">安装组件</a></SPAN>   ');
  document.write('</object>');
}else if(browser=="chrome"){
  alert("sorry,ntko web印章暂时不支持chrome!");}
else if (Sys.opera){
  alert("sorry,ntko web印章暂时不支持opera!");
}else if (Sys.safari){
  alert("sorry,ntko web印章暂时不支持safari!");
}else{
  alert("sorry,ntko web印章暂时不支持该浏览器!");
}