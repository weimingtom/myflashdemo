

package rpg
{
	import findpath.PathFinding;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Player extends Sprite{
		
		private var _name:String;
		
		private var _width:int;
		private var _height:int;
		
		private var _speed:int = 6; 
		
		private var _angle:Number;
		
		private var _aimX:int;
		private var _aimY:int;
		
		private var _aimMouseX:int;
		private var _aimMouseY:int;
		
		private var _stand:Sprite;
		private var _goLeft:Sprite;
		private var _goRight:Sprite;
		private var _goGoUp:Sprite;
		private var _goGoDown:Sprite;
		private var _goGoUpLeft:Sprite;
		private var _goGoUpRight:Sprite;
		private var _goGoDownLeft:Sprite;
		private var _goGoDownRight:Sprite;
		
		private var _path:Array;
		private var _map:Array;
		
		var endPoint:Point;
		var __thisPoint:Point;
		
		var _xSpeed:Number;
		var _ySpeed:Number;
		public function Player(){

			init();
			stand();

		}
		
		private function init(){
			
			_stand = new Stand();
			_goLeft = new GoLeft();
			_goRight = new GoRight();
			_goGoUp = new GoUp();
			_goGoDown = new GoDown();
			_goGoUpLeft = new GoUpLeft();
			_goGoUpRight = new GoUpRight();
			_goGoDownLeft = new GoDownLeft();
			_goGoDownRight = new GoDownRight();
			
			addChild(_stand);
			addChild(_goLeft);
			addChild(_goRight);
			addChild(_goGoUp);
			addChild(_goGoDown);
			addChild(_goGoUpLeft);
			addChild(_goGoUpRight);
			addChild(_goGoDownLeft);
			addChild(_goGoDownRight);
			
//			addEventListener(PlayerEvent.MOVE,moveInPath);
			
		}
		
		private function cancelAllStatus(){
			_stand.visible = false;
			_goLeft.visible = false;
			_goRight.visible = false;
			_goGoUp.visible = false;
			_goGoDown.visible = false;
			_goGoUpLeft.visible = false;
			_goGoUpRight.visible = false;
			_goGoDownLeft.visible = false;
			_goGoDownRight.visible = false;
		}
		
		private function stand(){
			_stand.x=0;
			_stand.y=0;
			cancelAllStatus();
			_stand.visible = true;
		}
		private function goUp(e:Event){
			var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goUp);
				stand();
				return;
			}
			
			cancelAllStatus();
			_goGoUp.visible = true;
			
			
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			
			_goGoUp.x=0;
			_goGoUp.y=0;
		}
		private function goUpLeft(e:Event){
						var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goUpLeft);
				stand();
				return;
			}
			
			cancelAllStatus();
			_goGoUpLeft.visible = true;
			
			
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			
			_goGoUpLeft.x=0;
			_goGoUpLeft.y=0;
			
		}
		private function goUpRight(e:Event){
									var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goUpRight);
				stand();
				return;
			}
			
			cancelAllStatus();
			_goGoUpRight.visible = true;
			
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			_goGoUpRight.x=0;
			_goGoUpRight.y=0;
		}
		private function goDown(e:Event){
									var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goDown);
				stand();
				return;
			}
			
			cancelAllStatus();
			_goGoDown.visible = true;
			
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			_goGoDown.x=0;
			_goGoDown.y=0;
		}
		private function goDownLeft(e:Event){
									var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goDownLeft);
				stand();
				return;
			}
			
			cancelAllStatus();
			_goGoDownLeft.visible = true;
			
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			_goGoDownLeft.x=0;
			_goGoDownLeft.y=0;
		}
		private function goDownRight(e:Event){
			
									var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goDownRight);
				stand();
				return;
			}
			
			cancelAllStatus();
			_goGoDownRight.visible = true;
			
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			_goGoDownRight.x=0;
			_goGoDownRight.y=0;
		}
		private function goLeft(e:Event){
			
									var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goLeft);
				stand();
				return;
			}
			
			cancelAllStatus();
			_goLeft.visible = true;
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			_goLeft.x=0;
			_goLeft.y=0;
		}
		private function goRight(e:Event){
			var __dx:Number = _aimMouseX-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimMouseY-y;
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimMouseX;
				y = _aimMouseY;
				removeEventListener(Event.ENTER_FRAME, goRight);
				stand();
				return;
			}
			
			
			cancelAllStatus();
			_goRight.visible = true;	
			this.x+=_xSpeed;
			this.y+=_ySpeed;
			_goRight.x=0;
			_goRight.y=0;
		}
		
		
		
		
		public function moveInPath():void{
				_aimMouseX = _aimX;
				_aimMouseY = _aimY;
				
			
			endPoint = new Point(Math.floor((_aimX+8)/8)-1,Math.floor((_aimY+8)/8)-1);
			
			if(_map == null){
				trace("地图未设置");
				return;
			}
			
			
			/*先取得路径*/
			var __pf: PathFinding = new PathFinding(_map,false);
			
			
			 __thisPoint = new Point(Math.floor((x+8)/8)-1,Math.floor((y+8)/8)-1);
			
			
			__pf.path8(__thisPoint,endPoint);
			
			
			_path = __pf.optimizePath();
			
			trace(_path);
			
			for(var i:int =0 ; i<_path.length-1; i++){
				_aimX = _path[i].x*8;
				_aimY = _path[i].y*8;
				go();
			}
			
			
		}
		
		private function go(){
			
			_angle = Math.atan2(endPoint.y*8 - __thisPoint.y*8, endPoint.x*8 - __thisPoint.x*8);
			trace(_angle);
			_xSpeed = _speed*Math.cos(_angle);//x上的分速度
			_ySpeed = _speed*Math.sin(_angle);//y上的分速度
			if(_angle<=Math.PI/8 && _angle > -Math.PI*1/8){
				addEventListener(Event.ENTER_FRAME,goRight);
			}else if(_angle<= - Math.PI*1/8 && _angle >- Math.PI*3/8){
				addEventListener(Event.ENTER_FRAME,goUpRight);
			}else if(_angle<=-Math.PI*3/8 && _angle > -Math.PI*5/8){
				addEventListener(Event.ENTER_FRAME,goUp);
			}else if(_angle<=-Math.PI*5/8 && _angle > -Math.PI*7/8){
				addEventListener(Event.ENTER_FRAME,goUpLeft);
			}else if((_angle<=Math.PI&& _angle > Math.PI*7/8 ) || ( _angle>=-Math.PI&& _angle  < -  Math.PI*7/8 )){
				addEventListener(Event.ENTER_FRAME,goLeft);
			}else if(_angle<=Math.PI*7/8 && _angle > Math.PI*5/8){
				addEventListener(Event.ENTER_FRAME,goDownLeft);
			}else if(_angle<=Math.PI*5/8 && _angle > Math.PI*3/8){
				addEventListener(Event.ENTER_FRAME,goDown);
			}else if(_angle<=Math.PI*3/8 && _angle > Math.PI*1/8){
				addEventListener(Event.ENTER_FRAME,goDownRight);
			}else{
						
			}
			


//			removeEventListener(Event.ENTER_FRAME,goRight);
//			removeEventListener(Event.ENTER_FRAME,goUpRight);
//			removeEventListener(Event.ENTER_FRAME,goUp);
//			removeEventListener(Event.ENTER_FRAME,goUpLeft);
//			removeEventListener(Event.ENTER_FRAME,goLeft);
//			removeEventListener(Event.ENTER_FRAME,goDownLeft);
//			removeEventListener(Event.ENTER_FRAME,goDown);
//			removeEventListener(Event.ENTER_FRAME,goDownRight);
			
		}

		public function getWidth()
		{
			return _width;
		}

		public function setWidth(v:Number):void
		{
			_width = v;
		}

		public function getHeight():Number
		{
			return _height;
		}

		public function setHeight(v:Number):void
		{
			_height = v;
		}

		public function getSpeed():Number
		{
			return _speed;
		}

		public function setSpeed(v:Number):void
		{
			_speed = v;
		}

		public function getX():Number
		{
			return x;
		}

		public function setX(v:Number):void
		{
			x = v;
		}

		public function getY():Number
		{
			return y;
		}

		public function setY(v:Number):void
		{
			y = v;
		}

		public function getAngle():Number
		{
			return _angle;
		}

		public function setAngle(v:Number):void
		{
			_angle = v;
		}

		public function getAimX():Number
		{
			return _aimX;
		}

		public function setAimX(v:Number):void
		{
			_aimX = v;
		}

		public function getAimY():Number
		{
			return _aimY;
		}

		public function setAimY(v:Number):void
		{
			_aimY = v;
		}

		public function getPath():Array
		{
			return _path;
		}

		public function setPath(v:Array):void
		{
			_path = v;
		}

		public function get map():Array
		{
			return _map;
		}

		public function setMap(v:Array):void
		{
			_map = v;
		}

		public function getName():String
		{
			return _name;
		}

		public function setName(v:String):void
		{
			_name = v;
		}
		
		
	}
}