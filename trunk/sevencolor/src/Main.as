package
{
	import MyPathFind.PathFind;
	import MyPathFind.PathFindv1;
	
	import com.data.map.HashMap;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	public class Main extends Sprite {
		var score:uint = 0;//得分
		
		var ready:Boolean = true;
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
		
		var mapLength:uint = map[0].length;
		var mapHeight:uint = map.length;
		
		var startPoint:Point = null;//初始点
		var endPoint:Point = null;//终点
		
		var aimBall:Ball = null;//操作的球
		
		public function Main(){
			
			addChild(new Table());
			
			freeMap = new HashMap();
			for(var i:uint=0;i<mapLength;i++){
				for(var j:uint=0;j<mapHeight;j++){
					freeMap.put((i.toString()+"-"+j.toString()),new Point(i,j));
				}
			}
			putBall();
			
			stage.addEventListener(MouseEvent.CLICK,mouseHandler);
			
	      //	pathCheck();
		}
		
		private function pathCheck(){
			var _map:Array = [
				[0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0],
				[0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
			];
			var pf:PathFindv1 = new PathFindv1(_map);
				pf.pathFind(new Point(1,3),new Point(3,3));
			//如果找到路径
			trace("已找到路径");
			trace(pf.path);
		}
		
		private function mouseHandler(e:MouseEvent){
			var path:Array = new Array();
//			trace("e.localX"+e.localX);
//			trace("e.localY"+e.localY);
//			trace("e.stageX"+e.stageX);
//			trace("e.stageY"+e.stageY);
			var pointx:uint = e.stageX/40 ;
			var pointy:uint = e.stageY/40 ;
//			trace("e.pointx"+pointx);
//			trace("e.pointy"+pointy);
			
			if(Ball(ballsMap.get(pointx+"-"+pointy))!=null){
				startPoint = new Point(pointx,pointy);
			}
			
			if(startPoint!=null && Ball( ballsMap.get(pointx+"-"+pointy))==null){
				endPoint = new Point(pointx,pointy);
			}
			
			if(startPoint!=null && endPoint!=null){
				
				
				var pf:PathFind = new PathFind(map,true);
				pf.pathFind(new Point(startPoint.x,startPoint.y),new Point(endPoint.x,endPoint.y));
				//如果找到路径
				path = pf.path;
				
				aimBall = Ball(ballsMap.get(startPoint.x+"-"+startPoint.y)) ;
				
				aimBall.setPath(path);
				aimBall.move();
				moveInPath();
				
			}
			
		}
	
		private function moveInPath(){
			
			
			
//			trace(path);
//				
//				
//			for (var i:uint=1;i<path.length;i++){
//				if(aimBall!=null){
//					aimBall.move(path[i]);
//
//				}
//			}
//			
			
			
			
			modifyMap(startPoint.x,startPoint.y,0);
			modifyMap(endPoint.x,endPoint.y,1);
			freeMap.remove(endPoint.x+"-"+endPoint.y);
			freeMap.put(startPoint.x+"-"+startPoint.y,new Point(startPoint.x,startPoint.y))
			ballsMap.remove(startPoint.x+"-"+startPoint.y);
			ballsMap.put(endPoint.x+"-"+endPoint.y,aimBall);
			
			if(startPoint!=null&&endPoint!=null){
				
				putBall();
				
			}
			
			
			//检测是否够5连
			check(endPoint);
			
			aimBall = null;
			startPoint = null;
			endPoint = null;
			
			
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
			if(x>=mapHeight){
				trace("x越界！");
				return;
			}
			if(y>=mapLength){
				trace("y越界！");
				return;
			}
			
			if(zo == 1 ){
				map[y][x] = zo ;
			}else if(zo == 0){
				map[y][x] = zo ;
			}
			
		}
		
		private function putBall(){
			
	      	
	      	var posArray:Array = initPos();
	      	var colorArray:Array = initColor();
	      	
	      	for(var i:uint=0;i<posArray.length;i++){
	      		var ball:Ball=new Ball(colorArray[i]);
	      		var point:Point = posArray[i];
	      		
	      		ball.centX = point.x*40+20;
	      		ball.centY = point.y*40+20;
	      		
	      		ball.x = ball.centX-17;
	      		ball.y = ball.centY-17;
	      		//空闲位置刷新
	      		freeMap.remove(point.x+"-"+point.y);
	      		//记录位置-球
	      		ballsMap.put(point.x+"-"+point.y,ball);
	      		//更新寻路用map
	      		modifyMap(point.x,point.y,1);
	      		
	      		ball.setFlag(map[point.y][point.x]);
	      		ball.draw();
	      		addChild(ball);
	      	}
			
		}
		
		
		public function check(point:Point){
			
			
			var thisBall:Ball = Ball(ballsMap.get(point.x+"-"+point.y)); 
			var thisColor:uint = thisBall.getColor();
			
			var lrLineMap:HashMap = new HashMap();//左右线map
			var udLineMap:HashMap = new HashMap();//上下线map
			var luDiagonalMap:HashMap = new HashMap();//左上右下线map
			var ruDiagonalMap:HashMap = new HashMap();//左下右上线map
			

			
			var tmpBall : Ball = null;
			
			lrLineMap.put(point.x+"-"+point.y,thisBall);
			udLineMap.put(point.x+"-"+point.y,thisBall);
			luDiagonalMap.put(point.x+"-"+point.y,thisBall);
			ruDiagonalMap.put(point.x+"-"+point.y,thisBall);
			
			//判断左右边
			for(var i:uint=1;point.x-i>=0;i++){
			
				tmpBall = Ball(ballsMap.get((point.x-i)+"-"+point.y)) ;
				if(tmpBall!=null && thisColor == tmpBall.getColor()){
					lrLineMap.put(((point.x-i)+"-"+point.y),tmpBall);
					tmpBall = null ;
				}else{
					//一旦碰到一个是空就break;说明不相连
					break;
				}
					
			}
			
			for(var j:uint=1;point.x+j<=15;j++){
			
				tmpBall = Ball(ballsMap.get((point.x+j)+"-"+point.y)) ;
				if(tmpBall!=null&& thisColor == tmpBall.getColor()){
					lrLineMap.put(((point.x+j)+"-"+point.y),tmpBall);
					tmpBall = null ;
				}else{
					//一旦碰到一个是空就break;说明不相连
					break;
				}
					
			}
			//判断上下边
		
			//判断左上右下
			//判断左下右上
			


				
			var lrLineNum:uint = lrLineMap.size(); //左右线num
			var udLineNum:uint = 0; //上下线num
			var ludiagonalNum:uint = 0; //左上右下线num
			var rudiagonalNum:uint = 0; //左下右上线num
			//是否先判断size得考虑下
			if(lrLineNum>=5){
				for each(var tmpCancelBall:Ball in lrLineMap.values()){
					if(tmpCancelBall!=null){
						removeChild(tmpCancelBall);
						
						modifyMap(uint(tmpCancelBall.x/40),uint(tmpCancelBall.y/40),0);
						freeMap.put(uint(tmpCancelBall.x/40)+"-"+uint(tmpCancelBall.y/40),new Point(uint(tmpCancelBall.x/40),uint(tmpCancelBall.y/40)))
						ballsMap.remove(uint(tmpCancelBall.x/40)+"-"+uint(tmpCancelBall.y/40));
					}
				}
				score = score +10*lrLineNum;
			}
			lrLineMap = null;
			lrLineNum = 0;
			trace("score"+score);
			
			
		}
		
	}
	
}