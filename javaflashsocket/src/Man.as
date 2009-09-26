package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.net.XMLSocket;
	import flash.utils.ByteArray;

	class Man extends Sprite{
		var _url:String = "192.168.0.243";
		var _stage :Stage;
		private var _socket:XMLSocket;
		
		var _speed = 4;
		private var _x : int= 30 ;//初始x坐标
		private var _y : int = 250;//初始y坐标
		
		var _maxX:int = 550 - 80 ;
		var _minX:int = 30 ;
		
		var _left:int = 37;//左
		var _up:int = 38;//上
		var _right:int = 39;//右
		var _down:int = 40;//下
		var _hitHandCode:int = 96;//出拳
		var _hitLegCode:int = 110;//出腿
		
		var _stand : Stand = new Stand();;//站立状态
		var _goRight : GoRight = new GoRight();;//向右走
		var _goLeft : GoLeft = new GoLeft();//左走
		
//		var _hitHand : HitHand = new HitHand();//出拳
//		var _hitLeg : HitLeg = new HitLeg();//出腿
		
		
		
		public function Man(socket:XMLSocket){
			
			init(socket);

		}
		
		private function init(socket:XMLSocket):void{

			this._socket = socket;
			try {    
                this._socket.addEventListener(DataEvent.DATA, dataHandler); 
                this._socket.addEventListener(Event.CONNECT, onConnect );
            }   
            catch (error:Error){     
                this._socket.close();   
            }   
			stand(true);
			
			
		}
		
		public function onConnect(e:Event){
			trace("链接ok!");		
		}
		
		/**取消掉其他所有的动作*/
		public function removeAllScript(){
			_stand.visible = false;
			_goLeft.visible = false ;
			_goRight.visible = false ;
			

//			_hitHand.visible = false;
//			_hitLeg.visible = false ;
		}
		
		public function stand(self:Boolean){
			
			_stand.visible = true ;
			_stand.x = _x;
			_stand.y= _y;
			
			if(self){
				write("stand");   
			}
			addChild(_stand);
			
			
		}
		
		public function goRight(self:Boolean){
			if( (_x + _speed )<  _maxX ){
				_x = _x + _speed;
			}
			
			_goRight.visible = true ;
			_goRight.x = _x;
			_goRight.y = _y;
			
			if(self){
				write("goRight"); 
			}
			
			addChild(_goRight);
			
		}
		
		public function goLeft(self:Boolean){
			
			if( (_x - _speed )>  _minX ){
				_x = _x - _speed;
			}
			
			_goLeft.visible = true ;
			_goLeft.x = _x;
			_goLeft.y = _y;
			
			if(self){
				write("goLeft");   
			}
			
			addChild(_goLeft);
		}
		
//		public function hitHand(self:Boolean){
//			
//			_hitHand.visible = true ;
//			_hitHand.x = _x;
//			_hitHand.y = _y;
//			
//			if(self){
//				write("hitHand");   
//			}
//			
//			addChild(_hitHand);
//			
//		}
//		
//		public function hitLeg(self:Boolean){
//			
//			_hitLeg.visible = true ;
//			_hitLeg.x = _x;
//			_hitLeg.y = _y;
//			
//			if(self){
//				write("hitLeg");   
//			}
//			
//			addChild(_hitLeg);
//			
//		}
//		
//		/**键盘事件处理*/
//		public function eventListen(en:KeyboardEvent){
//			if(en.keyCode == _right){
//				removeAllScript();
//				goRight(true);
//			}
//			
//			if(en.keyCode == _left){
//				removeAllScript();
//				goLeft(true);
//			}
//			
//			if(en.keyCode == _hitHandCode){
//				removeAllScript();
//				hitHand(true);
//			}
//			
//			if(en.keyCode == _hitLegCode){
//				removeAllScript();
//				hitLeg(true);
//			}
//			
//		}
//		
//		/**键盘松掉事件处理*/
//		public function eventUpListen(en:KeyboardEvent){
//			removeAllScript();
//			stand(true);
//		}



		function eventHandler(e:Event):void{
		//使用的时候这里加个判断就可以根据不同方向进行不同操作了
		var action:uint = KeyListener.getDirection();
          if(action==3){
           	  Man(Bird.hashMap.get(_url)).removeAllScript();
              Man(Bird.hashMap.get(_url)).goRight(true);
           }else if(action==7){
           	  Man(Bird.hashMap.get(_url)).removeAllScript();
           	  Man(Bird.hashMap.get(_url)).goLeft(true);
           }else{
           
           }
		}
	
		private function dataHandler(event:DataEvent):void {
           trace(event.data);
           var str:String = event.toString();
           var arr:Array = new Array();
           arr = str.split("-");
           var addr:String = arr[0];
           var action:String = arr[1];
           
           var tmpMan :Man =Man(Bird.hashMap.get(addr));
           
           if(action=="stand"){
           	  tmpMan.removeAllScript();
           	  tmpMan.stand(false);
           }else if(action=="goRight"){
           	  tmpMan.removeAllScript();
              tmpMan.goRight(false);
           }else if(action=="goLeft"){
           	  tmpMan.removeAllScript();
           	  tmpMan.goLeft(false);
//           }else if(action=="hitHand"){
//           	  removeAllScript();
//           	  hitHand(false);
//           }else if(action=="hitLeg"){
//           	  removeAllScript();
//           	  hitLeg(false);
           }else{
           
           }
           
           
        }   
        
        
        
        private function write(str:String):void{
//        	var ba:ByteArray = new ByteArray();   
//            //将得到的信息写入ba中   
//            ba.writeMultiByte(str,"UTF-8");     
            //通过连接写入socket中   
			this._socket.send(str);
//			this._socket.writeBytes(ba);
//			this._socket.flush();
        }
		
//		private function read():String{
//			
//			var bytes : ByteArray = new ByteArray () ;
//			
//			var msgLen: int = this._socket.bytesAvailable;
//			
//			this._socket.readBytes(bytes,0,msgLen);
//			
//			return bytes.toString();
//		}




		public function getSocket():XMLSocket
		{
			return this._socket;
		}

		public function setSocket(v:XMLSocket):void
		{
			this._socket = v;
		}

		public function getX():int
		{
			return this._x;
		}

		public function setX(v:int):void
		{
			this._x = v;
		}

		public function getY():int
		{
			return this._y;
		}

		public function setY(v:int):void
		{
			this._y = v;
		}
			
			
			
			
			
			
//			
//			
//function funSocket(event:ProgressEvent):void
//		{
//			var msg:String="";
//			var pd:String=""; //协议判断字符
//			var intCD:int=0;
//			var j:int=0;
//			var arrList:Array;
//			var arrListxy:Array;
//			var loginname:String="";
//			var ux:int=0;
//			var uy:int=0;
//			while(socket.bytesAvailable)
//			{
//				
//				msg=socket.readMultiByte(socket.bytesAvailable,"utf8");
//				pd=msg.substring(0,2);
//				trace(msg);
//				intCD=msg.length;//获取字符串长度			
//				if(pd=="11")
//				{   j=msg.indexOf('44',0);
//					if (j>0)
//					{
//					 pd=msg.substring(j+2,intCD);
//					// labCount.text=pd;
//					 msg=msg.substring(0,j);					 	
//					}					
//					msg=msg.substring(4,intCD);
//					var myPattern2:RegExp=/\r\n/;//清除回车和换行符
//					/ ar myPattern3:RegExp=/\n/;
//					msg=msg.replace(myPattern2,'');
//					//msg=msg.replace(myPattern3,'');
//					arrList=msg.split("--");
//					//arrList.unshift("所有人");
//					//arrList.unshift(myName);
//				   // trace(arrList);	
//					if (arrList.length>0) {						
//					for(j=0;j<arrList.length;j++)
//					{
//					  loginname	=arrList[j].toString();
//					  arrListxy =loginname.split(",");
//					  loginname =arrListxy[0].toString();
//					  ux=int(arrListxy[1].toString());
//					  uy=int(arrListxy[2].toString());
//					  trace("login:"+loginname);	
//					  if (myName!=loginname)
//					  {		
//						//tracemc.text+=loginname+"登录 \n";
//						addmessage(loginname+"登录");	
//						trace(tracemc.text); 	
//					  if (userSet.propertyIsEnumerable(loginname)==false)		
//					  {
//					  var Qrole:Player;	
//				      Qrole = new Player("roles/38x88.png", 62, 103, 38, 88, 6);
// 				      Qrole.place(ux,uy);
//				      Qrole.playerName=loginname;	
//				      scene.addContain(Qrole);
//				      userSet[loginname]=Qrole;
//				      }
//				     }
//				  }
//				 }
//					
//				}else if(pd=="22")
//				{
//					msg=msg.substring(2,intCD);
//					var arr:Array=msg.split('\n');
//					for(var i:int=0;i<arr.length;i++)
//					{
//						if(arr[i].length>1)
//						{
//							var myPattern:RegExp=/\r/;
//							arr[i]=arr[i].replace(myPattern,'');
//							//tracemc.text+=arr[i];
//							addmessage(arr[i]);
//						//	myText.text+=arr[i]+"\n";
//						}
//					}
//					//myText.verticalScrollPosition = myText.maxVerticalScrollPosition;//滚动到最下面
//				}else if(pd=="33")
//				{
//				}
//				else if(pd=="44")
//				{
//					msg=msg.substring(2,intCD);
//					//labCount.text=msg;
//				}
//				else if(pd=="55")
//				{
//				 msg=msg.substring(2,intCD);
//				 arrList=msg.split("--");
//				 msg=arrList[0].toString();
//				 //tracemc.text+=arrList[0].toString()+" Move "+arrList[1].toString()+","+arrList[2].toString()+" \n";
//				 addmessage(arrList[0].toString()+" Move "+arrList[1].toString()+","+arrList[2].toString());
//				 trace(tracemc.text);
//				 //if (userSet.propertyIsEnumerable(msg)==true)
//				 rolemove(Player(userSet[msg]),int(arrList[1].toString()),int(arrList[2].toString()));	
//				}
//                else if(pd=="66")
//                {
//                  msg=msg.substring(2,intCD);                  
//                  if (userSet.propertyIsEnumerable(msg)==true)
//                  {
//                   var temrole:Player=Player(userSet[msg].valueOf());	
//                   scene.removeFront(temrole); //这个报错 没有解决
//                   userSet[msg]=null;
//                   delete userSet[msg];
//                  }
//                  addmessage(msg+"退出");
//                  //tracemc.text+=msg+"退出 \n"; 
//                }
//			}
//				
//		}	 

        
        
	}
}