package com.noyobo.system
{
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class SystemStatus extends Sprite
    {
        private var statTime:uint;
        private var timer:Timer;
        private var statFrame:uint = 0;
        private var tf:TextField;
        private static var _instance:SystemStatus;

        public function SystemStatus(x:Number = 0, y:Number = 0)
        {
            if (_instance != null)
            {
                throw new Error("singleton");
            }
            addEventListener(Event.ENTER_FRAME, this._onEnterFrame);
            this.timer = new Timer(1000);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            this.timer.start();
            this.statTime = getTimer();
            this.tf = new TextField();
            this.tf.border = true;
            this.tf.backgroundColor = 16777215;
            this.tf.background = true;
            addChild(this.tf);
            this.tf.autoSize = TextFieldAutoSize.LEFT;
            this.tf.mouseEnabled = false;
            this.alpha = 0.5;
			this.x = x;
			this.y = y;
            return;
        }
        private function onTimer(event:TimerEvent) : void
        {
            var timer:* = getTimer();
            var _loc_3:* = timer - this.statTime;
            var _loc_4:* = this.statFrame / _loc_3 * 1000;
            this.statTime = timer;
            this.statFrame = 0;
            this.tf.text = "fps:" + _loc_4 + "\n";
            this.tf.appendText("vmVersion:" + System.vmVersion + "\n");
            this.tf.appendText("player:" + Capabilities.version + " ");
            if (Capabilities.isDebugger)
            {
                this.tf.appendText("debug");
            }
            this.tf.appendText("\nmem:" + System.totalMemory / 1024 / 1024 + "MB\n");
            this.tf.appendText("os:" + Capabilities.os + "\n");
            this.tf.appendText("os language:" + Capabilities.language + "\n");
            this.tf.appendText("pageCode:" + System.useCodePage + "\n");
            this.tf.appendText("playerType:" + Capabilities.playerType + "\n");
            this.tf.appendText("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + "\n");
            return;
        }

        private function _onEnterFrame(event:Event) : void
        {
             var _loc_3:* = this.statFrame + 1;
            statFrame = _loc_3;
            return;
        }

        public static function getInstance() : SystemStatus
        {
            if (_instance == null)
            {
                _instance = new SystemStatus;
            }
            return _instance;
        }
    }
}
