package {
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.Socket;

	class Man extends Sprite{
		var socket:Socket;
		var serverURL:String = "localhost";
		var portNumber:int = 8821;		
		
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
		
		
		
//		private var actions:Array=new Array();
//　　　　 actions.push("stand"); 
//　　　　 actions.push("goRight"); 
//　　　　 actions.push("goLeft"); 
//　　　　 actions.push("hitHand");
//		actions.push("hitLeg");
//		actions.push("create");

		
		public function Man(){
			
			init();

		}
		
		private function init():void{

			
			socket = new Socket();
			try {    
                socket.connect(serverURL,portNumber); 
                socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);   
            }   
            catch (error:Error){     
                socket.close();   
            }   
			stand(true);
			
			
		}
		
		/**取消掉其他所有的动作*/
		public function removeAllScript(){
			_stand.visible = false;
			_goLeft.visible = false ;
			_goRight.visible = false ;
			

			_hitHand.visible = false;
			_hitLeg.visible = false ;
		}
		
		public function stand(self:Boolean){
			_stand.visible = true ;
			_stand.x = _x;
			_stand.y= _y;
			
			if(self){
				socket.writeUTF("stand");   
	            socket.flush();
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
				socket.writeUTF("goRight");   
	            socket.flush();
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
				socket.writeUTF("goLeft");   
	            socket.flush();
			}
			
			addChild(_goLeft);0
		}
		
		public function hitHand(self:Boolean){
			
			_hitHand.visible = true ;
			_hitHand.x = _x;
			_hitHand.y = _y;
			
			if(self){
				socket.writeUTF("hitHand");   
	            socket.flush();
			}
			
			addChild(_hitHand);
			
		}
		
		public function hitLeg(self:Boolean){
			
			_hitLeg.visible = true ;
			_hitLeg.x = _x;
			_hitLeg.y = _y;
			
			if(self){
				socket.writeUTF("hitLeg");   
	            socket.flush();
			}
			
			addChild(_hitLeg);
			
		}
		
		/**键盘事件处理*/
		public function eventListen(en:KeyboardEvent){
			if(en.keyCode == _right){
				removeAllScript();
				goRight(true);
			}
			
			if(en.keyCode == _left){
				removeAllScript();
				goLeft(true);
			}
			
			if(en.keyCode == _hitHandCode){
				removeAllScript();
				hitHand(true);
			}
			
			if(en.keyCode == _hitLegCode){
				removeAllScript();
				hitLeg(true);
			}
			
		}
		
		/**键盘松掉事件处理*/
		public function eventUpListen(en:KeyboardEvent){
			removeAllScript();
			stand(true);
		}

		private function dataHandler(event:ProgressEvent):void {   
           var action:String = socket.readUTF();
           trace(action);
           if(action=="stand"){
           	  removeAllScript();
           	  stand(false);
           }else if(action=="goRight"){
           	  removeAllScript();
              goRight(false);
           }else if(action=="goLeft"){
           	  removeAllScript();
           	  goLeft(false);
           }else if(action=="hitHand"){
           	  removeAllScript();
           	  hitHand(false);
           }else if(action=="hitLeg"){
           	  removeAllScript();
           	  hitLeg(false);
           }else{
           
           }
           
           
        }   
		
	}
}