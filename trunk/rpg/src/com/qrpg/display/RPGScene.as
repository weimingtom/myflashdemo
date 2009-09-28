/*
 * 作者：陈策
 * author: Bill Chen
 * 版本：v1.0
 * vision: v1.0
 * 日期：2007-12-25
 * data: 2007-12-25
 */
 
package com.qrpg.display
{
	import com.qrpg.events.GameEvent;
	import com.qrpg.events.GameEventDispatcher;
	import flash.display.Sprite;
	import flash.display.*
	public class RPGScene extends Sprite 
	{
		private var _background:Sprite;
		private var _contain:Sprite;
		private var _front:Sprite;
		private var _ss:Sprite
		public function RPGScene():void
		{
			super();
			_background = new Sprite();
			_contain = new Sprite();
			_front = new Sprite();
			_ss=new Sprite()
			addChild(_background);
			addChild(_ss)
			addChild(_contain);
			addChild(_front);
		}
		public function addss(str:MovieClip){
			_ss.addChild(str)
			return str
		}
		public function addBg(child:Item):Item//bg添加子mc
		{
			_background.addChild(child);
			child.setScene();
			return child;
		}
		
		public function addBgAt(child:Item, index:int):Item//bg添加子mc到哪个层
		{
			_background.addChildAt(child, index);
			child.setScene();
			return child;
		}		
		public function addContain(child:Item):Item//中间添加子mc
		{
			var __numChildren:int = _contain.numChildren;
			var __add:Boolean = false;
			var i:int;

			if(child.y>0){
				for(i=__numChildren-1;i>=0;i--){
					if(child.y>=_contain.getChildAt(i).y){
						_contain.addChildAt(child, i+1);
						__add = true;
						break;
					}
				}
				if(!__add){
					_contain.addChildAt(child, 0);
				}
			}else{
				for(i=0;i<__numChildren;i++){
					if(child.y<=_contain.getChildAt(i).y){
						_contain.addChildAt(child, i);
						__add = true;
						break;
					}
				}
				if(!__add){
					_contain.addChild(child);
				}
			}

			child.setScene();
			child.events.addEventListener(GameEventDispatcher.ON_MOVE, checkDepth);//监听层移动中 层的深度变化事件
			return child;
		}
		
		public function addFront(child:Item):Item
		{
			_front.addChild(child);
			child.setScene();
			return child;
		}
		public function removeFront(child:Item):void
		{
			_contain.removeChild(child);//移除mc
			child.setScene();
			
		}
				
		public function addFrontAt(child:Item, index:int):Item
		{
			_front.addChildAt(child, index);//添加到特定层深
			child.setScene();
			return child;
		}
		
		private function checkDepth(e:GameEvent):void
		{    //trace("e.ower:"+e.ower)
			var __currentChild:Item = e.ower;
			var __currentIndex:int = _contain.getChildIndex(__currentChild);//取得中间层里边的人物深度
			if(__currentChild.getFace()){//当前人物是 向下行走
				while(__currentIndex<_contain.numChildren-1){//如果当前人物的深度小于最高深度
					if(__currentChild.y>_contain.getChildAt(__currentIndex+1).y){//如果当前人物的y值大于当前人物深度＋1的物体的y值
						_contain.swapChildrenAt(__currentIndex, __currentIndex+1);//则交换两者的深度值 让当前人物深度增加
						__currentIndex++;//当前人物深度代表变量也加1
					}else{
						break;
					}
				}
			}else{//当前人物是向上行走
				while(__currentIndex>0){
					if(__currentChild.y<_contain.getChildAt(__currentIndex-1).y){//和上边同理
						_contain.swapChildrenAt(__currentIndex, __currentIndex-1);
						__currentIndex--;
					}else{
						break;
					}
				}
			}
		}
	}
}