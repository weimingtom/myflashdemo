package{

/**
by深闪
键盘控制
8    1    2
  \   |   /
7-    X    - 3
  /   |   \ 
6    5    4
**/
import flash.display.*
import flash.display.InteractiveObject; 
import flash.events.KeyboardEvent; 
import flash.events.Event;
public class KeyListener extends MovieClip{
		private static var current_stage:InteractiveObject;
		private static var key:Array;
		private static var dir:uint;
		private static var eventHandler:Function;
		
		public static function init(io:InteractiveObject,keyfun:Function){
		  current_stage=io;
		  eventHandler=keyfun;
		  key=new Array(false,false,false,false);
		  current_stage.addEventListener(KeyboardEvent.KEY_DOWN,keydownHandler);
		  current_stage.addEventListener(KeyboardEvent.KEY_UP,keyupHandler);
		}
		
		private static function keydownHandler(e:KeyboardEvent):void {
		        switch (e.keyCode) {
				   case 38 :	
				   		key[0]=true;  break;
				   case 39 :	
				   		key[1]=true;  break; 
				   case 40 :
				    	key[2]=true;  break;
				   case 37 :
				     	key[3]=true;  break;
				   default:		   break;
		        }
		        current_stage.addEventListener(Event.ENTER_FRAME,eventHandler); 
		}
		  
		   private static function keyupHandler(e:KeyboardEvent):void {
		        switch (e.keyCode) {
				   case 38 :	
				   		key[0]=false;  break;
				   case 39 :	
				   		key[1]=false;  break; 
				   case 40 :
				    	key[2]=false;  break;
				   case 37 :
				     	key[3]=false;  break;
				   default:		   break;
	            }
		  !key[0]&&!key[1]&&!key[2]&&!key[3]&&(current_stage.removeEventListener(Event.ENTER_FRAME,eventHandler));
		}
		
		//返回方向
		public static function getDirection():uint{
		  key[0]&&(dir=1);
		  key[1]&&(dir=3);
		  key[2]&&(dir=5);
		  key[3]&&(dir=7);
		  key[0]&&key[1]&&(dir=2);
		  key[1]&&key[2]&&(dir=4);
		  key[2]&&key[3]&&(dir=6);
		  key[3]&&key[0]&&(dir=8);
		  return dir;
		}
		
	}
}


//	使用方法：
//	KeyListener.init(stage,eventHandler);
//	function eventHandler(e:Event):void{
//	//使用的时候这里加个判断就可以根据不同方向进行不同操作了
//	trace(KeyListener.getDirection());
//	}
