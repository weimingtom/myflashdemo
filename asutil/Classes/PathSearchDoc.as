package Classes{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	public class PathSearchDoc extends MovieClip{
		//场景对象
		private var scene:Sprite;
		//角色
		private var tank:Tank;
		//旗帜
		private var flag:Sprite;
		//地图尺寸
		private var mapwidth:int;
		private var mapheight:int;
		//地图数组
		private var aNodeMap:Array;
		//A*算法实例
		private var astar:AStar;
		//移动属性
		private var bMove:Boolean;
		//路径数组
		private var aPath:Array;
		//路径数组指针
		private var pathpoint:int;		
		//提示文本
		private var txtState:TextField;
		//当前节点
		private var crtNode:ANode;
		//构造函数
		public function PathSearchDoc(){
			bMove = false;
			aPath = new Array();
			pathpoint = 0;
			aNodeMap = new Array();
			mapwidth = Map.aSampleMap[0].length;
			mapheight = Map.aSampleMap.length;			
			//创建场景
			scene = new Sprite();
			scene.x = 10;
			scene.y = 40;
			//创建旗帜
			flag = new Flag();
			flag.visible = false;
			//创建角色
			tank = new Tank();
			scene.addChild(flag);
			scene.addChild(tank);
			addChild(scene);
			initMap();			
			createTextField();
			//为场景添加事件侦听器
			scene.addEventListener(MouseEvent.MOUSE_DOWN,setFlag);
			//为角色添加事件侦听器
			tank.addEventListener(Event.ENTER_FRAME,DoMove);
		}
		//创建提示文本
		private function createTextField():void{
			txtState = new TextField();
			txtState.selectable = false;
			txtState.textColor = 0xffffff;
			txtState.width = 200;
			txtState.x = 10;
			txtState.y = 10;
			txtState.height = 20;
			addChild(txtState);
		}
		//初始化地图
		private function initMap():void{
			var i:uint,j:uint,type:int;
			var hlen:uint = Map.aSampleMap[0].length;
			var vlen:uint = Map.aSampleMap.length;
			for( i= 0;i<vlen;i++){
				aNodeMap[i] = new Array();
				for(j = 0;j<hlen;j++){
					type = int(Map.aSampleMap[i][j]);
					var tile:Tile = Tile.buildTile(type);
					tile.Type = type;
					tile.wIndex = j;
					tile.hIndex = i;
					tile.x = j * Tile.W;
					tile.y = i * Tile.H;
					scene.addChild(tile);
					if(type == Tile.GROUND)
						scene.setChildIndex(tile,0);						
					aNodeMap[i][j] = tile.bBlock?1:0;
				}
			}
			//创建A*算法类实例
			astar = new AStar(aNodeMap);
			//设置起始节点
			astar.ndStart = new ANode([1,1],26);
			//当前节点与起始节点在同一位置
			astar.ndCurrent = new ANode([1,1],26);
			tank.x = Tile.W ;
			tank.y = Tile.H;
			scene.setChildIndex(flag,scene.numChildren - 1);
			scene.setChildIndex(tank,scene.numChildren - 1);
		}
		//设置旗帜（目标节点）
		private function setFlag(e:MouseEvent):void{
			//如果单击对象是Tile类型的
			if(e.target is Tile){
				var obj:Tile = e.target as Tile;
				//如过不可通行，返回
				if(obj.bBlock)
					return;
				bMove = false;
				aPath = [];
				var dx:int = int(tank.x/Tile.W);
				var dy:int = int(tank.y/Tile.H);
				flag.visible = true;
				flag.x = obj.x;
				flag.y = obj.y			
				astar.ndCurrent = new ANode([dx,dy],dy * mapwidth + dx);
				astar.ndStart = astar.ndCurrent;
				astar.ndEnd = new ANode([obj.wIndex,obj.hIndex],obj.hIndex * mapwidth + obj.wIndex);
				//如果找到路径
				if(astar.DoSearch()){						
					txtState.text = "已找到路径！";
					bMove = true;
					aPath = astar.aPath;
					pathpoint = aPath.length-1;
				}
				//如果没有找到
				else{						
					txtState.text = "超出检测范围或无法到达";
				}														
			}
		}
		//移动角色
		private function DoMove(e:Event):void{
			if(bMove){				
				if(!aPath)
					return;
				if(pathpoint >= 0){
					tank.x = aPath[pathpoint][0] * Tile.W;
					tank.y = aPath[pathpoint][1] * Tile.H;					
					pathpoint--;
				}else{
					bMove = false;
				}
			}
		}
		
	}
}