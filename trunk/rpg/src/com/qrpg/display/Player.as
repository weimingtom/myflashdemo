/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-26
 * data: 2007-12-26
 */

package com.qrpg.display
{
	import com.qrpg.events.GameEventDispatcher;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
		
	public class Player extends Human
	{
		public static const STAND:int = 0;
		public static const SIT:int = 1;
		public static const RUN:int = 2;
		public static const NOT_MIRROR:int = 1;
		public static const IS_MIRROR:int = -1;
		
		private var _isSit:Boolean;
		private var _dire:int;
		private var _runFrame:int;
		private var _isMirror:Boolean;
		private var _isNext:Boolean;
		private var _path:Array;
		private var _pathIndex:int;
		
		private var nameShower:TextField;
		private var myName:String;
		private var myHeight:int;
		private var myWidth:int;
		private var mycx:int;
		public function Player(url:String, 
			width:int=100, 
			height:int=100, 
			cx:int=-1, 
			cy:int=-1, 
			speed:Number=6,
			isMirror:Boolean=true):void
			{
				super(url, width, height, cx, cy, speed);
				_isSit = false;
				_isMirror = isMirror;
				_isNext = false;
				myWidth =width;
				myHeight= height;
				mycx = cx;
			nameShower=new TextField();
			nameShower.autoSize=TextFieldAutoSize.LEFT;
			nameShower.alpha=0.5;
			nameShower.textColor=0xFF0000;
			nameShower.selectable=false;	
			}
		
				/**
		 * 设置用户的名字
		 * @param n 用户要显示的名字
		 * 
		 */
		public function set playerName(n:String):void
		{

			nameShower.text=n;
			nameShower.y=-2-myHeight;
			nameShower.x=mycx-myWidth;//-12;//(myWidth-nameShower.width)/30;
			
			myName=n;
			addChild(nameShower);
			
		}
		
		public function sit():void
		{
			if(_isSit){
				setFrame(STAND, _dire);
				_isSit = false;
				events.dispatch(GameEventDispatcher.STAND, this);
			}else{
				_aimx = x;
				_aimy = y;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				setFrame(SIT, _dire);
				_isSit = true;
				events.dispatch(GameEventDispatcher.SIT, this);
			}
		}
		
		public function isSit():Boolean
		{
			return _isSit;
		}
		
		var count:Number=0;
		public function moveInPath(path:Array):void
		{
			_path = path.concat();//复制数组
			_pathIndex = 0;
			move(_path[_pathIndex].x*8+8, _path[_pathIndex].y*8+8);
		}
		
		override public function move(px:Number, py:Number):void
		{
			super.move(px, py);
			/*测试路径*/
//			for(var i:int ;i<_path.length;i++){
//				
//				trace(_path[i].x);
//				trace(_path[i].y);
//			}
			/*测试路径*/
			if(_isSit){
				_isSit = false;
				events.dispatch(GameEventDispatcher.STAND, this);
			}
			_dire = Math.round((_angle+Math.PI)/(Math.PI/4));
			_dire = _dire>5 ? _dire-6 : _dire+2;
			if(_isMirror){
				if(_dire>4){
					_dire = _dire == 5 ? 3 : _dire == 6 ? 2 : 1;
					mirror(IS_MIRROR);
				}else{
					mirror(NOT_MIRROR);
				}
			}
			if(getFrameX()>1){
				setFrame(getFrameX(), _dire);
			}else{
				setFrame(RUN, _dire);
			}
		}
		
		override public function stop():void
		{
			if(!_path){
				return;
			}
			if(_pathIndex<_path.length-1){
				_pathIndex++;
				move(_path[_pathIndex].x*8+8, _path[_pathIndex].y*8+8);
			}else{
				events.dispatch(GameEventDispatcher.STOP, this);
				setFrame(STAND, getFrameY());
			}
		}
		
		override protected function nextRunFrame():void
		{
			if(_isNext){
				setFrame(getFrameX()==9?2:getFrameX()+1, getFrameY());
			}
			_isNext = !_isNext;
		}
		
	}
}