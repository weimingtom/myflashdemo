/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-20
 * data: 2007-12-20
 */

package com.qrpg.display
{
	import com.qrpg.events.GameEventDispatcher;
	
	import flash.events.Event;
	
	public class Human extends Item
	{
		protected var _aimx:Number;
		protected var _aimy:Number;
		protected var _angle:Number;
		protected var _speed:Number;
		
		public function Human(url:String, 
			width:int=100, 
			height:int=100, 
			cx:int=-1, 
			cy:int=-1, 
			speed:Number=6):void
			{
				super(url, width, height, cx, cy);
				_speed = speed;
			}
		
		public function move(px:Number,py:Number):void
		{
			events.dispatch(GameEventDispatcher.MOVE, this);
			events.dispatch(GameEventDispatcher.ON_MOVE, this);
			_aimx = px;//目标点坐标
			_aimy = py;
			_angle = Math.atan2(_aimy-y, _aimx-x);

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function setSpeed(speed:int):void
		{
			_speed = speed;
		}
		
		public function getSpeed():int
		{
			return _speed;
		}
		
		public function stop():void
		{
			events.dispatch(GameEventDispatcher.STOP, this);
		}
		
		override public function place(px:Number, py:Number):void
		{
			super.place(px,py);
			_aimx = px;
			_aimy = py;
		}
		
		protected function onEnterFrame(e:Event):void
		{
			var __xspeed:Number = _speed*Math.cos(_angle);//x上的分速度
			var __yspeed:Number = _speed*Math.sin(_angle);//y上的分速度
			var __dx:Number = _aimx-x;//目标地坐标和人物坐标的的差值
			var __dy:Number = _aimy-y;
			
			x += __xspeed;
			y += __yspeed;
			
			if(__yspeed>0){
				_face = true;//向下移动则判断本的Y值是不是大于深度＋1的物体的Y值
			}else if(__yspeed<0){
				_face = false;//向上移动则判断本的Y值是不是小于深度－1的物体的Y值
			}
			
			nextRunFrame();
			
			if(__dx*__dx+__dy*__dy<_speed*_speed){//如果速度大于线的长度则
				x = _aimx;
				y = _aimy;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				stop();
			}else{
				events.dispatch(GameEventDispatcher.ON_MOVE, this);
			}
		}
		
		protected function nextRunFrame():void
		{
		}
	}
}