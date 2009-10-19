package
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
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
			        this.graphics.drawCircle(50,50,17);
			        this.graphics.endFill();
			        break; 
				case 1 :  
					this.graphics.beginFill(Constant.COLOR_1);
			        this.graphics.drawCircle(50,50,17);
			        this.graphics.endFill();
			        break;
				case 2 :  
					this.graphics.beginFill(Constant.COLOR_2);
			        this.graphics.drawCircle(50,50,17);
			        this.graphics.endFill();
			        break;
				case 3 :  
					this.graphics.beginFill(Constant.COLOR_3);
			        this.graphics.drawCircle(50,50,17);
			        this.graphics.endFill();
			        break;
				case 4 :  
					this.graphics.beginFill(Constant.COLOR_4);
			        this.graphics.drawCircle(50,50,17);
			        this.graphics.endFill();
			        break;
				case 5 :  
					this.graphics.beginFill(Constant.COLOR_5);
			        this.graphics.drawCircle(50,50,17);
			        this.graphics.endFill();
			        break;
				case 6 :  
					this.graphics.beginFill(Constant.COLOR_6);
			        this.graphics.drawCircle(50,50,17);
			        this.graphics.endFill();
			        break;
			        
			    default:break;    
			
			}
			
		}

		public function move(point:Point){
			
			point.x = 20+point.x*40;
			point.y = 20+point.y*40;
			
			var tmpSpeed:int = 40 ;
			
			var xspeed:int = 0;
			var yspeed:int = 0;
			var xtimes:uint = 0;
			var ytimes:uint = 0;
			
			if(point.x>this.x){
				xspeed = tmpSpeed ;
			}else{
				xspeed = -tmpSpeed;
			}
			xtimes = Math.abs( point.x - this.x ) / tmpSpeed ;
			
			if(point.y>this.y){
				yspeed = tmpSpeed ;
			}else{
				yspeed = -tmpSpeed;
			}
			ytimes = Math.abs( point.y - this.y ) / tmpSpeed ;
			
			trace("this.x"+this.x);
			trace("this.y"+this.y);
			
			trace(xspeed);
			trace(yspeed);
			trace(xtimes);
			trace(ytimes);
			
			
			
			//先走x轴
			if(xtimes>0){
            	for(var i:uint;i<xtimes;i++){
	            	this.x = this.x + xspeed;
            	}
			}
			
			//再走y轴
			if(ytimes>0){
				for(var j:uint;j<ytimes;j++){
            		this.y = this.y + yspeed;
            	}
			}
			
		}
		
		public function getColor(){
			return _color;
		}

	}
}