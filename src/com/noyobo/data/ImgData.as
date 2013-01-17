package com.noyobo.data
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.events.EventDispatcher;
	import flash.system.System;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author noyobo
	 */
	public class ImgData extends EventDispatcher {
		public var dataUrl:String;
		public var dataImg:Object;
		private var _index:int;
		
		public function ImgData() {
			
		}
		
		public function loadData(value:String):void {
			var requestUrl:URLRequest = new URLRequest(value);	
			var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.INIT, completeDefaultFunc);
				loader.contentLoaderInfo.addEventListener(Event.OPEN, openDefaultFunc);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorDefaultFunc);
				loader.load(requestUrl , new LoaderContext(true));
		}
		
		private function completeDefaultFunc(event:Event = null):void {
			dataImg = event.currentTarget.loader;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function openDefaultFunc(evnet:Event = null):void {
			dispatchEvent(new Event(Event.OPEN));
		}
		
		private function errorDefaultFunc(evnet:Event = null):void {
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		
		public function set index(value:int):void {
			_index = value;
		}
		
		public function get index():int {
			return _index;
		}
	}
	
}