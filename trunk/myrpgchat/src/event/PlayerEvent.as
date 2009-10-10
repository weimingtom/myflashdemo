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
		public static const SIT:String = "sit";
		public static const STAND:String = "stand";
		public static const MOVE:String = "movehgvgf";
		public function PlayerEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=true):void {
			super(type,bubbles,cancelable);
		}

	}
}