/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-21
 * data: 2007-12-21
 */

package com.qrpg.events{
	import com.qrpg.display.Item;
	import flash.events.Event;

	public class GameEvent extends Event {
		public var ower:Item;

		public function GameEvent(type:String,para:Item,bubbles:Boolean=false,cancelable:Boolean=false):void {
			super(type,bubbles,cancelable);
			ower=para;
		}

	}
}