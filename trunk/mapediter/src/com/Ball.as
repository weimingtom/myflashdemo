package com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Ball extends MovieClip
	{
		private var _color:uint;
		
		public function Ball(color:uint){
			_color = color;
			init(color);
			

		}
		
		
		private function init(color:uint)
		{
			switch(color){
				case 0 :  
					this.graphics.beginFill(Constant.COLOR_0);
					_color = Constant.COLOR_0;
			        this.graphics.drawCircle(17,17,17);
			        this.graphics.endFill();
			        break; 
				case 1 :  
					this.graphics.beginFill(Constant.COLOR_1);
					_color = Constant.COLOR_1;
			        this.graphics.drawCircle(17,17,17);
			        this.graphics.endFill();
			        break;
				case 2 :  
					this.graphics.beginFill(Constant.COLOR_2);
					_color = Constant.COLOR_2;
			        this.graphics.drawCircle(17,17,17);
			        this.graphics.endFill();
			        break;
				case 3 :  
					this.graphics.beginFill(Constant.COLOR_3);
					_color = Constant.COLOR_3;
			        this.graphics.drawCircle(17,17,17);
			        this.graphics.endFill();
			        break;
				case 4 :  
					this.graphics.beginFill(Constant.COLOR_4);
					_color = Constant.COLOR_4;
			        this.graphics.drawCircle(17,17,17);
			        this.graphics.endFill();
			        break;
				case 5 :  
					this.graphics.beginFill(Constant.COLOR_5);
					_color = Constant.COLOR_5;
			        this.graphics.drawCircle(17,17,17);
			        this.graphics.endFill();
			        break;
				case 6 :  
					this.graphics.beginFill(Constant.COLOR_6);
					_color = Constant.COLOR_6;
			        this.graphics.drawCircle(17,17,17);
			        this.graphics.endFill();
			        break;
			        
			    default:break;    
			
			}
			
		}


	}
}