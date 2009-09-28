/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-21
 * data: 2007-12-21
 */
 
package com.qrpg.events
{
	import com.qrpg.display.Item;
	
	import flash.events.EventDispatcher;
	
	public class GameEventDispatcher extends EventDispatcher
	{
		public static const SIT:String = "sit";
		public static const STAND:String = "stand";
		public static const STOP:String = "stop";
		public static const MOVE:String = "move";
		public static const ON_MOVE:String = "onMove";
		
		public function dispatch(action:String, obj:Item):Boolean
		{
			return dispatchEvent(new GameEvent(action, obj));
		}
	}
}