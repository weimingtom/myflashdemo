

package rpg
{
	import event.PlayerEvent;
	
	import findpath.PathFinding;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	public class Player extends Sprite{
		
		private var _width:Number;
		private var _height:Number;
		
		private var _speed:Number = 4; 
		
		private var _x:Number=0;
		private var _y:Number=0;
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
			this._stand = new Stand();
			this._goLeft = new GoLeft();
			this._goRight = new GoRight();
			this._goGoUp = new GoUp();
			this._goGoDown = new GoDown();
			this._goGoUpLeft = new GoUpLeft();
			this._goGoUpRight = new GoUpRight();
			this._goGoDownLeft = new GoDownLeft();
			this._goGoDownRight = new GoDownRight();
			addEventListener(PlayerEvent.MOVE,moveInPath);
			
			stand();
		}
		
		private function cancelAllStatus(){
			this._stand.visible = false;
			this._goLeft.visible = false;
			this._goRight.visible = false;
			this._goGoUp.visible = false;
			this._goGoDown.visible = false;
			this._goGoUpLeft.visible = false;
			this._goGoUpRight.visible = false;
			this._goGoDownLeft.visible = false;
			this._goGoDownRight.visible = false;
		}
		
		private function stand(){
			cancelAllStatus();
			this._stand.visible = true;
		}
		private function goUp(){
			cancelAllStatus();
			this._goGoUp.visible = true;
			this._y+=this._speed;
		}
		private function goUpLeft(){
			cancelAllStatus();
			this._goGoUpLeft.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(this._angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(this._angle);//y上的分速度
			this._x+=__xspeed;
			this._y+=__yspeed;
			
		}
		private function goUpRight(){
			cancelAllStatus();
			this._goGoUpRight.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(this._angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(this._angle);//y上的分速度
			this._x+=__xspeed;
			this._y+=__yspeed;
		}
		private function goDown(){
			cancelAllStatus();
			this._goGoDown.visible = true;
			this._y-=this._speed;
		}
		private function goDownLeft(){
			cancelAllStatus();
			this._goGoDownLeft.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(this._angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(this._angle);//y上的分速度
			this._x+=__xspeed;
			this._y+=__yspeed;
		}
		private function goDownRight(){
			cancelAllStatus();
			this._goGoDownRight.visible = true;
			
			var __xspeed:Number = _speed*Math.cos(this._angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(this._angle);//y上的分速度
			this._x+=__xspeed;
			this._y+=__yspeed;
		}
		private function goLeft(){
			cancelAllStatus();
			this._goLeft.visible = true;
			this._x-=this._speed;
		}
		private function goRight(){
			cancelAllStatus();
			this._goRight.visible = true;	
			this._x+=this._speed;
		}
		
		
		
		
		public function moveInPath(e:Event):void{
			var endPoint:Point = new Point(this._aimX,this._aimY);
			
			if(this._map == null){
				trace("地图未设置");
				return;
			}
			
			
			/*先取得路径*/
			var __pf: PathFinding = new PathFinding(this._map,false);
			
			var __thisPoint = new Point(this._x,this._y);
			__pf.path8(__thisPoint,endPoint);
			this._path = __pf.optimizePath();
			
			trace(this._path);
			
			for(var i:int ; i<this._path.length; i++){
				this._aimX = this._path[i].x;
				this._aimY = this._path[i].y;
				addEventListener(Event.ENTER_FRAME,go);
			}
			
			
				
		}
		
		private function go(e:Event){
			
			
			if(this._x==this._aimX&&this._y==this._aimY){
				removeEventListener(Event.ENTER_FRAME,go);
				//变成站立状态
				stand();
			}
			
			this._angle = Math.atan2(this._aimY-y, this._aimX-x);
			
			if(true){
				goLeft();
			}else if(false){
				goRight();
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
			return _x;
		}

		public function setX(v:Number):void
		{
			_x = v;
		}

		public function getY():Number
		{
			return _y;
		}

		public function setY(v:Number):void
		{
			_y = v;
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