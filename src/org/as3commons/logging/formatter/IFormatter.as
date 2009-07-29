package org.as3commons.logging.formatter
{
	public interface IFormatter
	{
		function format(level:uint, message:String, params:Array):String;
		function setContextValue(key:String, value:*):void;
		function removeContextValue(key:String):void;
	}
}