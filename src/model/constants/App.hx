package model.constants;

import haxe.macro.Context;

class App {
	public static inline var URL:String = "https://";

	public static var NAME:String = "[cc-quote]";

	public static var BUILD:String = getBuildDate();

	#if marco
	macro public static function getBuildDate() {
		var date = Date.now().toString();
		return Context.makeExpr(date, Context.currentPos());
	}
	#else
	public static function getBuildDate() {
		return Date.now().toString();
	}
	#end
}
