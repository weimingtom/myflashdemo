package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class Ball extends MovieClip
	{
		private var _pathDepth:uint=0;
		private var _path :Array = null;
		
		private var _textfield:TextField = new TextField();
		private var _flag :uint = 1;
		
		private var _color:uint;
		private var _aimPoint:Point;
		private var _speed:int = 10 ;
//		private var _speed:int = 20 ;
		private var _xspeed:int = 0 ;
		private var _yspeed:int = 0 ;
		
		public var centX:uint; //中心点x
		public var centY:uint; //中心点y
		
		var _ready:Boolean = true;
		
		public function Ball(color:uint){
			_color = color;
			init(color);
			
//			draw();

		}
		
		public function draw(){
			_textfield.htmlText ="<font color=\"0xFFFFFF\" size=\"20\">"+ _flag.toString()+"</font>";
			_textfield.x=17;
			_textfield.y=17;
			addChild(_textfield);
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

		public function move(){
			var point:Point = _path[_pathDepth];
			_aimPoint = point;
			
			
			
			

			
			if(point.x>getPointX()){
				_xspeed = _speed ;
			}else if(point.x==getPointX()){
				_xspeed = 0 ;
			}else{
				_xspeed = - _speed;
			}
			
			if(point.y>getPointY()){
				_yspeed = _speed ;
			}else if(point.y==getPointY()){
				_yspeed = 0 ;
			}else{
				_yspeed = - _speed;
			}
			
			if(_ready){
				_ready = false;
        		addEventListener(Event.ENTER_FRAME,go);
        		        	
   			}		
   			
   			
            
			
		}
		
		
		private function go(e:Event){
        	x = x + _xspeed;
        	y = y + _yspeed;
        	

        	
        	if(((Math.abs(y-(_aimPoint.y*40+20-17))<=_speed)&&(_xspeed==0))||(Math.abs(x-(_aimPoint.x*40+20-17))<=_speed)&&(_yspeed==0)){
    			removeEventListener(Event.ENTER_FRAME,go);
        		x = _aimPoint.x*40+20-17;
        		y = _aimPoint.y*40+20-17;
        		_xspeed = 0;
    			_yspeed = 0;
    			_ready = true;

				stops();
    		}
    		
        }

//        private function ygo(e:Event){
//			y = y + _yspeed;
//			
//    		if(Math.abs(getCentY()-_aimPoint.y)<=1){
//    			removeEventListener(Event.ENTER_FRAME,ygo);
//    			_yspeed = 0;
//    			_ready = true;
//    			
//    			if(_ready&&_xspeed!=0){		
//	        		_ready = false;
//					addEventListener(Event.ENTER_FRAME,xgo);
//				}
//    		}	
//    		
//
//        }
        
               
       private function stops(){
            _pathDepth++;
        
            if(_pathDepth<_path.length){
            	move();
            }else{
            	_pathDepth = 1;
            }	
       
       }
		
		public function getColor(){
			return _color;
		}
		
		public function getPointX(){
			return uint(x/40);
		}
		public function getPointY(){
			return uint(y/40);
		}
		public function setFlag(v:uint){
			_flag = v;
		}
		public function getFlag(){
			return _flag;
		}
		public function setPath(v:Array){
			_path = v;
		}

	}
}