package {
    import flash.display.Sprite;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.utils.ByteArray;
    import flash.events.Event;
    import flash.geom.Matrix;

	public class TestASP extends Sprite
	{
		
		private var _imageData:BitmapData;    //图片数据
        private var _loader:Loader;    //装载
        
		public function TestASP()
		{
			init();
            sendRequest('page1.jpg');
		}

        //初始化
        private function init():void {
            _imageData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFFFFFFFF);
            _loader = new Loader();
        }
        //发送请求
        private function sendRequest(p_url:String):void {
            var m_request:URLRequest = new URLRequest(p_url);
            var m_loader:URLLoader = new URLLoader();
            m_loader.dataFormat = URLLoaderDataFormat.BINARY;
            m_loader.addEventListener(Event.COMPLETE, onSendComplete);
            m_loader.load(m_request);
        }
        //事件，请求发送完毕
        private function onSendComplete(e:Event):void {
            var m_content:ByteArray = e.target.data as ByteArray;
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            _loader.loadBytes(m_content);
        }
        //事件，装载完毕
        private function onLoadComplete(e:Event):void {
            _imageData.draw(_loader, new Matrix(stage.stageWidth/_loader.width, 0, 0, stage.stageHeight/_loader.height, 0, 0));
            var m_image:Bitmap = new Bitmap(_imageData);
            m_image.scaleX = 2;
            m_image.scaleY = 2;
            this.addChild(m_image);
        }

	}
}
