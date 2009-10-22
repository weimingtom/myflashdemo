package
{
	import flash.display.MovieClip;
	
	public class Table extends MovieClip
	{
		public function Table(){
			drawTables();
		}
		
		public function drawTables(){
			
			this.graphics.beginFill(Constant.COLOR_2);
			this.graphics.lineStyle(2, Constant.COLOR_2, 1.0, false,  "normal",  null,  null,  3);
			
			for(var i:uint=0;i<=16;i++){
				this.graphics.moveTo(0*40,i*40);
		        this.graphics.lineTo(16*40,i*40);
			}
			
			for(var j:uint=0;j<=16;j++){
				this.graphics.moveTo(j*40,0*40);
		        this.graphics.lineTo(j*40,16*40);
			}
	        this.graphics.endFill();
		}
	}
}