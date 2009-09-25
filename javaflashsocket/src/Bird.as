package {
	import com.klstudio.data.map.HashMap;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.Socket;

	public class Bird extends Sprite{
		
		public static var hashMap:HashMap = new HashMap();
		private var serverUrl:String ="192.168.0.243";
		private var socket:Socket ;
		
		public function Bird(){
			init();
		}
		
		private function init():void{

			
			/*定义舞台背景*/
			var sb:BG2 = new BG2();
			addChild(sb);
			sb.x=0;
			sb.y=0;
			
			socket = new Socket(serverUrl,8821);
						
			var tmpMan : Man = new Man(socket);
			KeyListener.init(stage,tmpMan.eventHandler);
			hashMap.put(serverUrl,tmpMan);
			
			stage.addEventListener(MouseEvent.CLICK,beginG);
			
			//stage.focus = man ;		
			
			
			
			
		}
		
		
		
		private function beginG(e:MouseEvent):void{
			
			for each(var man:Man in hashMap.values()){ 
					var base:int =	Math.floor(Math.random()*200);
					man.setX(man.getX()+base);
					addChild(man);
			}
		}
	}

}














