package com.noyobo.vo
{	
	/**
	 * ...
	 * @author noyobo
	 */
	public class ReasonVO 
	{
		private var _content:String;
		private var _title:String;
		private var _artist:String;
		private var _cover:String;
		private var _url:String;
		
		public function ReasonVO(content:String = "", title:String = "", artist:String = "", cover:String = "" , url:String = ""):void {
			_content	= content;
			_title		= title;
			_artist		= artist;
			_cover		= cover;
			_url	= url;
		}
		
		public function set content(val:String):void {
			_content = val;
		}
		
		public function get content():String {
			return _content;
		}
		
		public function set title(val:String):void {
			_title = val;
		}
		
		public function get title():String {
			return _title;
		}
		
		public function set artist(val:String):void {
			_artist = val;
		}
		
		public function get artist():String {
			return _artist;
		}
		
		public function set cover(val:String):void {
			_cover = val;
		}
		
		public function get cover():String {
			return _cover;
		}	
		public function set url(val:String):void {
			_url = val;
		}
		
		public function get url():String {
			return _url;
		}	
	}
}