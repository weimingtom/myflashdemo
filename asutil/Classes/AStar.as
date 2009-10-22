package Classes{
	import flash.geom.Point;
	/*
	 * A* 寻路算法
	 * 
	 * @author Dingo
	 * @version 1.0
	 * @date 070831
	 */
	public class AStar {
		//垂直或水平移动一格的代价
		private const COST_STRAIGHT:int = 10;
		//斜向移动一格的代价
		private const COST_DIAGONAL:int = 14;
		//起始节点ANode
		public var ndStart:ANode;
		//目标节点ANode
		public var ndEnd:ANode;
		//当前节点ANode
		public var ndCurrent:ANode;
		//最大寻路步数限制
		private var nMaxTry:int;
		//尝试次数计数器
		private var nCrtTry:int;
		//开放表，元素为ANode类型
		private var aOpenList:Array;
		//关闭表，元素为ANode类型
		private var aCloseList:Array;
		//八个方向数组，从节点正上方开始，顺时针排列
		private const aDir:Array = [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]];
		//地图节点数组
		public var aNodeMap:Array = [];
		//地图大小
		public var mapwidth:int;
		public var mapheight:int;
		//记录节点在aOpenList数组的位置
		private var num:int;
		//路径数组
		public var aPath:Array;
		//是否找到路径
		public var bPathFind:Boolean;
		//构造函数
		public function AStar(amap:Array) {
			nMaxTry = 600;
			nCrtTry = 0;
			Init();
			mapwidth = amap[0].length;
			mapheight = amap.length;
			aNodeMap = amap;
		}
		//初始化
		public function Init():void{
			bPathFind = false;
			aOpenList = [];
			aCloseList = [];
			aPath = [];				
		}
		//添加到open表
		public function addFirstOpen():void{
			aOpenList.push(ndStart);
		}
		//取得指定点周围可通过的点，从正上方开始
		private function GetRound(apos:Array):Array{
			var arr:Array = new Array();
			for(var i:int=0;i<aDir.length;i++){
				var xp = apos[0] + aDir[i][0];
				var yp = apos[1] + aDir[i][1];
				if(IsOutRange([xp,yp]) || IsStart([xp,yp]) || !IsPass([xp,yp]) || IsCorner([xp,yp]) || IsInClose([xp,yp]))
					continue
				arr.push([xp,yp]);				
			}			
			return arr;
		}		
		//是否超出地图范围
		private function IsOutRange(apos:Array):Boolean{
			if(apos[0]<0 || apos[0] >= mapwidth || apos[1] < 0 || apos[1]>= mapheight)
				return true;
			return false;
		}		
		//是否是起点
		private function IsStart(apos:Array):Boolean{ 
    		if(apos[0] == ndStart.pos[0] && apos[1] == ndStart.pos[1])
       			return true;
    		return false;
		}
		//是否可以通过		
		private function IsPass(apos:Array):Boolean{ 
			if(IsOutRange(apos)){
				return false;
			}else{	
				return (aNodeMap[apos[1]][apos[0]]>0?false:true);
			}
		}				
		//是否是拐角
		private function IsCorner(apos:Array):Boolean{
			if(IsPass(apos)){
				if(apos[0] > ndCurrent.pos[0]){
					if(apos[1] > ndCurrent.pos[1]){
						if(!IsPass([apos[0] - 1,apos[1]]) || !IsPass([apos[0],apos[1] - 1]))
							return true;
					}
					else if(apos[1] < ndCurrent.pos[1]){
						if(!IsPass([apos[0] - 1,apos[1]]) || !IsPass([apos[0],apos[1] + 1]))
							return true;
					}
				}
				else if(apos[0] < ndCurrent.pos[0]){
					if(apos[1] > ndCurrent.pos[1]){
						if(!IsPass([apos[0] + 1,apos[1]]) || !IsPass([apos[0],apos[1] - 1]))
							return true;
					}
					else if(apos[1] < ndCurrent.pos[1]){
						if(!IsPass([apos[0] + 1,apos[1]]) || !IsPass([apos[0],apos[1] + 1]))
							return true;
					}
				}
			}
			return false;
		}
		//是否在开启列表中
		//获得传入参数在aOpenlist数组的位置，如不存在返回false，存在为true，位置索引保存到变量num中。
		private function IsInOpen(apos:Array):Boolean{
    		var bool:Boolean = false;
			var id = apos[1] * mapwidth + apos[0];
    		for(var i=0;i<aOpenList.length;i++){
        		if(aOpenList[i].id == id){
          			bool = true;
					num = i;
					break;
				}
   			}
    		return bool;
		}
		//是否在关闭列表中
		private function IsInClose(apos:Array):Boolean{
			var bool:Boolean = false;
			var id = apos[1] * mapwidth + apos[0];
    		for(var i=0;i<aCloseList.length;i++){
        		if(aCloseList[i].id == id){
            		bool=true;
					break;
				}
    		}
    		return bool;
		}
		//取得F值，参数为某一节点周围的节点
		private function GetF(around:Array):void{ 
		    //F,综合的距离值；
			//H,给定节点到目标点的距离值；
			//G,起点到给定节点的距离值
			var F:int,H:int,G:int;
			var apos:Array;
			for(var i:int = 0;i < around.length;i++){					
				apos = around[i];					
				//是否与起点在同一直线上
				if(apos[0] == ndStart.pos[0] || apos[1] == ndStart.pos[1]){
					G = ndCurrent.G + COST_STRAIGHT;
				}else{
					G = ndCurrent.G + COST_DIAGONAL;
				}
				//如果当前点已存在aOpenlist数组中
				if(IsInOpen(apos)){
					var opos:ANode = aOpenList[num] as ANode;
					//如果当前点G值更小，更改父节点
					if(G<opos.G){
						opos.F = G + opos.H;
						opos.G = G;
						opos.pid = ndCurrent.id;
					}else{
						G = opos.G;
					}
				}
				//否则将当前点添加到aOpenList数组
				else{
					H = (Math.abs(ndEnd.pos[0] - apos[0]) + Math.abs(ndEnd.pos[1] - apos[1])) * COST_STRAIGHT;
					F= G + H;
					var newnode:ANode = new ANode(apos,apos[1] * mapwidth + apos[0],0,ndCurrent.id);
					newnode.F = F;
					newnode.G = G;
					newnode.H = H;
					aOpenList.push(newnode);
				}			
			}
		}
		//搜索路径
		public function DoSearch():Boolean{
			aOpenList = [];
			aCloseList = [];
			addFirstOpen();			
			while(aOpenList.length){
				nCrtTry ++ ;
				//如果超出寻路步数限制
				if(nCrtTry > nMaxTry){
					destroyData();
					return false;			
				}
				GetF(GetRound(ndCurrent.pos));
				//按照F值由大到小的顺序排列开启列表
				aOpenList.sortOn("F",Array.NUMERIC | Array.DESCENDING);
				//将开启列表最后一位元素列入关闭列表
				var lastNode:ANode = aOpenList[aOpenList.length - 1];
				aCloseList.push(lastNode);				
				ndCurrent = lastNode;
				if(aOpenList.length>1)
					aOpenList.pop();
				//如果当前节点是目标节点，路径找到，返回true
				if(ndCurrent.id == ndEnd.id){					
					aPath = GetPath();
					destroyData();
					bPathFind = true;
					ndStart = ndCurrent;					
					return true;
				}
			}
			bPathFind = false;
			destroyData();
			aPath = [];
			return false;
		}
		//清空各数组
		private function destroyData():void{
			aOpenList = [];
			aCloseList = [];
			nCrtTry = 0;			
		}
		//取得路径数组
		private function GetPath():Array{
    		var apath:Array = [];
    		var tmpnode:ANode = aCloseList[aCloseList.length-1] as ANode;
			apath.push(tmpnode.pos);
			var inc:int = 0;
			while(inc <= aCloseList.length){
				inc++
				for(var i:int = 0;i<aCloseList.length;i++){
					if(aCloseList[i].id == tmpnode.pid){
						tmpnode = aCloseList[i];
						apath.push(tmpnode.pos)
					}
					if(tmpnode.id == ndStart.id)
						break;
				}
			}
			return apath;
		}		
	}
}