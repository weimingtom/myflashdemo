package
{
	import com.data.map.HashMap;
	
	import findpath.PathFinding;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	public class Main extends Sprite {
		var ballsMap:HashMap = new HashMap();
		
		var map:Array = [
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		];
		
		var freeMap:HashMap;
		
		var mapLength = map[0].length;
		var mapHeight = map.length;
		
		var startPoint:Point = null;//初始点
		var endPoint:Point = null;//终点
		
		var aimBall:Ball = null;//操作的球
		
		public function Main(){
			
			freeMap = new HashMap();
			for(var i:uint=0;i<mapLength;i++){
				for(var j:uint=0;j<mapLength;j++){
					freeMap.put((i.toString()+"-"+j.toString()),new Point(i,j));
				}
			}
			putBall();
			
			stage.addEventListener(MouseEvent.CLICK,mouseHandler);
			
	      	
		}
		
		private function mouseHandler(e:MouseEvent){
			var pointx:uint = e.stageX/40 -1;
			var pointy:uint = e.stageY/40 -1;
			
			if(Ball(ballsMap.get(pointx+"-"+pointy))!=null){
				startPoint = new Point(pointx,pointy);
			}
			
			if(startPoint!=null && Ball( ballsMap.get(pointx+"-"+pointy))==null){
				endPoint = new Point(pointx,pointy);
			}
			
			if(startPoint!=null && endPoint!=null){
				var path:Array = new PathFinding(map).path4(startPoint,endPoint);
				
				aimBall = Ball(ballsMap.get(startPoint.x+"-"+startPoint.y)) ;
				moveInPath(path);
				
				modifyMap(startPoint.x,startPoint.y,0);
				modifyMap(endPoint.x,endPoint.y,1);
				freeMap.remove(endPoint.x+"-"+endPoint.y);
				freeMap.put(startPoint.x+"-"+startPoint.y,new Point(startPoint.x,startPoint.y))
				ballsMap.remove(startPoint.x+"-"+startPoint.y);
				ballsMap.put(endPoint.x+"-"+endPoint.y,aimBall);
				
				aimBall = null;
				startPoint = null;
				endPoint = null;
				
				putBall();
			}
			
		}
	
		private function moveInPath(path:Array){
			
				trace(path);
			for each (var point:Point in path){
				if(aimBall!=null){
					trace("aimBall.x"+aimBall.x);
					trace("aimBall.y"+aimBall.y);
					trace(point);
					aimBall.move(point);
				}
			}
			
		}
	
		/**初始化小球最初的3个位置*/
		private function initPos():Array{
			var array:Array = new Array();
			
			var count:uint = 0;
			for(var i:uint;i<3;i++){
				
				var freeKeys:Array = freeMap.keys();
				if(freeKeys.length<3){
					trace("game over");
					return null;
				}
				
				var rand:uint = Math.random()* (freeKeys.length);
				var point:Point = Point(freeMap.get(freeKeys[rand])) ;
				freeMap.remove(freeKeys[rand]);
				array.push(point);

			}
			return array;
		}
		
		/**初始化小球接下来的3个颜色*/
		private function initColor():Array{
			
			var array:Array = new Array();
			for(var i:uint;i<3;i++){
				var randNum:uint = Math.random()*Constant.COLORS.length;
				array.push(randNum);
			}
			return array;
			
		}
		
		/**刷新map*/
		private function modifyMap(x:uint,y:uint,zo:uint){
			if(x>=mapLength){
				trace("x越界！");
				return;
			}
			if(y>=mapHeight){
				trace("y越界！");
				return;
			}
			
			if(zo == 1 ){
				map[x][y] = 1 ;
			}else if(zo == 0){
				map[x][y] = 0 ;
			}
		}
		
		private function putBall(){
			
	      	
	      	var posArray:Array = initPos();
	      	var colorArray:Array = initColor();
	      	
	      	for(var i:uint=0;i<posArray.length;i++){
	      		var ball:Ball=new Ball(colorArray[i]);
	      		var point:Point = posArray[i];
	      		ball.x=20+point.x*40;
	      		ball.y=20+point.y*40;
	      		addChild(ball);
	      		//记录位置-球
	      		ballsMap.put(point.x+"-"+point.y,ball);
	      		//更新寻路用map
	      		modifyMap(point.x,point.y,1);
	      	}
			
		}
		
	}
	
}