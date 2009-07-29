package org.as3commons.logging.impl
{
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LogLevel;
	import org.as3commons.logging.LoggerFactory;
	import org.as3commons.logging.formatter.FormatterRegistry;
	import org.as3commons.logging.formatter.IFormatter;
	import org.as3commons.logging.formatter.impl.DefaultFormatter;

	public class FormattedLogger extends AbstractLogger implements ILogger
	{
		public var logFormatter:IFormatter;
		protected var _level:int;
		
		public function FormattedLogger(name:String)
		{
			super(name);
			FormatterRegistry.setFormatter(this, FormatterRegistry.defaultFormatterClass);
		}
		
		public function set level(value:int):void {
			_level = value;
		}
		
		override protected function log(level:uint, message:String, params:Array):void {
			
			if (level >= this._level) {
				var formatter:IFormatter = FormatterRegistry.lookupFormatter(LoggerFactory.getLogger(name));
				formatter.setContextValue("loggerName", name);
				logInternal(formatter.format(level, message, params));
			}
		}
		
		override public function get debugEnabled():Boolean {
			return (_level <= LogLevel.DEBUG);
		}
		
		override public function get infoEnabled():Boolean {
			return (_level <= LogLevel.INFO);
		}
		
		override public function get warnEnabled():Boolean {
			return (_level <= LogLevel.WARN);
		}
		
		override public function get errorEnabled():Boolean {
			return (_level <= LogLevel.ERROR);
		}
		
		override public function get fatalEnabled():Boolean {
			return (_level <= LogLevel.FATAL);
		}
		
		protected function logInternal(text:String):void {
			trace(text);
		}
	}
}