package com.noyobo.player
{
	//import flash.events.EventDispatcher;
	import flash.events.Event;
	/**
	 *  管理播放器 事件 统一管理
	 * @author noyobo
	 */
	public class PlayerEvent extends Event
	{
		public static var SOUND_PLAYING:String			= "SOUND_PLAYING_EVENT";
		public static var SOUND_COMPLETE:String			= "SOUND_COMPLETE_EVENT";
		public static var SOUND_ERROE:String			= "SOUND_ERROE_EVENT";
		public static var SOUND_OPEN:String				= "SOUND_OPEN_EVENT";
		public static var SOUND_PROGRESS:String			= "SOUND_PROGRESS_EVENT";
		public static var SOUND_LOAD_COMPLETE:String	= "SOUND_LOAD_COMPLETE_EVENT";
		public static var SOUND_BUFFERING:String		= "SOUND_BUFFERING";
		public static var SOUND_BUFFERED:String			= "SOUND_BUFFERED";
		
		public function PlayerEvent(type:String):void {
			super(type, true);
		}
	}
	
}