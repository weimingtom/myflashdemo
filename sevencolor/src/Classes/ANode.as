package Classes{
	public class ANode extends Object{
		public var pid:int;
		public var id:int;
		public var pos:Array;
		public var G:int;
		public var H:int;
		public var F:int;
		public var block:int;//1 is block,0 is pass
		public function ANode(_pos:Array, _id:int, _block:int = 0, _pid:int=0){
			id = _id;
			pid = _pid;
			pos = _pos;
			block = _block;
			
			G = 0;
			H = 0;
			F = 0;
		}
		
	}
}