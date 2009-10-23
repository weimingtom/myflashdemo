package MyPathFind
{
	public class PathFind{
		
		public var map:Array;//地图
		public var cNode:Node;//当前节点
		public var sNode:Node;//起始节点
		public var aNode:Node;//终节点
		
		public var openList:Array;//开放列表
		public var closeList:Array;//关闭列表
		
		private var 8dirs:Array =  [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]];
		private var 4dirs:Array =  [[0,-1],[1,0],[0,1],[-1,0]];
		
		private var tmpAroundNodeList:Array = null;//临时用周围节点列表
		
		public function PathFind(map:Array){
			this.map = map;
		}

		public function getAround(node:Node):Array{
			tmpAroundNodeList = null;
			cNode = node;
			
		}
		
	}
}