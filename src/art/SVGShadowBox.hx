package art;

import js.Browser.*;
import js.html.*;
import Sketch;
import cc.model.constants.Paper.*;
import cc.util.MathUtil;
import cc.model.constants.Paper;
import model.constants.Papertoy;
import draw.IBase; // sketch-plus
import cc.draw.Text;
import draw.Base;
import draw.Text;

class SVGShadowBox extends PapertoySketcherBase {
	// datGUI
	public var guisettings = new GUISettings();

	var _currentQuote:String = '';
	// page padding
	var padding:Float;
	var dotted:Int;
	// shadowbox
	var sbHeight:Float; // border hei
	var sbWidth:Float; // border
	var sbImageWidth:Float; // image
	var sbImageHeight:Float; // image
	//
	var sbImageWidthMax:Float; // image
	var sbImageHeightMax:Float; // image

	// svg layers
	var glueArray:Array<IBase> = [];
	var designArray:Array<IBase> = [];
	var quoteArray:Array<IBase> = [];
	var cutArray:Array<IBase> = [];
	var colorArray:Array<IBase> = [];
	var testArray:Array<IBase> = [];

	public function new() {
		shapeName = 'ShadowBox';
		var filename = 'quote-shadowbox-${Date.now().getTime()}';
		// font embedding
		cc.draw.Text.embedGoogleFont('Roboto|Oswald:200,300,400,500,600,700', onEmbedHandler);
		// dat.GUI
		setDatGui();

		// update guisettings with correct functions
		guisettings.jpg = function() {
			var svg = sketch.getSVGElement();
			DownloadWrapper.svg2Canvas(svg, true, '${filename}');
		};
		guisettings.png = function() {
			var svg = sketch.getSVGElement();
			DownloadWrapper.svg2Canvas(svg, false, '${filename}');
		};
		guisettings.svg = function() {
			var svg = sketch.getSVGElement();
			DownloadWrapper.svgExport(svg, '${filename}');
		}
		guisettings.update = function() {
			update();
		}
		super();
	}

	function init() {
		padding = Paper.mm2pixel(5);
		sbWidth = Paper.mm2pixel(10);
		sbHeight = Paper.mm2pixel(10);
		sbImageWidth = Paper.mm2pixel(50); // change later
		sbImageHeight = Paper.mm2pixel(100); // change later
		dotted = Std.int(sbWidth / 4);

		sbImageWidthMax = settings.width - (2 * padding) - (4 * sbWidth) - (4 * sbHeight);
		sbImageHeightMax = settings.height - (2 * padding) - (4 * sbWidth) - (4 * sbHeight);
		// trace('>> max w:' + sbImageWidthMax + '');
		// trace('>> max h:' + sbImageHeightMax + '');

		sbImageWidth = Std.int(sbImageWidthMax); // use max values for now
		sbImageHeight = Std.int(sbImageHeightMax); // use max values for now
	}

	function update() {
		glueArray = [];
		designArray = [];
		quoteArray = [];
		cutArray = [];
		colorArray = [];
		testArray = [];
		sketch.clear();
		draw();
	}

