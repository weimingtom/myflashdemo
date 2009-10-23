package MyPathFind
{
	public class PathFind{
		private var beeValue = 10 ; //直线值
//		private var  biasValue = 10 ;
		
		public var map:Array;//地图
		private var mapWidth:uint; 
		private var mapHeight:uint; 
				
		public var cNode:Node;//当前节点
		public var sNode:Node;//起始节点
		public var aNode:Node;//终节点
		
		public var openList:Array = new Array();//开放列表
		public var closeList:Array = new Array();//关闭列表
		
//		private var 8dirs:Array =  [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]];
		private var dirs4:Array =  [[-1,0],[0,1],[1,0],[0,-1]];//左上右下
		
		private var tmpAroundNodeList:Array = null;//临时用周围节点列表
		
		public function PathFind(map:Array){
			this.map  = map;
			mapWidth  = this.map[0].length;
			mapHeight = this.map.length;
			//pathFind();
		}
		

		private function getAround(node:Node):Array{
			var array:Array = new Array();
			tmpAroundNodeList = null;
			cNode = node;
			
			for(var i:uint=0;i<dirs4.length;i++){
				var tmpNode:Node = new Node();
				tmpNode.x = cNode.x + (int(dirs4[i][0]));
				tmpNode.y = cNode.y + (int(dirs4[i][1]));
				array.push(tmpNode);
			}
		}
		
		/**
		 * 入参:
		 * s:开始节点
		 * a:终节点
		 * 返回:路径数组
		 */
		public function pathFind(s:Node,a:Node):Array{
			var path:Array = new Array();
			
			sNode = snode;
			aNode = anode;
			
			cNode = sNode;
			var aroundList:Array = getAround(cNode);
			
			 			
						
			
		
		}
		
		private function fghSet(aroundList:Array):Array{
			for each(var node:Node in aroundList){
				node.parent = cNode;
				node.h = (uint(Math.abs(node.x - aNode.x)) + uint(Math.abs(node.y - aNode.y)))*beeValue;
				node.g = cNode.g+beeValue;
				node.f = node.g + node.h;
				
			}
		}
		
		
	}
}