package MyPathFind
{
	public class Node{
		
		public var x:uint;
		public var y:uint;
		public var parent:Node;
		public var g:uint = 0;
		public var f:uint = 0;
		public var h:uint = 0;
		
		public function Node(){
			trace("Node Created!");
		}
		
	}
}