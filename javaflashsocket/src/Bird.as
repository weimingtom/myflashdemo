package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	public class Bird extends Sprite{
		
		var man : Man = new Man () ;
		
		public function Bird(){
			init();


		}
		
		private function init():void{

			
			/*定义舞台背景*/
			var sb:BG2 = new BG2();
			addChild(sb);
			sb.x=0;
			sb.y=0;
			
			
			
			addChild(man);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,man.eventListen);
			stage.addEventListener(KeyboardEvent.KEY_UP,man.eventUpListen);
			
			//stage.focus = man ;		
			
			
			
			
		}
		
		
	}
	
	
	

	
	
}