/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-19
 * data: 2007-12-19
 */

/*
 @ Item(url:String, width:int=100, height:int=100, cx:int=-1, cy:int=-1):void
   创造一个Item
   url: 图片地址
   width: 物品宽
   height: 物品高
   cx: 物品中心点距左上角X方向的距离，-1为宽的一半
   cy: 物品中心点距左上角Y方向的距离，-1为高的一半
   
 @ setFrame(hState:int, vState:int):void
   换显示的图片
   hState: 水平方向序号
   vState: 垂直方向序号
   
 @ getFrameX():int
 @ getFrameY():int
   得到显示的图片的水平垂直方向的序号 
   
 @ place(px:Number, py:Number):void
   放置Item
   px: X座标
   py: Y座标
   
 @ mirror(scale:int=1):void
   水平翻转
   scale: 接受的值为1和-1,分别代表不翻转和翻转
 */
package com.qrpg.display{
	import com.qrpg.events.GameEventDispatcher;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.geom.Rectangle;

	//import mx.core.IUIComponent;
	///import mx.core.IFlexDisplayObject;
	//import mx.managers.ISystemManager;

	public class Item extends Sprite {
		public var events:GameEventDispatcher;

		protected var _face:Boolean;

		private var _item:Sprite;
		private var _loader:Loader;
		private var _image:String;
		private var _roleWidth:int;
		private var _roleHeight:int;
		private var _cx:int;//
		private var _cy:int;
		private var _mask:Sprite;
		private var _frameX:int;
		private var _frameY:int;
		private var _scene:DisplayObject;

		public function Item(url:String,  width:int=100, height:int=100, cx:int=-1, cy:int=-1):void {
			events = new GameEventDispatcher();

			_face = true;
			_image = url;
			_roleWidth = width;
			_roleHeight = height;
			_cx = cx<0 ? width/2 : cx;//小于0则为宽的一半 大则 为cx
			_cy = cy<0 ? height/2 : cy;
			_frameX = 0;
			_frameY = 0;

			_item = new Sprite();
			addChild(_item);
			_loader = new Loader();
			_loader.x = -_cx;
			_loader.y = -_cy;
			_item.addChild(_loader);
			_loader.load(new URLRequest(_image));

			_mask = new Sprite();
			_mask.graphics.lineStyle();
			_mask.graphics.beginFill(0,1);
			_mask.graphics.drawRect(-_cx,-_cy,_roleWidth,_roleHeight);
			_mask.graphics.endFill();
			_loader.mask = _mask;
			_item.addChild(_mask);
		}
		public function setFrame(hState:int, vState:int):void {
			_frameX = hState;
			_frameY = vState;
			_loader.x = -_frameX*_roleWidth-_cx;
			_loader.y = -_frameY*_roleHeight-_cy;
		}
		public function setScene():DisplayObject {
			_scene = this.parent.parent;
			return _scene;
		}
		public function getScene():DisplayObject {
			return _scene;
		}
		public function place(px:Number, py:Number):void {
			x = px;
			y = py;
		}
		public function mirror(scale:int=1):void {
			_item.scaleX = scale;
		}
		public function getFrameX():int {
			return _frameX;
		}
		public function getFrameY():int {
			return _frameY;
		}
		public function getFace():Boolean {
			return _face;
		}
	}
}