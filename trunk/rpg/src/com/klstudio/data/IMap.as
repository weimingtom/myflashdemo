package com.data{  
        public interface IMap{  
                function clear():void;  
                function containsKey(key:Object):Boolean;  
                function containsValue(value:Object):Boolean;  
                function get(key:Object):Object;  
                function put(key:Object,value:Object):Object;  
                function remove(key:Object):Object;  
                function putAll(map:IMap):void;  
                function size():uint;  
                function isEmpty():Boolean;  
                function values():Array;  
                function keys():Array;  
        }  
}  