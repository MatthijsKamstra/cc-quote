package art;

import js.Browser.*;
import js.html.*;
import Sketch;
import cc.draw.Text;
import cc.model.constants.Paper;
import cc.draw.Rectangle;

using StringTools;

class CCShadowBox extends SketchBase {
	// var text:String = 'It is impossible to make anything foolproof because fools are so ingenious.';
	var text:String = 'If you spend too much time thinking about a thing, you’ll never get it done.';
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
	// font
	var isGoogleFontReady:Bool = false;
	var option = new SketchOption();

	public function new() {
		// set up papersize
		var paper = Paper.inPixel(PaperSize.A4);
		// setup Sketch
		option.width = paper.width;
		option.height = paper.height;
		option.dpi = 300; // 72; // 300;
		option.autostart = true;
		option.padding = 10;
		option.scale = true;
		var ctx:CanvasRenderingContext2D = Sketch.create("creative_code_mck", option);

		init();

		super(ctx);
	}

	function init() {
		padding = Paper.mm2pixel(5);
		sbWidth = Paper.mm2pixel(10);
		sbHeight = Paper.mm2pixel(10);
		sbImageWidth = Paper.mm2pixel(50); // change later
		sbImageHeight = Paper.mm2pixel(100); // change later
		dotted = Std.int(sbWidth / 4);

		sbImageWidthMax = w - (2 * padding) - (4 * sbWidth) - (4 * sbHeight);
		sbImageHeightMax = h - (2 * padding) - (4 * sbWidth) - (4 * sbHeight);
		trace('>> max w:' + sbImageWidthMax + '');
		trace('>> max h:' + sbImageHeightMax + '');

		sbImageWidth = Std.int(sbImageWidthMax); // use max values for now
		sbImageHeight = Std.int(sbImageHeightMax); // use max values for now

		Text.embedGoogleFont('Roboto|Oswald:200,300,400,500,600,700', onEmbedHandler);
	}

	override function setup() {
		trace('setup: ${toString()}');
		isDebug = true;
	}

	override function draw() {
		trace('draw: ${toString()}');
		drawShape();
		stop();
	}

	function onEmbedHandler(e) {
		trace('onEmbedHandler: "${e}"');
		isGoogleFontReady = true;
		drawShape();
	}

