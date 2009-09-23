package {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class Bird extends Sprite{
		
		public static var mans:Array=new Array();
		
		public function Bird(){
			init();


		}
		
		private function init():void{

			
			/*定义舞台背景*/
			var sb:BG2 = new BG2();
			addChild(sb);
			sb.x=0;
			sb.y=0;
			
			var tmpMan : Man = new Man();
			mans.push(tmpMan);
			
			stage.addEventListener(MouseEvent.CLICK,beginG);
			
			//stage.focus = man ;		
			
			
			
			
		}
		
		
		
		private function beginG(e:MouseEvent):void{
			
			for(var i:int=0;i<mans.length;i++){ 
			
					var man : Man = mans[i] ;
					addChild(man);
					stage.addEventListener(KeyboardEvent.KEY_DOWN,man.eventListen);
					stage.addEventListener(KeyboardEvent.KEY_UP,man.eventUpListen);
				
			}
		
		
		}
		
//		public static function addMan(man:Man):void{
////			
////			addChild(man);
////			stage.addEventListener(KeyboardEvent.KEY_DOWN,man.eventListen);
////			stage.addEventListener(KeyboardEvent.KEY_UP,man.eventUpListen);
//		}
		
		
		
	}
	
	
	

	
	
}