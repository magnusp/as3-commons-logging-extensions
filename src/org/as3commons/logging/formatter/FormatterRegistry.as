package org.as3commons.logging.formatter
{
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.formatter.impl.DefaultFormatter;

	public class FormatterRegistry
	{
		public static var defaultFormatterClass:Class = DefaultFormatter;
		
		private static var internalDict:Dictionary = new Dictionary();
		
		public static function setFormatter(logger:ILogger, formatterClass:Class):void {
			internalDict[logger] = formatterClass;
		}
		
		public static function lookupFormatter(logger:ILogger):IFormatter {
			if(!internalDict[logger]) {
				internalDict[logger] = defaultFormatterClass;
			}
			return new internalDict[logger]();
		}
	}
}