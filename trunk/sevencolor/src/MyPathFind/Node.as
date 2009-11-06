package MyPathFind
{
	public class Node{
		public var id:uint;
		public var x:uint;
		public var y:uint;
		public var parentId:int=-1;
		public var g:uint = 0;
		public var f:uint = 0;
		public var h:uint = 0;
		
		public var status:uint = 0;//当前节点状态
		
		public function Node(){
			//trace("Node Created!");
		}
		
	}
}