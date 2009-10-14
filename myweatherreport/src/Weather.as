package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class Weather extends Sprite
	{
		
		var loader:URLLoader = new URLLoader();
		var variables:URLVariables = new URLVariables();
		var request:URLRequest = new URLRequest("http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather");
		
		var xml:XML;
		
		var title:TextField =new TextField();
		var firstDay:TextField =new TextField();
		var secondDay:TextField =new TextField(); 
		var thirdDay:TextField =new TextField();
		
		
		public function Weather()
		{
			bnt.addEventListener(MouseEvent.CLICK,function (e:Event){
				
				init();
			
			});
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,function (e:KeyboardEvent){
				if(e.keyCode==13){
					init();
				}
			
			});
		}
		
		private function init(){
			//
			// 配置 URLVariables, 设置传递到服务器的数据
			//
				
			variables.theCityCode = city.text;
			if(variables.theCityCode==""){
				variables.theCityCode = "北京";
			}
			variables.theUserID = "700eb4c54b7a461c8563bf5744d0f440";
			//
			// 配置 URLRequest, 设置目标路径, 设置提交的数据, 方法 (POST / GET)
			//
			
			request.data = variables;
			request.method = URLRequestMethod.POST;
			//
			// 配置 URLLoader, 注册侦听器等
			//
			
			//
			// 服务端将要返回的是纯文本数据
			//
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, loader_complete);
			loader.addEventListener(Event.OPEN, loader_open);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, loader_httpStatus);
			loader.addEventListener(ProgressEvent.PROGRESS, loader_progress);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_security);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioError);
			loader.load(request);
		
		}
		
		function show(){
			var childs:XMLList = xml.children();
			
//			cityName=childs[1].text();
//			weather=childs[2].text();
//			temperature=childs[3].text();
//			wind=childs[4].text();
//			dateName=childs[5].text();
//			weaPic=childs[6].text();
			
			
			var initX:int = 10 ;
			var initY:int = 20 ;
			var distance:int = 15;
			
			
			var len:uint = bg.numChildren;
			while(len!=1) {
			        bg.removeChildAt(1);
			        len--;
			}
			
			
		
			title.x = initX;
			title.y = initY;
			title.text = childs[0].text();
			title.textColor = 0xFF0000;
			title.width = 150 ; 
			title.height = 50 ; 
			title.thickness = 50 ;
			title.autoSize = TextFieldAutoSize.CENTER ;
			bg.addChild(title);
			initY = initY + distance +title.height;
			
			firstDay.x = initX;
			firstDay.y = initY;
			firstDay.text = childs[7].text()+childs[8].text()+ childs[9].text();
			firstDay.width = 150 ; 
			firstDay.height = 50 ; 
			firstDay.wordWrap = true;
//			firstDay.multiline = true;
			bg.addChild(firstDay);
				
			initY = initY + distance +firstDay.height;
			
			secondDay.x = initX;
			secondDay.y = initY;
			secondDay.text = childs[12].text()+childs[13].text()+ childs[14].text();
			secondDay.width = 150 ; 
			secondDay.height = 50 ; 
			secondDay.wordWrap = true;
//			firstDay.multiline = true;
			bg.addChild(secondDay);
				
			initY = initY + distance + secondDay.height;
			
			thirdDay.x = initX;
			thirdDay.y = initY;
			thirdDay.text = childs[17].text()+childs[18].text()+ childs[19].text();
			thirdDay.width = 150 ; 
			thirdDay.height = 50 ; 
			thirdDay.wordWrap = true;
//			firstDay.multiline = true;
			bg.addChild(thirdDay);
				
			initY = initY + distance + thirdDay.height;
			
			
		}
		
		
		function loader_complete (e:Event):void {
			var str:String = loader.data;
			
			
//			str = StringUtil.utf16to8(str);
//			str = StringUtil.trim(str);
//			trace(str);
			
			xml = new XML(str);
			
			//trace(xml.toString());
//			var str1=xml.toString()
//			var arr=str1.split("<?xml version=\"1.0\" encoding=\"utf-16\"?>")
//			
//			xml=new XML(arr[1])
			show();
		}
		
		
		function loader_open (e:Event):void {
//			trace("Event.OPEN");
//			trace("读取了的字节 : " + loader.bytesLoaded);
		}
		function loader_httpStatus (e:HTTPStatusEvent):void {
//			trace("HTTPStatusEvent.HTTP_STATUS");
//			trace("HTTP 状态代码 : " + e.status);
		}
		function loader_progress (e:ProgressEvent):void {
//			trace("ProgressEvent.PROGRESS");
//			trace("读取了的字节 : " + loader.bytesLoaded);
//			trace("文件总字节 : " + loader.bytesTotal);
		}
		function loader_security (e:SecurityErrorEvent):void {
//			trace("SecurityErrorEvent.SECURITY_ERROR");
		}
		function loader_ioError (e:IOErrorEvent):void {
//			trace("IOErrorEvent.IO_ERROR");
		}
		
	}
}



