package {
   import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.text.TextField;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.geom.Matrix;

	public class TestASP extends Sprite
	{
		
        
		public function TestASP()
		{
			  init();
            _rate.text = '开始下载';
            _rate.autoSize = 'center';
            _rate.textColor = 0x000000;
            _rate.x = (stage.stageWidth - _rate.width)/2;
            _rate.y = (stage.stageHeight - _rate.height)/2;
            this.addChild(_rate);
            //sendRequest('page1.jpg');
            sendRequest('http://i0.sinaimg.cn/dy/o/2010-04-13/1271166807_kYawE9.jpg');
		}

         private var _imageData:BitmapData;    //图片
        private var _loader:Loader;    //装载
        private var _rate:TextField;    //进度显示
        public function LoadingDoc() {
          
        }
        //初始化
        private function init() {
            _imageData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFFFFFFFF);
            _loader = new Loader();
            _rate = new TextField();
        }
        //发送请求
        private function sendRequest(p_url:String) {
            var m_request = new URLRequest(p_url);
            _loader.load(m_request);
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
        }
        //事件，下载完毕
        private function onComplete(e:Event) {
            _imageData.draw(_loader, new Matrix(stage.stageWidth/_loader.width, 0, 0, stage.stageHeight/_loader.height, 0, 0));
            var m_image:Bitmap = new Bitmap(_imageData);
            this.removeChild(_rate);
            this.addChild(m_image);
        }
        //事件，下载中
        private function onProgress(e:Event) {
            var m_info:LoaderInfo = e.target as LoaderInfo;
            var m_percent:uint = (m_info.bytesLoaded/m_info.bytesTotal)*100;
            _rate.text = '已经下载'+m_percent.toString()+'%';
        }
 }    
}
