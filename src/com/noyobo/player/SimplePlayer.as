package com.noyobo.player
{
	import com.noyobo.vo.TrackVO;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	
	import flash.system.Security;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	import flash.utils.Timer;
	/**
	 * ...
	 * @author noyobo
	 */
	public class SimplePlayer extends EventDispatcher
	{
		private var _sound:Sound;
		private var _channel:SoundChannel;
		private var _buff:SoundLoaderContext = new SoundLoaderContext(3000);
		private var _soundTransform:SoundTransform;
		
		private var _autoPlay:Boolean = false;
		private var _songUrl:String;
		private var _nowPosition:Number = 0;
		private var _soundTimer:Timer = new Timer(500);
		// sound 属性
		private var _loadedBytes:int;
		private var _totalBytes:int;
		private var _soundStatus:String = "stop"; // play pause stop
		private var _playing:Boolean = false;
		private var _soundPosition:int;
		private var _soundRate:Number;
		private var _position:Number;
		private var _length:Number;
		private var _nowLength:Number;
		private var _totalLength:Number;
		private var _track:TrackVO;
		
		private var _valumeValue:Number = 0.5;
		
		private var _soundIsComplete:Boolean = false;
		
		public function SimplePlayer():void {
			Security.allowDomain("*");
			
			init();
		}
		
		private function init():void {
			_soundTransform = new SoundTransform();
		}
		
		/**
		 * value:string mp3 地址  type:Boolean 是否自动播放
		 * @param	value 歌曲地址
		 * @param	type 自动播放
		 */
		public function load(track:TrackVO , type:Boolean = false ):void {
			_autoPlay	= type;
			_track		= track;
			_songUrl	= track.url;
			if(_sound){
				stopPlay();
			}
			_sound = new Sound();
			_sound.load(new URLRequest(_songUrl), _buff);
			_channel = new SoundChannel();
			
			_sound.addEventListener(IOErrorEvent.IO_ERROR,	songErrorHanlder);
			_sound.addEventListener(Event.COMPLETE,			songCompleteHandler);
			_sound.addEventListener(Event.OPEN,				songOpenHandler);
			_sound.addEventListener(ProgressEvent.PROGRESS,	songProgressHanlder);
		}
		
		public function loadMp3(songUrl:String , type:Boolean = false ):void {
			_autoPlay	= type;
			_track		= track;
			_songUrl	= songUrl;
			if(_sound){
				stopPlay();
			}
			_sound = new Sound();
			_sound.load(new URLRequest(_songUrl), _buff);
			_channel = new SoundChannel();
			
			_sound.addEventListener(IOErrorEvent.IO_ERROR,	songErrorHanlder);
			_sound.addEventListener(Event.COMPLETE,			songCompleteHandler);
			_sound.addEventListener(Event.OPEN,				songOpenHandler);
			_sound.addEventListener(ProgressEvent.PROGRESS,	songProgressHanlder);
		}
		/**
		 * 播放
		 * @param	event
		 */
		public function play(event:Event = null):void {			//播放歌曲
			if(_soundStatus !="play"){
				try {
					_nowPosition == 0 ? 0 : _nowPosition + 100;
					_channel = _sound.play(_nowPosition);
					_channel.addEventListener(Event.SOUND_COMPLETE, soundPlayCompleteHandler);
					volume = 0.5;
					_soundStatus = "play";
					_playing	= true;
					startSoundTimer();
				}catch(e){
					trace("sound error 132");
				}
			}
		}
		public function playORpause():void {
			if (_soundStatus != "play") {
				play();
			}else {
				pause();
			}
		}
		/**
		 * 设置播放头位置
		 * @param	value Number 类型
		 */
		public function playAt(value:Number):void {
			if (_soundStatus == "play") {
				pause();
				_nowPosition = value;
				play();
			}
		}
		/**
		 * 暂停
		 * @param	event
		 */
		public function pause(event:Event = null):void {
			if (_soundStatus != "pause") {
				_nowPosition = _channel.position;
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, soundPlayCompleteHandler);
				_soundStatus = "pause";
				_playing	= false;
				stopSoundTimer();
			}
		}
		
		public function stop():void {
			stopPlay();
		}
		
		private function stopPlay():void{								//停止播放
			try { 
				_sound.close();
				_channel.removeEventListener(Event.SOUND_COMPLETE, soundPlayCompleteHandler);
			}catch (error:Error) {
			};
			_channel.stop();
			_nowPosition = 0;
			_soundStatus = "stop";
			_playing	= false;
		}
		//_channel 事件监听
		private function soundPlayCompleteHandler(event:Event = null):void {
			stopSoundTimer();
			stopPlay();
			dispatchEvent(new Event(PlayerEvent.SOUND_COMPLETE));
		}
		 
		//sound事件监听
		
		private function songErrorHanlder(event:IOErrorEvent = null):void{
			trace("Music loadError");
			dispatchEvent(new Event(PlayerEvent.SOUND_ERROE));
		}
		
		private function songCompleteHandler(event:Event = null):void {
			_length 			= event.target.length;
			_soundIsComplete	= true;
			_sound.removeEventListener(Event.COMPLETE, songCompleteHandler);
			_sound.removeEventListener(ProgressEvent.PROGRESS, songProgressHanlder);
			trace("songCompleteHandler: " + _length);
			dispatchEvent(new Event(PlayerEvent.SOUND_LOAD_COMPLETE));
		}
		private function songOpenHandler(event:Event = null):void {
			_length				= 0;
			_totalLength		= 0;
			_nowLength			= 0;
			_soundIsComplete	= false;
			_sound.removeEventListener(IOErrorEvent.IO_ERROR,	songErrorHanlder);
			_sound.removeEventListener(Event.OPEN,				songOpenHandler);
			trace("songOpenHandler");
			if(_autoPlay){
				play();
			}
			dispatchEvent(new Event(PlayerEvent.SOUND_OPEN));
		}
		private function songProgressHanlder(event:ProgressEvent = null) {
			_loadedBytes = event.bytesLoaded;
			_totalBytes = event.bytesTotal;
			
			_nowLength = _sound.length;
			
			if(_totalLength == 0 && _nowLength > 2000){
				_totalLength = (_nowLength * _totalBytes)/_loadedBytes; // 预算时间
			}
			
			dispatchEvent(new Event(PlayerEvent.SOUND_PROGRESS));
			//trace("songProgressHanlder:"+ _loadedBytes + "/" + _totalBytes);
		}
		
		private function soundTimerHandler(event:Event = null):void {
			_position = _channel.position;
			if (!_soundIsComplete && _sound.isBuffering) {
				dispatchEvent(new Event(PlayerEvent.SOUND_BUFFERING));
			}else {
				dispatchEvent(new Event(PlayerEvent.SOUND_BUFFERED));
			}
			dispatchEvent(new Event(PlayerEvent.SOUND_PLAYING));
		}
		
		private function startSoundTimer():void {
			soundTimerHandler();
			_soundTimer.start();
			_soundTimer.addEventListener(TimerEvent.TIMER, soundTimerHandler);
		}
		
		private function stopSoundTimer():void {
			_soundTimer.stop();
			_soundTimer.removeEventListener(TimerEvent.TIMER, soundTimerHandler);
		}
		
		/**
		 * 设置 音频声音 最大值 1 最小 0
		 * @param	val 音量 0-1
		 */
		public function set volume(val:Number):void {
			try {
				_valumeValue = val;
				_soundTransform.volume = val;
				_channel.soundTransform = _soundTransform;
			} catch (e) {
			}
		}
		
		// set get 方法
		public function get status():String {
			return _soundStatus;
		}
		
		public function get playing():Boolean {
			return _playing;
		}
		/**
		 * 获取播放头位置
		 */
		public function get position():Number {
			return _position;
		}/**
		 * 获取歌曲长度
		 */
		public function get length():Number {
			return _length || _totalLength;
			
		}
		public function get track():TrackVO {
			return _track;
		}
		
		public function get autoplay():Boolean {
			return _autoPlay;
		}
	}
}