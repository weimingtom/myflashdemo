package {
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.Socket;

	class Man extends Sprite{
		private var socket:Socket = new Socket();
		var serverURL:String = "localhost";
		var portNumber:int = 4567;		
		
		var _speed = 15;
		var _x : int= 30 ;//初始x坐标
		var _y : int = 250;//初始y坐标
		
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
		//var _hit : Hit = new Hit();//打
		var _hitHand : HitHand = new HitHand();//出拳
		var _hitLeg : HitLeg = new HitLeg();//出腿
		public function Man(){
			
			stand();
			
			this.socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);   
			try {    
                this.socket.connect(serverURL,portNumber);   
            }   
            catch (error:Error){     
                this.socket.close();   
            }   

		}
		
		
		/**取消掉其他所有的动作*/
		public function removeAllScript(){
			_stand.visible = false;
			_goLeft.visible = false ;
			_goRight.visible = false ;
			

			_hitHand.visible = false;
			_hitLeg.visible = false ;
		}
		
		public function stand(){
			_stand.visible = true ;
			_stand.x = _x;
			_stand.y= _y;
			
			this.socket.writeUTF("stand");   
            this.socket.flush();
			
			addChild(_stand);
			
			
		}
		
		public function goRight(){

			if( (_x + _speed )<  _maxX ){
				_x = _x + _speed;
			}
			
			_goRight.visible = true ;
			_goRight.x = _x;
			_goRight.y = _y;
			
			this.socket.writeUTF("goRight");   
            this.socket.flush();
			
			addChild(_goRight);
			
		}
		
		public function goLeft(){
			
			if( (_x - _speed )>  _minX ){
				_x = _x - _speed;
			}
			
			_goLeft.visible = true ;
			_goLeft.x = _x;
			_goLeft.y = _y;
			
			this.socket.writeUTF("goLeft");   
            this.socket.flush();
			
			addChild(_goLeft);0
		}
		
		public function hitHand(){
			
			_hitHand.visible = true ;
			_hitHand.x = _x;
			_hitHand.y = _y;
			
			this.socket.writeUTF("hitHand");   
            this.socket.flush();
			
			addChild(_hitHand);
			
		}
		
		public function hitLeg(){
			
			_hitLeg.visible = true ;
			_hitLeg.x = _x;
			_hitLeg.y = _y;
			
			this.socket.writeUTF("hitLeg");   
            this.socket.flush();
			
			addChild(_hitLeg);
			
		}
		
		/**键盘事件处理*/
		public function eventListen(en:KeyboardEvent){
			trace(en.keyCode);
			if(en.keyCode == _right){
				removeAllScript();
				goRight();
			}
			
			if(en.keyCode == _left){
				removeAllScript();
				goLeft();
			}
			
			if(en.keyCode == _hitHandCode){
				removeAllScript();
				hitHand();
			}
			
			if(en.keyCode == _hitLegCode){
				removeAllScript();
				hitLeg();
			}
			
		}
		
		/**键盘松掉事件处理*/
		public function eventUpListen(en:KeyboardEvent){
			removeAllScript();
			stand();
		}

		private function dataHandler(event:ProgressEvent):void {   
           trace(this.socket.readUTF());
        }   
		
	}
}