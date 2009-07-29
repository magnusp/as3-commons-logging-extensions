package org.as3commons.logging.formatter.impl
{
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.formatter.IFormatter;
	
	import org.as3commons.logging.LogLevel;
	import org.as3commons.logging.util.MessageUtil;

	public class DefaultFormatter implements IFormatter
	{
		protected var contextDict:Dictionary;
		
		public function DefaultFormatter()
		{
		}
		
		public function format(level:uint, message:String, params:Array):String {
			var msg:String = "";

			msg += (new Date()).toString() + " " + LogLevel.toString(level) + " - ";			
			msg += contextDict['loggerName'] + " - " + MessageUtil.toString(message, params);
			
			return msg;
		}
		
		public function setContextValue(key:String, value:*):void {
			if(!contextDict) {
				contextDict = new Dictionary();
			}
			contextDict[key] = value;
		}

		public function removeContextValue(key:String):void {
			if(contextDict) {
				contextDict[key] = null;
			}
		}
	}
}