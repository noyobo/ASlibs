package com.noyobo.data
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.EventDispatcher;
	import flash.system.System;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author noyobo
	 */
	public class XmlData extends EventDispatcher {
		public var dataUrl:String;
		public var data:Object;
		
		public function XmlData() {
			
		}
		
		public function loadData(value:String):void {
			var requestUrl:URLRequest = new URLRequest(value);	
			var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, completeDefaultFunc);
				loader.addEventListener(Event.OPEN, openDefaultFunc);
				loader.addEventListener(IOErrorEvent.IO_ERROR, errorDefaultFunc);
				loader.load(requestUrl);
		}
		
		private function completeDefaultFunc(event:Event = null):void {
			data = event.target.data;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function openDefaultFunc(evnet:Event = null):void {
			dispatchEvent(new Event(Event.OPEN));
		}
		
		private function errorDefaultFunc(evnet:Event = null):void {
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
	}
	
}