package Classes{
	import flash.display.Sprite;
	
	public class Tile extends Sprite{
		static public const W:Number	= 15;
		static public const H:Number	= 15;
		static public const GROUND:uint 	= 0;
		static public const BRICK:uint 	= 1;
		static public const CEMENT:uint 	= 2;
		static public const WATER:uint	= 3;
		static public const TREE:uint		= 4;		
		
		private var _isblock:Boolean;
		private var _type:uint;
		
		public var wIndex:int;
		public var hIndex:int;
		
		static public function buildTile(type:int):Tile{
			var tile:Tile;
			switch(type){
				case Tile.BRICK:
					tile = new Brick();
					break;
				case Tile.CEMENT:
					tile = new Cement();
					break;
				case Tile.TREE:
					tile = new Tree();
					break;
				case Tile.WATER:
					tile = new Water();
					break;
				default:
					tile = new Ground();
					break;
			}
			tile.Type = type;
			return tile;
		}
		/*
		static public function canPass(type:int):Boolean{
			var bpass:Boolean = true;											 
			switch(type){
				case Tile.CEMENT:
					bpass = false;
					break;
				case Tile.BRICK:
					bpass = false;
					break;
				case Tile.WATER:
					bpass = false;
					break;
				case Tile.TREE:
					bpass = true;
					break;
				default:
					bpass = true;
					break;
			}
    		return bpass;
		}				*/
				
		public function set Type(value:uint):void{
			_type = value;
			switch(_type){
				case Tile.CEMENT:
					this.bBlock = true;
					break;
				case Tile.BRICK:
					this.bBlock = true;
					break;
				case Tile.WATER:
					this.bBlock = true;
					break;
				case Tile.TREE:
					this.bBlock = false;
					break;
				default:
					this.bBlock = false;
					break;					
			}
		}
		public function get Type():uint{
			return _type;
		}
		
		public function set bBlock(value:Boolean):void{
			_isblock = value;
		}
		public function get bBlock():Boolean{
			return _isblock;
		}
	}
}