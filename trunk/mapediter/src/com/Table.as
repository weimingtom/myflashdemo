package com
{
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	
	public class Table extends Sprite
	{
		//行格子数
		var xN:uint=16;
		//列格子数
		var yN:uint=8;
		//行宽
		var xW:uint=50;
		//列高
		var yH:uint=10;
		
		public function Table(mapW:uint,mapH:uint,xW:uint,yH:uint){
			super();
			this.xW = xW;
			this.yH = yH;
			this.xN = mapW / this.xW;
			this.yN = mapH / this.yH;
			
			var array : Array  =  new Array();
			for(var i:uint = 0 ; i<xN ;i++){
				array[i] = new Array();
				for(var j:uint = 0 ; j<yN ;j++){
					array[i][j] = 0;
				}
			}
			
			Constant.mapArray = array;
			array = null;
			trace(Constant.mapArray.toString());
			
			drawTables();
		}
		
		public function drawTables():void{
			
			this.graphics.beginFill(Constant.COLOR_2);
			this.graphics.lineStyle(1, Constant.COLOR_3, 0.5, false,  "normal",  null,  null,  3);
			
			for(var i:uint=0;i<=yN;i++){
				this.graphics.moveTo(0,i*yH);
		        this.graphics.lineTo(xN*xW,i*yH);
			}
			
			for(var j:uint=0;j<=xN;j++){
				this.graphics.moveTo(j*xW,0);
		        this.graphics.lineTo(j*xW,yN*yH);
			}
	        this.graphics.endFill();
		}
	}
}