	function drawShape() {
		if (!isGoogleFontReady)
			return;

		ctx.clearRect(0, 0, w, h);
		ctx.backgroundObj(WHITE);

		//
		settings();

		var xstart = padding;
		var ystart = padding + (2 * sbHeight) + (2 * sbWidth);

		var tabLeft = [
			(0),
			(sbWidth),
			(sbWidth + sbHeight),
			(sbWidth + sbHeight + sbWidth),
			(sbWidth + sbHeight + sbWidth + sbHeight)
		];
		var tabRight = [
			(0),
			(sbHeight),
			(sbHeight + sbWidth),
			(sbHeight + sbWidth + sbHeight),
			(sbHeight + sbWidth + sbHeight + sbWidth)
		];
		// dotted line rectangle
		// shadowbox border left
		Rectangle.create(ctx).pos(xstart + tabLeft[0], ystart).width(sbWidth).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart + tabLeft[1], ystart).width(sbHeight).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart + tabLeft[2], ystart).width(sbWidth).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart + tabLeft[3], ystart).width(sbHeight).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();

		xstart += tabLeft[4];
		// shadowbox center
		Rectangle.create(ctx).pos(xstart, ystart).width(sbImageWidth).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart + sbWidth, ystart + sbWidth)
			.width(sbImageWidth - (2 * sbWidth))
			.height(sbImageHeight - (2 * sbWidth))
			.color(WHITE)
			.stroke(GRAY)
			.draw();

		xstart += sbImageWidth;
		// shadowbox border right
		Rectangle.create(ctx).pos(xstart + tabRight[0], ystart).width(sbHeight).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart + tabRight[1], ystart).width(sbWidth).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart + tabRight[2], ystart).width(sbHeight).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart + tabRight[3], ystart).width(sbWidth).height(sbImageHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();

		// shadowbox border top
		var xstart = padding + (2 * sbWidth) + (2 * sbHeight);
		var ystart = padding;
		Rectangle.create(ctx).pos(xstart, ystart + tabLeft[0]).width(sbImageWidth).height(sbWidth).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart, ystart + tabLeft[1]).width(sbImageWidth).height(sbHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart, ystart + tabLeft[2]).width(sbImageWidth).height(sbWidth).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart, ystart + tabLeft[3]).width(sbImageWidth).height(sbHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		// shadowbox border bottom
		var ystart = padding + (2 * sbWidth) + (2 * sbHeight) + sbImageHeight;
		Rectangle.create(ctx).pos(xstart, ystart + tabRight[0]).width(sbImageWidth).height(sbHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart, ystart + tabRight[1]).width(sbImageWidth).height(sbWidth).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart, ystart + tabRight[2]).width(sbImageWidth).height(sbHeight).color(WHITE).stroke(BLACK).dotted(dotted).draw();
		Rectangle.create(ctx).pos(xstart, ystart + tabRight[3]).width(sbImageWidth).height(sbWidth).color(WHITE).stroke(BLACK).dotted(dotted).draw();

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
		var arr = [
			[_cornerTL.x, _cornerTL.y], [padding, _cornerTL.y], [padding, _cornerTL.y + sbImageHeight], [_cornerTL.x, _cornerTL.y + sbImageHeight],
			[_cornerBL.x, _cornerBL.y], [_cornerBL.x, _cornerBL.y + sbHeight], [_cornerBL.x + sbWidth, _cornerBL.y + sbHeight + sbWidth],
			[_cornerBL.x + sbWidth, _cornerBL.y + 2 * sbHeight + 2 * sbWidth], [_cornerBR.x - sbWidth, _cornerBR.y + 2 * sbHeight + 2 * sbWidth],
			[_cornerBR.x - sbWidth, _cornerBR.y + sbHeight + sbWidth], [_cornerBR.x, _cornerBR.y + sbHeight], [_cornerBR.x, _cornerBR.y],
			[_cornerBR.x + 2 * sbWidth + 2 * sbHeight, _cornerBR.y], [_cornerTR.x + 2 * sbWidth + 2 * sbHeight, _cornerTR.y], [_cornerTR.x, _cornerTR.y],
			[_cornerTR.x, _cornerTR.y - sbHeight], [_cornerTR.x - sbWidth, _cornerTR.y - sbHeight - sbWidth],
			[_cornerTR.x - sbWidth, _cornerTR.y - 2 * sbHeight - 2 * sbWidth], [_cornerTL.x + sbWidth, _cornerTL.y - 2 * sbHeight - 2 * sbWidth],
			[_cornerTL.x + sbWidth, _cornerTL.y - sbHeight - sbWidth], [_cornerTL.x, _cornerTL.y - sbHeight], [_cornerTL.x, _cornerTL.y]];
		ctx.strokeColourObj(BLACK);
		ctx.strokeWeight(1);
		ctx.beginPath();
		ctx.moveTo(arr[0][0], arr[0][1]);
		for (i in 1...arr.length) {
			ctx.lineTo(arr[i][0], arr[i][1]);
		}
		ctx.stroke();

		setText();
	}

	function setText() {
		var _fontSize = 46;
		var _padding = 20;
		var _paddingTop = 0;
		var _lineHeight = _fontSize;
		var _startx = padding + (2 * sbHeight) + (3 * sbWidth) + _padding;
		var _starty = padding + (2 * sbHeight) + (3 * sbWidth) + _padding;
		var _maxW = sbImageWidth - (2 * sbWidth) - (2 * _padding);
		// important to have a example text in the canvas, otherwise the measurement don't work
		// important to have the font loaded
		ctx.fillStyle = getColourObj(BLACK);
		Text.fillText(ctx, text, w / 2, -h, "'Oswald', sans-serif;", _fontSize);

		// split text up into string/lines
		var lines:Array<String> = TextUtil.getLines(ctx, text.toUpperCase(), _maxW);
		lines.push('– Bruce Lee'.toUpperCase());
		for (i in 0...lines.length) {
			var line = lines[i];
			Text.fillText(ctx, line, _startx, _starty + _paddingTop + ((i + 1) * _lineHeight), "'Oswald', sans-serif;", _fontSize);
		}
	}

	function settings() {
		var _setting = 'dpi: ${option.dpi}\n
innerW: ${Std.int(Paper.pixel2mm(sbImageWidth - (2 * sbWidth)))}mm\n
innerH: ${Std.int(Paper.pixel2mm(sbImageHeight - (2 * sbWidth)))}mm\n
sbWidth: ${Std.int(Paper.pixel2mm(sbWidth))}mm\n
sbHeight: ${Std.int(Paper.pixel2mm(sbHeight))}mm\n
';
		// sbImageWidth: ${Std.int(Paper.pixel2mm(sbImageWidth))}mm\n
		// sbImageHeight: ${Std.int(Paper.pixel2mm(sbImageHeight))}mm\n
		// settings
		Text.create(ctx, _setting)
			.color(BLACK)
			.font("Roboto")
			.size(9)
			.pos(padding, padding)
			.topBaseline()
			.draw();
	}
}
