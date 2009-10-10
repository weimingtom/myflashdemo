package findpath{

	public class ArrayBinaryHeaps {

		private var _value:Array;
		public var length:int;

		public function ArrayBinaryHeaps() {
			_value = [];
			length = 0;
		}

		//加入一个元素
		public function push(obj:Object):int {
			_value.push(obj);
			length = _value.length;
			obj.index = length;
			var __index:int = obj.index;
			var __parent:int;
			while (__index > 1) {
				__parent = __index / 2;
				if (_value[(__index-1)].value_f < _value[(__parent-1)].value_f) {
					changeIndex(__index, __parent);
				} else {
					break;
				}
				__index = __parent;
			}
			return length;
		}

		//检验某个元素的值
		public function check(index:int):int {
			var __index:int = index;
			var __parent:int;
			while (__index > 1) {
				__parent = __index / 2;
				if (_value[(__index-1)].value_f < _value[(__parent-1)].value_f) {
					changeIndex(__index, __parent);
				} else {
					break;
				}
				__index = __parent;
			}
			return __index;
		}


		//弹出第一个元素
		public function shift():Object {
			var __first:Object = _value.shift();
			length = _value.length;
			if (length>0) {
				var __index:int = 1;
				var __child:int = __index*2;
				_value.unshift(_value.pop());
				_value[0].index = 1;

				while (__child<=length) {

					var c1:Number = _value[(__child-1)].value_f;
					var id:Number = _value[(__index-1)].value_f;
					if (__child+1<=length) {
						var c2:Number = _value[__child].value_f;
						if (c1<=c2) {
							if (c1<id) {
								changeIndex(__index, __child);
							} else {
								break;
							}
							__index = __child;
						} else {
							if (c2<id) {
								changeIndex(__index, (__child+1));
							} else {
								break;
							}
							__index = __child+1;
						}
					} else {
						if (c1<id) {
							changeIndex(__index, __child);
						} else {
							break;
						}
						__index = __child;
					}
					__child = __index*2;
				}
			}
			return __first;
		}

		//交换数组里两个元素的位置
		private function changeIndex(para1:int,para2:int):void {
			var __obj1:Object = _value[(para1-1)];
			var __obj2:Object = _value[(para2-1)];
			var __index:Number = __obj1.index;
			__obj1.index = __obj2.index;
			__obj2.index = __index;
			_value.splice((para1-1), 1, __obj2);
			_value.splice((para2-1), 1, __obj1);
		}
	}
}