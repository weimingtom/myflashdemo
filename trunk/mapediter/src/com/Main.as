package com
{
	import flash.display.Sprite;
	
	public class Main extends Sprite
	{
		var table:Table = new Table(1024,768,60,30);
		public function Main(){	
			table.drawTables();
			addChild(table);
		}

	}
}