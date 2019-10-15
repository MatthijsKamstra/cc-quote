package;

import model.constants.Quotes;

class GUISettings {
	public var message:String = 'test';
	// public var speed:Float = 0.8;
	// public var displayOutline:Bool = false;
	// public var noiseStrength:Float = 0.8;
	// public var growthSpeed:Float = 0.8;
	public var maxSize:Float = 0.8;
	public var fontsize:Float = 40;
	public var quotes:Array<String> = Quotes.array;
	public var svg = function() {
		trace('svg');
	};

	public var png = function() {
		trace('png');
	};

	public var jpg = function() {
		trace('jpg');
	};

	public var update = function() {
		trace('update');
	};

	// public var color0 = "#ffae23"; // CSS string
	// public var color1 = [0, 128, 255]; // RGB array
	// public var color2 = [0, 128, 255, 0.3]; // RGB with alpha
	// public var color3 = {h: 350, s: 0.9, v: 0.3}; // Hue, saturation, value

	public function new() {}
}
