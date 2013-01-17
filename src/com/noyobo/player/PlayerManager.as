package com.noyobo.player
{
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author noyobo
	 */
	public class PlayerManager extends EventDispatcher
	{
		
		private var _player:SimplePlayer;
		
		public function PlayerManager() {
			_player = new SimplePlayer();
		}
	}
	
}