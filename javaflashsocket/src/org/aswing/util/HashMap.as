package org.aswing.util
{
	public class HashMap
	{

			private var length:int;
			private var content:Dictionary;
			private var keyContent:Dictionary;
			
			public function HashMap(){
			length = 0;
			content = new Dictionary();
			keyContent = new Dictionary();
			}
			
			//-------------------public methods--------------------
			
			/**
			* Returns the number of keys in this HashMap.
			*/
			public function size():int{
			return length;
			}
			
			/**
			* Returns if this HashMap maps no keys to values.
			*/
			public function isEmpty():Boolean{
			return (length==0);
			}
			
			/**
			* Returns an Array of the keys in this HashMap.
			*/
			public function keys():Array{
			var temp:Array = new Array(length);
			var index:int = 0;
			for each(var i:* in keyContent){
			temp[index] = i;
			index ++;
			}
			return temp;
			}

}