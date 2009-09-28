package {
	import com.klstudio.data.map.HashMap;
	
	import flash.display.Sprite;
	import flash.net.XMLSocket;

	public class Bird extends Sprite{
		
		public static var hashMap:HashMap = new HashMap();
		private var serverUrl:String ="192.168.0.243";
		private var socket:XMLSocket ;
		
		public function Bird(){
			init();
		}
		
		private function init():void{

			
			/*定义舞台背景*/
			var sb:BG2 = new BG2();
			addChild(sb);
			sb.x=0;
			sb.y=0;
			
			socket = new XMLSocket();
						
			var tmpMan : Man = new Man("name",stage,socket,true);
			KeyListener.init(stage,tmpMan.eventHandler);
			hashMap.put("name",tmpMan);
			addChild(tmpMan);
			//stage.addEventListener(MouseEvent.CLICK,beginG);
			
			//stage.focus = man ;		
			
		}
		
		
		
		public static function beginG(tmpMan:Man):void{
			
			trace("当前有"+hashMap.size()+"个连接");
			//for each(var man:Man in hashMap.values()){ 
//					var base:int =	Math.floor(Math.random()*300);
//					man.setX(man.getX()+base);
					//addChild(tmpMan);
			//}
		}
	}

}














