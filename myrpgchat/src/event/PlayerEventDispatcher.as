/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-21
 * data: 2007-12-21
 */
 
package event{
	
	import flash.events.EventDispatcher;
	
	import rpg.Player;
	
	public class PlayerEventDispatcher extends EventDispatcher{

		public function dispatchit(player:Player,action:String):Boolean
		{
			return player.dispatchEvent(new PlayerEvent(action));
		}
	}
}