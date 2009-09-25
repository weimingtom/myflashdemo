package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	class Man extends Sprite{
		
		var _stage :Stage;
		private var _socket:Socket;
		
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
		
		
		
		public function Man(socket:Socket){
			
			init(socket);

		}
		
		private function init(socket:Socket):void{

			this._socket = socket;
			try {    
                this._socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler); 
            }   
            catch (error:Error){     
                this._socket.close();   
            }   
			stand(true);
			
			
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
			
			addChild(_goLeft);0
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
			trace(action);
          if(action==3){
           	  removeAllScript();
              goRight(false);
           }else if(action==7){
           	  removeAllScript();
           	  goLeft(false);
           }else{
           
           }
		}
	
		private function dataHandler(event:ProgressEvent):void {
           var action:String = read();
           if(action=="stand"){
           	  removeAllScript();
           	  stand(false);
           }else if(action=="goRight"){
           	  removeAllScript();
              goRight(false);
           }else if(action=="goLeft"){
           	  removeAllScript();
           	  goLeft(false);
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
        	var ba:ByteArray = new ByteArray();   
            //将得到的信息写入ba中   
            ba.writeMultiByte(str + "\n","UTF-8");     
            //通过连接写入socket中   
			this._socket.writeBytes(ba);
			this._socket.flush();
        }
		
		private function read():String{
			
			var bytes : ByteArray = new ByteArray () ;
			
			var msgLen: int = this._socket.bytesAvailable;
			
			this._socket.readBytes(bytes,0,msgLen);
			
			return bytes.toString();
		}




		public function getSocket():Socket
		{
			return _socket;
		}

		public function setSocket(v:Socket):void
		{
			_socket = v;
		}

		public function getX():int
		{
			return _x;
		}

		public function setX(v:int):void
		{
			_x = v;
		}

		public function getY():int
		{
			return _y;
		}

		public function setY(v:int):void
		{
			_y = v;
		}
			

        
        
	}
}