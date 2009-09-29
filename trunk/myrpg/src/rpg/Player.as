

package rpg
{
	import findpath.PathFinding;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	public class Player extends Sprite{
		
		private var _width:Number;
		private var _height:Number;
		
		private var _speed:Number = 4; 
		
		private var _angle:Number;
		
		private var _aimX:Number;
		private var _aimY:Number;
		
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
		
		public function Player(){

			init();

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
			_stand.x=this.x;
			_stand.y=this.y;
			cancelAllStatus();
			_stand.visible = true;
		}
		private function goUp(){
			cancelAllStatus();
			_goGoUp.visible = true;
			
			this.y+=_speed;
			
			_goGoUp.x=this.x;
			_goGoUp.y=this.y;
		}
		private function goUpLeft(){
			cancelAllStatus();
			_goGoUpLeft.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(_angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(_angle);//y上的分速度
			
			this.x+=__xspeed;
			this.y+=__yspeed;
			
			_goGoUpLeft.x=this.x;
			_goGoUpLeft.y=this.y;
			
		}
		private function goUpRight(){
			cancelAllStatus();
			_goGoUpRight.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(_angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(_angle);//y上的分速度
			this.x+=__xspeed;
			this.y+=__yspeed;
			_goGoUpRight.x=this.x;
			_goGoUpRight.y=this.y;
		}
		private function goDown(){
			cancelAllStatus();
			this.visible = true;
			this.y-=_speed;
			_goGoDown.x=this.x;
			_goGoDown.y=this.y;
		}
		private function goDownLeft(){
			cancelAllStatus();
			_goGoDownLeft.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(_angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(_angle);//y上的分速度
			this.x+=__xspeed;
			this.y+=__yspeed;
			_goGoDownLeft.x=this.x;
			_goGoDownLeft.y=this.y;
		}
		private function goDownRight(){
			cancelAllStatus();
			_goGoDownRight.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(_angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(_angle);//y上的分速度
			this.x+=__xspeed;
			this.y+=__yspeed;
			_goGoDownRight.x=this.x;
			_goGoDownRight.y=this.y;
		}
		private function goLeft(){
			cancelAllStatus();
			this.visible = true;
			this.x-=_speed;
			_goLeft.x=this.x;
			_goLeft.y=this.y;
		}
		private function goRight(){
			cancelAllStatus();
			_goRight.visible = true;	
			this.x+=_speed;
			_goRight.x=this.x;
			_goRight.y=this.y;
		}
		
		
		
		
		public function moveInPath():void{
			var endPoint:Point = new Point(Math.round(_aimX/8),Math.round(_aimY/8));
			
			if(_map == null){
				trace("地图未设置");
				return;
			}
			
			
			/*先取得路径*/
			var __pf: PathFinding = new PathFinding(_map,false);
			
			var __thisPoint = new Point(Math.round(x/8),Math.round(y/8));
			__pf.path8(__thisPoint,endPoint);
			_path = __pf.optimizePath();
			
			trace(_path);
			
			for(var i:int =1 ; i<_path.length; i++){
				_aimX = _path[i].x*8;
				_aimY = _path[i].y*8;
				addEventListener(Event.ENTER_FRAME,go);
			}
			
			
		}
		
		private function go(e:Event){
//			trace(x+"--"+_aimX);
//			trace(y+"--"+_aimY);
			
			if(x==_aimX){
				removeEventListener(Event.ENTER_FRAME,go);
				//变成站立状态
				stand();
			}
			
			_angle = Math.atan2(_aimY-y, _aimX-x);
			
			if(_angle>0){
				_angle=_angle;
			}else{
				_angle=Math.PI*2 - _angle;
			}
			
			if(_angle<=Math.PI/8 && _angle > Math.PI*15/8){
				goRight();
			}else if(_angle<=Math.PI*3/8 && _angle > Math.PI/8){
				goUpRight();
			}else if(_angle<=Math.PI*5/8 && _angle > Math.PI*3/8){
				goUp();
			}else if(_angle<=Math.PI*7/8 && _angle > Math.PI*5/8){
				goUpLeft();
			}else if(_angle<=Math.PI*9/8 && _angle > Math.PI*7/8){
				goLeft();
			}else if(_angle<=Math.PI*11/8 && _angle > Math.PI*9/8){
				goDownLeft();
			}else if(_angle<=Math.PI*13/8 && _angle > Math.PI*11/8){
				goDown();
			}else if(_angle<=Math.PI*15/8 && _angle > Math.PI*13/8){
				goDownRight();
			}else{
						
			}
			
							
			
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
		
		
	}
}