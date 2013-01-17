package com.noyobo.vo
{	
	/**
	 * ...
	 * @author noyobo
	 */
	public class SetVO 
	{
		private var _uid:int;
		private var _autoplay:Boolean;
		private var _per:int;
		
		public function SetVO(uid:int = 0, autoplay:Boolean = false):void {
			_uid		= uid;
			_autoplay	= autoplay;
		}
		
		public function set uid(val:int):void {
			_uid = val;
		}
		
		public function get uid():int {
			return _uid;
		}
		
		public function set autoplay(val:Boolean):void {
			_autoplay = val;
		}
		
		public function get autoplay():Boolean {
			return _autoplay;
		}
		
		public function set per(val:int):void {
			_per = val;
		}
		
		public function get per():int {
			return _per;
		}
		
	}
}