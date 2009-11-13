package MyPathFind
{
	import com.data.map.HashMap;
	
	import flash.geom.Point;
	
	public class PathFind{
		
		//(x=14, y=7),
		//(x=13, y=7),
		//(x=13, y=6),
		//(x=13, y=5),
		//(x=13, y=4),
		//(x=13, y=3),
		//(x=12, y=3),
		//(x=12, y=2),
		//(x=12, y=1),
		//(x=12, y=0)
		
		
		//(x=2, y=7),
		//(x=2, y=6),
		//(x=3, y=6),
		//(x=4, y=6),
		//(x=4, y=5),
		//(x=4, y=4),
		//(x=4, y=3),
		//(x=4, y=2)
		
		
		//(x=1, y=12),
		//(x=1, y=11),
							//(x=2, y=11),
		//(x=3, y=11),
					//(x=3, y=10),
		//(x=3, y=9),
							//(x=4, y=9),
							//(x=5, y=9),
							//(x=6, y=9),
							//(x=7, y=9),
		//(x=8, y=9)
		
		
		//-------------------路径例子-------------------
		//(x=2, y=7),
		//(x=2, y=6),
		//(x=3, y=6),
		//(x=4, y=6),
		//(x=4, y=5),
		//(x=4, y=4),
		//(x=4, y=3),
		//(x=4, y=2)
		
		
		//(x=1, y=12),
		//(x=1, y=11),
		//(x=2, y=11),
		//(x=3, y=11),
		//(x=3, y=10),
		//(x=3, y=9),
		//(x=4, y=9),
		//(x=5, y=9),
		//(x=6, y=9),
		//(x=7, y=9),
		//(x=8, y=9)
		
		private var optimize:Boolean=false;
		private var beeValue = 10 ; //直线值
		
		public var map:Array;//地图
		private var mapWidth:uint; 
		private var mapHeight:uint; 
				
		public var cNode:Node;//当前节点
		public var sNode:Node;//起始节点
		public var aNode:Node;//终节点
		
		
		public var openList:HashMap = new HashMap();//开放列表
		public var closeList:HashMap = new HashMap();//关闭列表
		
		private var dirs4:Array =  [[-1,0],
									 [0,1],
									 [1,0],
									 [0,-1]
								   ];//左上右下
		

		public var path:Array = new Array();
		
		public function PathFind(map:Array,optimize:Boolean){
			this.map  = map;
			this.optimize = optimize;
			mapWidth  = this.map[0].length;
			mapHeight = this.map.length;
			
		}
		
		private function getAround():void{
			
			for(var i:uint=0;i<dirs4.length;i++){
				var nodeX = cNode.x + (int(dirs4[i][0]));
				var nodeY = cNode.y + (int(dirs4[i][1]));
				
				var node:Node = new Node();
				node.x=nodeX;
				node.y=nodeY;
				node.id = nodeY*mapWidth+nodeX;
				
				//如果该相邻节点不可通行或者该相邻节点已经在封闭列表中,则什么操作也不执行,继续检验下一个节点;
				if(node.id<=mapHeight*mapWidth && int(map[node.x][node.y])==0 && !closeList.containsKey(node.id)){//要加入各种验证(是否越界，是否不可行走)
					node.h = (uint(Math.abs(node.x - aNode.x)) + uint(Math.abs(node.y - aNode.y)))*beeValue;
					node.g = cNode.g+beeValue;
					node.f = node.g + node.h;
					var tmpNode :Node = Node(openList.get(node.id));
					if(tmpNode==null){//如果该相邻节点不在开放列表中,则将该节点添加到开放列表中, 并将该相邻节点的父节点设为当前节点,同时保存该相邻节点的G和F值;
						node.parentId = cNode.id;
						openList.put(node.id,node);
					}else if(tmpNode!=null){//如果该相邻节点在开放列表中, 则判断若经由当前节点到达该相邻节点的G值是否小于原来保存的G值,若小于,则将该相邻节点的父节点设为当前节点,并重新设置该相邻节点的G和F值.
						if(node.g<tmpNode.g){
							tmpNode.g = node.g;
							tmpNode.parentId = cNode.id;
						}
					}
					
				}
				
				
			}
			
		}
		
		/**
		 * 入参:
		 * s:开始节点
		 * a:终节点
		 * 返回:路径数组
		 */
		public function pathFind(s:Point,a:Point):void{
			
			sNode = new Node();
			sNode.x = s.y;
			sNode.y = s.x;
			sNode.id = sNode.y*mapWidth+sNode.x;
			
			aNode = new Node();
			aNode.x = a.y;
			aNode.y = a.x;
			aNode.id = aNode.y*mapWidth+aNode.x;
			
			cNode = sNode;
			cNode.id = cNode.y*mapWidth+cNode.x;
			openList.put(cNode.id,cNode);
			getMinF();
			var count:uint = 0;
			while(true && count!=100){
				
				count++;
				getAround();
				if(openList!=null&&openList.size()>=1){
					getMinF();
					if(check()==0){
						//找到了
						findPathInCloseList();
						break;
					}
				}else{
					path = null;
					break;				
				}
				
			}
		
		}
		
		/**
		 * 找到最小的f
		 */
		private function getMinF():void{
			//排序f
				
			var openArray:Array = openList.values();
			var cuNode :Node = null;
				cuNode = openArray[openList.size()-1]; 
				
			for(var i:uint=0 ;i<openArray.length-1;i++){
				var cuNxNode = openArray[i]; 
				if(cuNxNode.f<cuNode.f){
					cuNode = cuNxNode;
				}
			}
			
			openList.remove(cNode.id);
			closeList.put(cNode.id,cNode);
			
			cNode = cuNode;
			
		}
		
		private function findPathInCloseList():void{
			var nodeId:int =-1;
				nodeId = Node(openList.get(aNode.id)).parentId;
				
				path.push(new Point(aNode.y,aNode.x));
			while(nodeId!=-1){
				var node:Node = Node(closeList.get(nodeId));
				path.push(new Point(node.y,node.x));
				nodeId = node.parentId;
			}
			
			
			if(path.length>1){
				path = path.reverse();
			}
			//长度大于3才考虑优化
			if(path.length>=3 && optimize){
				path = optimizeit();
			}
		}
		
		
//		/**
//		 * 优化路径
//		 **/
//		private function optimizeit():Array{
//			trace("进入了optimizeit");
//				var __path:Array = new Array();
//				var _path:Array =  new Array();
//				var tmpList:Array =  new Array();
//				var lastX:int = -1;
//				var lastY:int = -1;
//				
//				//检测x
//				trace("-----------------");
////				_path.push(path[0]);
//				trace("-----"+_path);
//				trace("-----------------");
//				for(var i:uint=1;i<path.length;i++){
//					lastX = path[i-1].x;
//					if(i==1 && path[i].x==lastX){
//						tmpList.push(path[0]);
//						tmpList.push(path[i]);
//					}else if(i==1 && path[i].x!=lastX){
//						_path.push(path[0]);
//						tmpList.push(path[i]);
//					}else if(i!=1 && path[i].x==lastX){
//						tmpList.push(path[i]);
//					}else{
//						tmpList.push(path[i]);
//						
//						if(tmpList.length==1){
//							_path.push(tmpList[0]);
//							trace("add:"+tmpList[0]);
//						}else if(tmpList.length>=2){
//							_path.push(tmpList[0]);
//							_path.push(tmpList[tmpList.length-1]);
//							trace("add1:"+tmpList[0]);
//							trace("add1:"+tmpList[tmpList.length-1]);
//						}else{
//							//
//						}
//						tmpList = null;
//						tmpList  = new Array();
//						trace("_path:"+_path);
//					}
//					
//				}
//				trace("过了循环一");
//				//检测y
//				tmpList =  new Array();
////				__path.push(_path[0]);
//				for(i=1;i<_path.length;i++){
//					lastY = _path[i-1].y;
//					if(i==1 && path[i].y==lastY){
//						tmpList.push(path[0]);
//						tmpList.push(path[i]);
//					}else if(i==1 && path[i].y!=lastY){
//						__path.push(_path[0]);
//						tmpList.push(path[i]);
//					}else if(i!=1 && _path[i].y==lastY){
//						tmpList.push(_path[i]);
//					}else{
//						tmpList.push(_path[i]);
//						if(tmpList.length==1){
//							__path.push(tmpList[0]);
//							trace("2add:"+tmpList[0]);
//						}else if(tmpList.length>=2){
//							__path.push(tmpList[0]);
//							__path.push(tmpList[tmpList.length-1]);
//							trace("2add2:"+tmpList[0]);
//							trace("2add2:"+tmpList[tmpList.length-1]);
//						}else{
//							//
//						}
//						tmpList = null;
//						tmpList = new Array();
//					}
//					trace("__path:"+__path);
//				}
//				trace("过了循环二");
//				
//				trace("优化前路径："+path+"---");
//				trace("优化后路径："+__path+"---");
//				return __path;
//		} 
		/**
		 * 优化路径
		 **/
		private function optimizeit():Array{
				var _path:Array = new Array();
				var __path:Array = new Array();
				
				var aimList :Array = new Array();
				var lastPoint:Point = null;
				var thisPoint:Point = null;
				
				var index:int = 0;
				var _depth:int = path.length;
				_path.push(path[0]);
				while(index<_depth-1){
					index++;
					lastPoint = path[index-1];
					thisPoint = path[index];
						//判断是否最后 一个元素
						if(index==_depth-1){
							if(aimList.length>=1){
								_path.push(aimList[aimList.length-1]);
							}
							_path.push(thisPoint);
							break;
						}
					if(thisPoint.x == lastPoint.x){
						aimList.push(thisPoint);
					}else{
						if(aimList.length>=1){
							_path.push(aimList[aimList.length-1]);
						}
						_path.push(thisPoint);
						aimList = new Array();
					}
				}
				
				var tmpPath:Array = _path.concat();
				if(tmpPath.length>=1){
					
					index = 0;
					var __depth:int = tmpPath.length;
					__path.push(_path[0]);
					while(index<__depth-1){
						index++;
						lastPoint = tmpPath[index-1];
						thisPoint = tmpPath[index];
						
							//判断是否最后 一个元素
							if(index==__depth-1){
								if(aimList.length>=1){
									__path.push(aimList[aimList.length-1]);
								}
								__path.push(thisPoint);
								break;
							}
						if(thisPoint.y == lastPoint.y){
							aimList.push(thisPoint);
						}else{
							if(aimList.length>=1){
								__path.push(aimList[aimList.length-1]);
							}
							__path.push(thisPoint);
							aimList = new Array();
						}
					}
				}
				
				trace("优化前路径："+path+"---");
				trace("优化x路径："+_path+"---");
				trace("优化后路径："+__path+"---");
				return __path;
		} 
		
		private function check():int{
			if(Node(openList.get(aNode.id))!=null){
				return 0;
			}
			return -1;
		}
	}
}