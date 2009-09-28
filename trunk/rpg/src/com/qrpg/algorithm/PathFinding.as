﻿/*
 * 作者：陈策
 * author: Bill Chen
 * 电邮: billchance@gmail.com
 * email: billchance@gmail.com
 * 版本：v1.1
 * vision: v1.1
 * 日期：2008-01-10
 * data: Jan. 10 2008
 *
 * 使用二分法的A*寻路 
 */

package com.qrpg.algorithm{
	import flash.geom.Point;

	public class PathFinding {

		private var _map:Array;//地图
		private var _w:int;//地图的宽
		private var _h:int;//地图的高
		private var _open:Array;//开放列表
		private var _aveOpen:Number;//开放列表平均值
		private var _starPoint:Object;
		private var _endPoint:Object;
		private var _autoOptimize:Boolean;
		public var path:Array = [];//计算出的路径

		public function PathFinding(map:Array, autoOptimize:Boolean=true) {
			_map = [];
			_w = map[0].length;
			_h = map.length;
			_autoOptimize = autoOptimize;
			for (var y:int=0; y<_h; y++) {
				if (_map[y]==undefined) {
					_map[y] = [];
				}
				for (var x:int=0; x<_w; x++) {
					_map[y][x] = {x:x, y:y, value:map[y][x], block:false, open:false, value_g:0, value_h:0, value_f:0, nodeparent:null, index:-1};
				}
			}
		}
		//四方向寻路
		public function path4(star:Point, end:Point):Array {
			path = [];
			_starPoint = _map[star.y][star.x];
			_endPoint = _map[end.y][end.x];
			var __getEnd:Boolean = false;
			initBlock();

			var __thisNode:Object = _starPoint;
			while (!__getEnd) {
				__thisNode.block = true;
				var __checkList:Array = [];
				if (__thisNode.y>0) {
					__checkList.push(_map[(__thisNode.y-1)][__thisNode.x]);
				}
				if (__thisNode.x>0) {
					__checkList.push(_map[__thisNode.y][(__thisNode.x-1)]);
				}
				if (__thisNode.x<_w-1) {
					__checkList.push(_map[__thisNode.y][(__thisNode.x+1)]);
				}
				if (__thisNode.y<_h-1) {
					__checkList.push(_map[(__thisNode.y+1)][__thisNode.x]);
				}
				//开始检测当前节点周围
				var __len:int = __checkList.length;
				for (var i:int = 0; i<__len; i++) {
					//周围的每一个节点
					var __neighboringNode:Object = __checkList[i];
					//判断是否是目的地
					if (__neighboringNode == _endPoint) {
						__neighboringNode.nodeparent = __thisNode;
						__getEnd = true;
						break;
					}
					//是否可通行
					if (__neighboringNode.value == 0) {
						count(__neighboringNode, __thisNode);//计算该节点
					}
				}
				if (!__getEnd) {
					//如果未找到目的地
					if (_open.length>0) {
						//开发列表不为空，找出F值最小的做为下一个循环的当前节点
						//__thisNode = _open[getMin()];
						__thisNode = getOpen();
					} else {
						//开发列表为空，寻路失败
						return [];
					}
				}
			}
			drawPath();
			if(_autoOptimize){
				optimizePath();
			}
			return path;
		}
		
		//八方向寻路
		public function path8(star:Point, end:Point):Array {
			path = [];
			_starPoint = _map[star.y][star.x];
			_endPoint = _map[end.y][end.x];
			var __getEnd:Boolean = false;
			initBlock();

			var __thisNode:Object = _starPoint;
			while (!__getEnd) {
				__thisNode.block = true;
				var __checkList:Array = [];
				if (__thisNode.x>0 && __thisNode.y>0) {
					__checkList.push(_map[(__thisNode.y-1)][(__thisNode.x-1)]);
				}
				if (__thisNode.y>0) {
					__checkList.push(_map[(__thisNode.y-1)][__thisNode.x]);
				}
				if (__thisNode.x<_w-1 && __thisNode.y>0) {
					__checkList.push(_map[(__thisNode.y-1)][(__thisNode.x+1)]);
				}
				if (__thisNode.x>0) {
					__checkList.push(_map[__thisNode.y][(__thisNode.x-1)]);
				}
				if (__thisNode.x<_w-1) {
					__checkList.push(_map[__thisNode.y][(__thisNode.x+1)]);
				}
				if (__thisNode.x>0 && __thisNode.y<_h-1) {
					__checkList.push(_map[(__thisNode.y+1)][(__thisNode.x-1)]);
				}
				if (__thisNode.y<_h-1) {
					__checkList.push(_map[(__thisNode.y+1)][__thisNode.x]);
				}
				if (__thisNode.x<_w-1 && __thisNode.y<_h-1) {
					__checkList.push(_map[(__thisNode.y+1)][(__thisNode.x+1)]);
				}
				//开始检测当前节点周围
				var __len:int = __checkList.length;
				for (var i:int = 0; i<__len; i++) {
					//周围的每一个节点
					var __neighboringNode:Object = __checkList[i];
					if(_map[__neighboringNode.y][__thisNode.x].value==0 && _map[__thisNode.y][__neighboringNode.x].value==0){
						//如果可通过
						//判断是否是目的地
						if (__neighboringNode == _endPoint) {
							__neighboringNode.nodeparent = __thisNode;
							__getEnd = true;
							break;
						}
						//是否可通行
						if(__neighboringNode.x==__thisNode.x || __neighboringNode.y==__thisNode.y){
							count(__neighboringNode, __thisNode);//计算该节点
						}else{
							if (__neighboringNode.value == 0) {
								count(__neighboringNode, __thisNode, true);//计算该节点
							}
						}
					}
				}
				if (!__getEnd) {
					//如果未找到目的地
					if (_open.length>0) {
						//开发列表不为空，找出F值最小的做为下一个循环的当前节点
						//__thisNode = _open[getMin()];
						__thisNode = getOpen();
					} else {
						//开发列表为空，寻路失败
						return [];
					}
				}
			}
			drawPath();
			if(_autoOptimize){
				optimizePath();
			}
			return path;
		}
		
		//优化路径
		public function optimizePath():Array {
			if(path.length==0){
				return [];
			}
			var __len:int = path.length;
			var __path:Array = [];
			var diagonal:Array = [];
			var __dLen:int;
			var __cross:Boolean = true;
			var __currentNode:Point = path[0];
			__path.push(path[0]);
			for (var i:int=1; i<__len; i++) {
				diagonal = Diagonal.each(__currentNode, path[i]);
				__dLen = diagonal.length;
				__cross = true;
				for (var j:int=0; j<__dLen; j++) {
					if (_map[diagonal[j].y][diagonal[j].x].value == 1) {
						__cross = false;
						break;
					}
				}
				if (!__cross) {
					if (i>1) {
						__currentNode = path[(i-1)];
						__path.push(path[(i-1)]);
					}
				}
			}
			__path.push(path[(__len-1)]);
			path = __path.concat();
			return path;
		}
		
		public function set autoOptimize(value:Boolean):void
		{
			_autoOptimize = value;
		}
		
		public function get autoOptimize():Boolean
		{
			return _autoOptimize;
		}
		
		//寻路前的初始化
		private function initBlock():void {
			for (var y:int=0; y<_h; y++) {
				for (var x:int=0; x<_w; x++) {
					_map[y][x].open = false;
					_map[y][x].block = false;
					_map[y][x].value_g = 0;
					_map[y][x].value_h = 0;
					_map[y][x].value_f = 0;
					_map[y][x].nodeparent = null;
					_map[y][x].index = -1;
				}
			}
			_open = [];
			_aveOpen = 0;
		}
		
		//计算每个节点
		private function count(neighboringNode:Object, centerNode:Object, eight:Boolean=false):void {
			//是否在关闭列表里
			if (!neighboringNode.block) {
				//不在关闭列表里才开始判断
				var __g:Number= eight ? centerNode.value_g+14 : centerNode.value_g+10;
				if (neighboringNode.open) {
					//如果该节点已经在开放列表里
					if (neighboringNode.value_g>=__g) {
						//如果新G值小于或者等于旧值，则表明该路更优，更新其值
						_aveOpen += (_aveOpen-neighboringNode.value_f)/_open.length;
						var __index:int = _open.indexOf(neighboringNode);
						_open.splice(__index,1);
						neighboringNode.value_g = __g;
						ghf(neighboringNode);
						neighboringNode.nodeparent = centerNode;
						setOpen(neighboringNode);
					}
				} else {
					//如果该节点未在开放列表里
					//计算GHF值
					neighboringNode.value_g = __g;
					ghf(neighboringNode);
					neighboringNode.nodeparent = centerNode;
					//添加至列表
					setOpen(neighboringNode);
				}
			}
		}
		
		//画路径
		private function drawPath():void {
			var __pathNode:Object = _endPoint;
			//倒过来得到路径
			while (__pathNode != _starPoint) {
				path.unshift(new Point(__pathNode.x, __pathNode.y));
				__pathNode = __pathNode.nodeparent;
			}
			path.unshift(new Point(__pathNode.x, __pathNode.y));
		}
		
		//计算ghf各值
		private function ghf(node:Object):void {
			var __dx:Number = Math.abs(node.x-_endPoint.x);
			var __dy:Number = Math.abs(node.y-_endPoint.y);
			node.value_h = 10*(__dx+__dy);
			node.value_f = node.value_g+node.value_h;
		}
		
		//加入开放列表
		private function setOpen(newNode:Object):void {
			newNode.open = true;
			var __len:int = _open.length;
			if (__len==0) {
				_open.push(newNode);
				_aveOpen = newNode.value_f;
			} else {
				if (newNode.value_f<_aveOpen) {
					for (var i:int=0; i<__len; i++) {
						if (newNode.value_f<=_open[i].value_f) {
							_open.splice(i, 0, newNode);
							break;
						}
					}
				} else {
					for (var j:int=__len; j>0; j--) {
						if (newNode.value_f>=_open[(j-1)].value_f) {
							_open.splice(j, 0, newNode);
							break;
						}
					}
				}
				_aveOpen += (newNode.value_f-_aveOpen)/_open.length;
			}
		}
		
		//取开放列表里
		private function getOpen():Object {
			var __next:Object =  _open.splice(0,1)[0];
			_aveOpen += (_aveOpen-__next.value_f)/_open.length;
			return __next;

		}
		
		//得到开放列表里拥有最小F值的节点在列表里的位置
		private function getMin():int {
			var __len:int = _open.length;
			var __f:Number = _open[0].value_f;
			var __i:int = 0;
			for (var i:int=1; i<__len; i++) {
				if (__f>_open[i].value_f) {
					__f = _open[i].value_f;
					__i = i;
				}
			}
			return __i;
		}
		
		public function value(px:int, py:int):int
		{
			return _map[py][px].value;
		}
	}
}