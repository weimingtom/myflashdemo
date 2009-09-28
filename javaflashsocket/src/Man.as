package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.net.XMLSocket;

	class Man extends Sprite{
		var _name:String = "name";
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
		var _init:Boolean=false;
//		var _hitHand : HitHand = new HitHand();//出拳
//		var _hitLeg : HitLeg = new HitLeg();//出腿
		
		
		
		public function Man(name:String,stage:Stage,socket:XMLSocket,booleanInit:Boolean){
			
			init(name,stage,socket,booleanInit);

		}
		
		private function init(name:String,stage:Stage,socket:XMLSocket,init:Boolean):void{
			this._name = name;
			this._stage = stage;
			this._init = init;
			this._socket = socket;
			try {    
				if(this._init){
					this._socket.connect("192.168.0.243",8821);
					this._socket.send("server:");
				}
				if(this._socket!=null){
	                this._socket.addEventListener(DataEvent.DATA, dataHandler); 
	                this._socket.addEventListener(Event.CONNECT, onConnect );
				}
            }   
            catch (error:Error){     
            	if(this._socket!=null){
              	  this._socket.close();   
             	}
            } 
              
			if(this._socket!=null){
		        stand(true);
			}else{
				stand(false);
			}
			
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



		function eventHandler(e:Event):void{
		//使用的时候这里加个判断就可以根据不同方向进行不同操作了
		var action:uint = KeyListener.getDirection();
          if(action==3){
           	  this.removeAllScript();
              this..goRight(false);
           }else if(action==7){
           	  this..removeAllScript();
           	  this..goLeft(false);
           }else{
           
           }
		}
	
		private function dataHandler(event:DataEvent):void {
           var str:String = event.data;
           trace(str);
           if(str.indexOf("server:")!=-1){
           		str = str.replace("server:","");
           		trace("替换后");
           		trace(str);
           		
           		var arr1:Array = new Array();
	           	arr1 = str.split("-");
	           	trace(arr1.toString());
	           	for each(var tmpStr:String in arr1){
	           		if(tmpStr==""||tmpStr==" "){
	           			break;
	           		}
						
					var tmpMan2 : Man = new Man(tmpStr,_stage,null,false);
					Bird.hashMap.put(tmpStr,tmpMan2);
					_stage.addChild(tmpMan2);
					
	           	
	           	}

	            
           
           }else{
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
           
           
           
        }   
        
        
        
        private function write(str:String):void{
//        	var ba:ByteArray = new ByteArray();   
//            //将得到的信息写入ba中   
//            ba.writeMultiByte(str,"UTF-8");     
            //通过连接写入socket中   
            if(this._socket!=null){
				this._socket.send(str);
            }
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
			
        
	}
}