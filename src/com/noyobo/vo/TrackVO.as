package com.noyobo.vo
{	
	/**
	 * ...
	 * @author noyobo
	 */
	public class TrackVO
	{
		private var _url:String;
		private var _title:String;
		private var _artist:String;
		private var _album:String;
		private var _cover:String;
		private var _grade:int;
		private var _favFlag:Boolean;
		private var _offline:Boolean;
		private var _soundId:int;
		private var _reason:ReasonVO;
		private var _length:String;
		private var _songUrl:String;
		
		public function TrackVO(
								url:String			= "", 
								title:String		= "", 
								artist:String		= "", 
								album:String		= "",
								cover:String		= "", 
								soundId:int			= 0, 
								grade:int			= 0,
								favFlag:Boolean		= false,
								offline:Boolean		= false,
								reason:ReasonVO		= null,
								length:String		= ""
								):void {
			_url		= url;
			_title		= title;
			_artist		= artist;
			_album		= album;
			_cover		= cover;
			_soundId	= soundId;
			_grade		= grade;
			_favFlag	= favFlag;
			_offline	= offline;
			_reason		= reason;
			_length		= length;
		}
		
		public function set url(val:String):void {
			_url = val;
		}
		
		public function get url():String {
			return _url;
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
		
		public function set album(val:String):void {
			_album = val;
		}
		
		public function get album():String {
			return _album;
		}
		
		public function set cover(val:String):void {
			_cover = val;
		}
		
		public function get cover():String {
			return _cover;
		}
		
		public function set soundId(val:int):void {
			_soundId = val;
		}
		
		public function get soundId():int {
			return _soundId;
		}
		
		public function set grade(val:int):void {
			_grade = val;
		}
		
		public function get grade():int {
			return _grade;
		}
		
		public function set favFlag(val:Boolean):void {
			_favFlag = val;
		}
		
		public function get favFlag():Boolean {
			return _favFlag;
		}
		
		public function set offline(val:Boolean):void {
			_offline= val;
		}
		
		public function get offline():Boolean {
			return _offline;
		}
		
		public function set reason(val:ReasonVO):void {
			_reason= val;
		}
		
		public function get reason():ReasonVO {
			return _reason;
		}
		
		public function set length(val:String):void {
			_length= val;
		}
		
		public function get length():String {
			return _length;
		}
	}
}