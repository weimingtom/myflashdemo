/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-21
 * data: 2007-12-21
 */

package event
{
	import flash.events.Event;
	
	import rpg.Player;

	public class PlayerEvent extends Event {
		public var ower:Player;

		public function PlayerEvent(type:String,para:Player,bubbles:Boolean=false,cancelable:Boolean=false):void {
			super(type,bubbles,cancelable);
			ower=para;
		}

	}
}