	override function draw() {
		console.log('DRAW (${this.shapeName}) :: ${toString()}');
		super.draw();
		init();
		// custum draw stuff

		// fit a text
		fitText('matthijs');

		// center part
		var rect = sketch.makeRectangle(cx, cy, sbImageWidth, sbImageHeight);
		rect.fill = "#F5F5F5";
		rect.dash = dashArray;
		designArray.push(rect);

		var rect = sketch.makeRectangle(cx, cy, sbImageWidth - (2 * sbWidth), sbImageHeight - (2 * sbWidth));
		rect.stroke = getColourObj(GRAY);
		// rect.strokeOpacity = 0;
		designArray.push(rect);

		// color shapes
		var rect = sketch.makeRectangle(cx, cy, sbImageWidth, sbImageHeight + (sbHeight * 8));
		rect.id = "color-layer-one";
		colorArray.push(rect);

		var rect = sketch.makeRectangle(cx, cy, sbImageWidth + (sbWidth * 8), sbImageHeight);
		rect.id = "color-layer-two";
		colorArray.push(rect);

		// shadowbox border right
		var rect = sketch.makeRectangle(cx + (sbImageWidth / 2) + (sbWidth / 2) + (sbWidth * 0), cy, sbWidth, sbImageHeight);
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx + (sbImageWidth / 2) + (sbWidth / 2) + (sbWidth * 1), cy, sbWidth, sbImageHeight);
		rect.opacity = 0;
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx + (sbImageWidth / 2) + (sbWidth / 2) + (sbWidth * 3), cy, sbWidth, sbImageHeight);
		// rect.opacity = 0;
		// rect.dash = dashArray;
		rect.fill = "#F5F5F5";
		rect.strokeOpacity = 0;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx + (sbImageWidth / 2) + (sbWidth / 2) + (sbWidth * 2), cy, sbWidth, sbImageHeight);
		rect.dash = dashArray;
		designArray.push(rect);

		// shadowbox border left
		var rect = sketch.makeRectangle(cx - (sbImageWidth / 2) - (sbWidth / 2) - (sbWidth * 0), cy, sbWidth, sbImageHeight);
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx - (sbImageWidth / 2) - (sbWidth / 2) - (sbWidth * 1), cy, sbWidth, sbImageHeight);
		rect.opacity = 0;
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx - (sbImageWidth / 2) - (sbWidth / 2) - (sbWidth * 3), cy, sbWidth, sbImageHeight);
		// rect.opacity = 0;
		// rect.dash = dashArray;
		rect.fill = "#F5F5F5";
		rect.strokeOpacity = 0;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx - (sbImageWidth / 2) - (sbWidth / 2) - (sbWidth * 2), cy, sbWidth, sbImageHeight);
		rect.dash = dashArray;
		designArray.push(rect);

		// shadowbox border top
		var rect = sketch.makeRectangle(cx, cy - (sbImageHeight / 2) - (sbHeight / 2) - (sbHeight * 0), sbImageWidth, sbHeight);
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx, cy - (sbImageHeight / 2) - (sbHeight / 2) - (sbHeight * 1), sbImageWidth, sbHeight);
		rect.opacity = 0;
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx, cy - (sbImageHeight / 2) - (sbHeight / 2) - (sbHeight * 3), sbImageWidth - (sbWidth * 2), sbHeight);
		// rect.opacity = 0;
		// rect.dash = dashArray;
		rect.fill = "#F5F5F5";
		rect.strokeOpacity = 0;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx, cy - (sbImageHeight / 2) - (sbHeight / 2) - (sbHeight * 2), sbImageWidth - (sbWidth * 2), sbHeight);
		rect.dash = dashArray;
		designArray.push(rect);

		// shadowbox border bottom
		var rect = sketch.makeRectangle(cx, cy + (sbImageHeight / 2) + (sbHeight / 2) + (sbHeight * 0), sbImageWidth, sbHeight);
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx, cy + (sbImageHeight / 2) + (sbHeight / 2) + (sbHeight * 1), sbImageWidth, sbHeight);
		rect.opacity = 0;
		rect.dash = dashArray;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx, cy + (sbImageHeight / 2) + (sbHeight / 2) + (sbHeight * 3), sbImageWidth - (sbWidth * 2), sbHeight);
		// rect.opacity = 0;
		// rect.dash = dashArray;
		rect.fill = "#F5F5F5";
		rect.strokeOpacity = 0;
		designArray.push(rect);
		var rect = sketch.makeRectangle(cx, cy + (sbImageHeight / 2) + (sbHeight / 2) + (sbHeight * 2), sbImageWidth - (sbWidth * 2), sbHeight);
		rect.dash = dashArray;
		designArray.push(rect);

		setText();

		// cut-line
		// outline
		var _cornerTL = {
			x: padding + (2 * sbWidth) + (2 * sbHeight),
			y: padding + (2 * sbWidth) + (2 * sbHeight),
		}
		var _cornerTR = {
			x: padding + (2 * sbWidth) + (2 * sbHeight) + sbImageWidth,
			y: padding + (2 * sbWidth) + (2 * sbHeight),
		}
		var _cornerBR = {
			x: padding + (2 * sbWidth) + (2 * sbHeight) + sbImageWidth,
			y: padding + (2 * sbWidth) + (2 * sbHeight) + sbImageHeight,
		}
		var _cornerBL = {
			x: padding + (2 * sbWidth) + (2 * sbHeight),
			y: padding + (2 * sbWidth) + (2 * sbHeight) + sbImageHeight,
		}
		var minV = 2; // make sure it is visible the tuck tab
		var sides:Array<Float> = [
			// top-left ----------------------------------------------------------------------------------------------------------------
			_cornerTL.x,
			_cornerTL.y, padding, _cornerTL.y, padding, _cornerTL.y + sbImageHeight, _cornerTL.x, _cornerTL.y + sbImageHeight, _cornerTL.x,
			_cornerTL.y + sbImageHeight,
			// bottom-left ----------------------------------------------------------------------------------------------------------------
			_cornerBL.x,
			_cornerBL.y, _cornerBL.x - sbWidth, _cornerBL.y + minV, _cornerBL.x - sbWidth, _cornerBL.y + sbHeight - minV, _cornerBL.x, _cornerBL.y + sbHeight,
			_cornerBL.x + sbWidth, _cornerBL.y + sbHeight + sbWidth, _cornerBL.x + sbWidth, _cornerBL.y + 2 * sbHeight + 2 * sbWidth, _cornerBR.x - sbWidth,
			_cornerBR.y + 2 * sbHeight + 2 * sbWidth, _cornerBR.x - sbWidth, _cornerBR.y + sbHeight + sbWidth, _cornerBR.x, _cornerBR.y + sbHeight,
			_cornerBR.x + sbWidth, _cornerBR.y + sbHeight - minV, _cornerBR.x + sbWidth, _cornerBR.y + minV,
			// bottom-right ----------------------------------------------------------------------------------------------------------------
			_cornerBR.x,
			_cornerBR.y, _cornerBR.x + 2 * sbWidth + 2 * sbHeight, _cornerBR.y, _cornerTR.x + 2 * sbWidth + 2 * sbHeight, _cornerTR.y,
			// top-right ----------------------------------------------------------------------------------------------------------------
			_cornerTR.x,
			_cornerTR.y, _cornerTR.x + sbWidth, _cornerTR.y - minV, _cornerTR.x + sbWidth, _cornerTR.y - sbHeight + minV, _cornerTR.x, _cornerTR.y - sbHeight,
			_cornerTR.x - sbWidth, _cornerTR.y - sbHeight - sbWidth, _cornerTR.x - sbWidth, _cornerTR.y - 2 * sbHeight - 2 * sbWidth, _cornerTL.x + sbWidth,
			_cornerTL.y - 2 * sbHeight - 2 * sbWidth, _cornerTL.x + sbWidth, _cornerTL.y - sbHeight - sbWidth, _cornerTL.x, _cornerTL.y - sbHeight,
			_cornerTL.x - sbWidth, _cornerTL.y - sbHeight + minV,
			// top-left ----------------------------------------------------------------------------------------------------------------
			_cornerTL.x - sbWidth,
			_cornerTL.y - minV, _cornerTL.x, _cornerTL.y
		];
		var poly = sketch.makePolyLine(sides);
		cutArray.push(poly);

		// color line
		var group = sketch.makeGroup(colorArray);
		group.id = Papertoy.COLOR_LAYER;
		group.fill = getColourObj(WHITE);
		group.stroke = getColourObj(WHITE);
		group.linewidth = 10;
		group.linecap = LineCapType.Round;

		// design layer, folding
		var group = sketch.makeGroup(designArray);
		group.id = Papertoy.DESIGN_LAYER;
		group.linewidth = 0.6;
		group.fill = getColourObj(WHITE);
		group.stroke = getColourObj(BLACK);
		// text / quote
		var group = sketch.makeGroup(quoteArray);
		group.id = Papertoy.TEXT_LAYER;
		// cut line
		var group = sketch.makeGroup(cutArray);
		group.id = Papertoy.CUT_LAYER;
		group.fill = getColourObj(PURPLE);
		group.fillOpacity = 0;
		group.stroke = getColourObj(BLACK); // red
		group.linewidth = 1.2;

		// draw/update
		sketch.update();

		stop(); // stop, no framerate update
	}

	function setText() {
		var _padding = Paper.mm2pixel(5);
		var _paddingTop = 0;
		var _lineHeight = guisettings.fontsize;
		var _startx = padding + (2 * sbHeight) + (3 * sbWidth) + _padding;
		var _starty = padding + (2 * sbHeight) + (3 * sbWidth) + _padding;
		var _maxW = sbImageWidth - (2 * sbWidth) - (2 * _padding);
		var _maxH = sbImageHeight - (2 * sbHeight) - (2 * _padding);

		// trace(sbImageWidth, _maxW);

		// font
		var _fontSize = '${guisettings.fontsize}px';
		var _fontFamilie = '\'Oswald\', sans-serif';
		var _fontWeight = "700"; // 200/300/400/500/600/700

		var isDebug = false;
		if (isDebug) {
			var red = sketch.makeRectangle(cx, cy, _maxW, _maxH);
			red.stroke = getColourObj(RED);
			designArray.push(red);
		}

		var textUtil = new util.TextUtil();
		textUtil.fontFamily = _fontFamilie;
		textUtil.fontWeight = _fontWeight;
		textUtil.fontSize = _fontSize;

		var lines:Array<String> = [];
		lines = textUtil.getLines(_currentQuote.toUpperCase(), _maxW);
		for (i in 0...lines.length) {
			var line = lines[i];
			var yoffset = ((i + 1) * _lineHeight);
			var text = sketch.makeText(line, _startx, _starty + yoffset);
			text.fontFamily = _fontFamilie;
			text.fontWeight = _fontWeight;
			text.fontSize = _fontSize;
			text.fill = getColourObj(BLACK);
			quoteArray.push(text);
		}
	}

	function fitText(value:String) {
		var _padding = Paper.mm2pixel(5);
		var _maxW = 200;
		var _maxH = 10;

		// font
		var _fontSize = '${guisettings.fontsize}px';
		var _fontFamilie = '\'Oswald\', sans-serif';
		var _fontWeight = "700"; // 200/300/400/500/600/700

		// var isDebug = false;
		// if (isDebug) {
		// 	var red = sketch.makeRectangle(cx, cy, _maxW, _maxH);
		// 	red.stroke = getColourObj(RED);
		// 	designArray.push(red);
		// }

		var textUtil = new util.TextUtil();
		textUtil.fontFamily = _fontFamilie;
		textUtil.fontWeight = _fontWeight;
		textUtil.fontSize = _fontSize;

		var text = sketch.makeText(value, _padding, padding);
		text.fontFamily = _fontFamilie;
		text.fontWeight = _fontWeight;
		text.fontSize = _fontSize;
		text.alignmentBaseline = AlignmentBaselineType.Top;
		text.fill = getColourObj(BLACK);
		testArray.push(text);
	}

	// ____________________________________ datGui ____________________________________

	function setDatGui() {
		var gui = new js.dat.gui.GUI();
		gui.remember(guisettings);

		gui.add(guisettings, 'message');
		var controller0 = gui.add(guisettings, 'fontsize');
		controller0.onChange(function(value) {
			// fontSize = value;
			update();
		});
		var controller = gui.add(guisettings, 'quotes', guisettings.quotes);
		controller.onChange(function(value) {
			// Fires on every change, drag, keypress, etc.
			// trace('value: $value');
			_currentQuote = value;
		});
		// controller.onFinishChange(function(value) {
		// 	trace(value);
		// });
		_currentQuote = controller.getValue();

		gui.add(guisettings, 'svg');
		gui.add(guisettings, 'png');
		gui.add(guisettings, 'jpg');
		gui.add(guisettings, 'update');
	}
}
