package MyPathFind
{
	import com.data.map.HashMap;
	
	import flash.geom.Point;
	
	public class PathFindv1{
		private var debugger:MonsterDebugger = new MonsterDebugger(this);
		
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
		
		public function PathFindv1(map:Array){
			this.map  = map;
			mapWidth  = this.map[0].length;
			mapHeight = this.map.length;
			
		}
		
//		private function initNodes(){
//			for(var i:uint=0;i<mapWidth;i++){
//				for(var j:uint=0;j<mapHeight;j++){
//					var node:Node = new Node();
//					node.x = i;
//					node.y = j;
//					if(map[node.x][node.y]==0){
//						node.status = 0;
//					}else{
//						node.status = 1;
//					}
//					mapNodes.put(i+"-"+j,node)
//				}
//			}
//		}

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
//						trace("ddd");
//						trace("node:"+node.id);
//						trace("ddd");
//						trace("ttt");
//						trace("tmpNode:"+tmpNode);
//						trace("ttt");
//						trace("eee");
//						trace("cNode:"+cNode);
//						trace("eee");
					if(tmpNode==null){//如果该相邻节点不在开放列表中,则将该节点添加到开放列表中, 并将该相邻节点的父节点设为当前节点,同时保存该相邻节点的G和F值;
						node.parentId = cNode.id;
						openList.put(node.id,node);
					}else if(tmpNode!=null){//如果该相邻节点在开放列表中, 则判断若经由当前节点到达该相邻节点的G值是否小于原来保存的G值,若小于,则将该相邻节点的父节点设为当前节点,并重新设置该相邻节点的G和F值.
						if(node.g<tmpNode.g){
//							trace("ddd");
//							trace("tmpNode:"+tmpNode.id);
//							trace("tmpNode:"+tmpNode.g);
//							trace("node:"+node.id);
//							trace("node:"+node.g);
//							trace("ddd");
							tmpNode.g = node.g;
							tmpNode.parentId = cNode.id;
						}
					}
					
				}
				
				
			}
//					MonsterDebugger.trace(this,Node(openList.get(50)),0xFF0000);	
			
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
			fghSet();
			var count:uint = 0;
			while(true && count!=100){
				
				count++;
				getAround();
				if(openList!=null&&openList.size()>=1){
					fghSet();
					if(check()==0){
						trace("找到了！");
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
		 * 设置各个节点的fgh值 并找出一个最小的
		 */
		private function fghSet():void{
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
			MonsterDebugger.trace(this,openList,0xFF0000);
			var nodeId:int =-1;
				nodeId = Node(openList.get(aNode.id)).parentId;
			while(nodeId!=-1){
				var node:Node = Node(closeList.get(nodeId));
				path.push(new Point(node.y,node.x));
				nodeId = node.parentId;
			}
			if(path.length>1){
				path = path.reverse();
			}
		}
		
		private function check():int{
			if(Node(openList.get(aNode.id))!=null){
				return 0;
			}
			return -1;
		}
		
		
	}
}