package com.noyobo.utils
{
    import flash.display.Sprite;

    public class formatDate extends Sprite
    {

        public function formatDate(){
			
		}
		
		public static function msecToTime(value:Number):String {
			var allsec:int = Math.ceil(value/1000);
			var minute:int = Math.floor(allsec/60);
			var sec:int = allsec%60;
			var lenStr:String = "";
			if (minute<10) {
				lenStr+="0"+minute;
			} else {
				lenStr+=minute;
			}
			lenStr+=":";
			if (sec<10) {
				lenStr+="0"+sec;
			} else {
				lenStr+=sec;
			}
			return lenStr;
		}
		/**
		 * 
		 * @param	value 秒
		 * @return	返回时间
		 */
		public static function secToTime(value:Number):String {
			var minute:int = Math.floor(value / 60);
			var sec:int = value % 60;
			var lenStr:String = "";
			if (minute<10) {
				lenStr+="0"+minute;
			} else {
				lenStr+=minute;
			}
			lenStr+=":";
			if (sec<10) {
				lenStr+="0"+sec;
			} else {
				lenStr+=sec;
			}
			return lenStr;
		}
    }
}
