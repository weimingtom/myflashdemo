package MyPathFind
{
	public class Node{
		
		public var x:uint;
		public var y:uint;
		public var parent:Node;
		public var g:uint;
		public var f:uint;
		public var h:uint;
		
		public function Node(){
			trace("Node Created!");
		}
		
	}
}