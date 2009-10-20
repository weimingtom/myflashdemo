package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Ball extends MovieClip
	{

		
		private var _color:uint;
		private var _aimPoint:Point;
		private var _speed:int = 20 ;
		private var _xspeed:int = 0 ;
		private var _yspeed:int = 0 ;
		
		var _ready:Boolean = true;
		
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
			this._aimPoint = point;
			
			
			point.x = 20+point.x*40;
			point.y = 20+point.y*40;
			
			
			
			var xspeed:int = 0;
			var yspeed:int = 0;
			var xtimes:uint = 0;
			var ytimes:uint = 0;
			
			if(point.x>x){
				_xspeed = _speed ;
			}else if(point.x==x){
				_xspeed = 0 ;
			}else{
				_xspeed = - _speed;
			}
//			xtimes = Math.abs( point.x - this.x ) / tmpSpeed ;
//			
			if(point.y>y){
				_yspeed = _speed ;
			}else if(point.y==y){
				_yspeed = 0 ;
			}else{
				_yspeed = - _speed;
			}
//			ytimes = Math.abs( point.y - this.y ) / tmpSpeed ;
			
//			trace("this.x"+this.x);
//			trace("this.y"+this.y);
//			
//			trace(xspeed);
//			trace(yspeed);
//			trace(xtimes);
//			trace(ytimes);
//			
			
			
			if(_ready&&_xspeed!=0){
				_ready = false;
        		addEventListener(Event.ENTER_FRAME,xgo);
   			}		
   			
            
			
		}
		
		
		private function xgo(e:Event){
			trace("this.x"+x);
			trace("_aimPoint.x"+_aimPoint.x);
        	x = x + _xspeed;
        	if(Math.abs(x-_aimPoint.x)<=1){
    			removeEventListener(Event.ENTER_FRAME,xgo);
    			trace("remove");
    			_xspeed = 0;
    			_ready = true;
    			
		        if(_ready&&_yspeed!=0){		
	        		_ready = false;
					addEventListener(Event.ENTER_FRAME,ygo);
				}
				
    		}
	            		
        }
       
        private function ygo(e:Event){
			trace("this.y"+y);
			trace("_aimPoint.y"+_aimPoint.y);
			y = y + _yspeed;
			
    		if(Math.abs(y-_aimPoint.y)<=1){
    			removeEventListener(Event.ENTER_FRAME,ygo);
    			trace("remove");
    			_yspeed = 0;
    			_ready = true;
    		}	
        }
		
		public function getColor(){
			return _color;
		}

	}
}