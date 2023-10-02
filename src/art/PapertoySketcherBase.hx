package art;

import cc.model.constants.Paper.*;
import haxe.Log;
// import skecher.draw.IBase; // sketch-plus
// import skecher.draw.Text;
import sketcher.draw.Text.TextAlignType;
import sketcher.draw.Text.TextBaselineType;
import sketcher.util.ColorUtil;

class PapertoySketcherBase extends SketcherBase {
	public var settings:Settings;

	public var isFondEmbedded:Bool = false;
	public var shapeName:String;

	var dashArray = [5.];
	var mm20:Int = Math.ceil(mm2pixel(20));

	var cx:Float;
	var cy:Float;

	public function new(?set:Settings) {
		// var paperW = 210; // mm
		// var paperH = 297; // mm
		var paperW = Math.ceil(mm2pixel(210));
		var paperH = Math.ceil(mm2pixel(297));

		this.cx = (paperW / 2);
		this.cy = (paperH / 2);

		this.settings = new Settings(paperW, paperH, 'svg');
		settings.isAutostart = true;
		settings.padding = 10;
		settings.isScaled = false;
		// settings.sizeType = 'mm';
		settings.elementID = 'sketcher-svg';

		super(settings);
	}

	override function draw() {
		console.log('DRAW (PapertoySketcherBase) :: ${toString()}');
		sketch.clear();

		// // print border
		// var printBorder = sketch.makeRectangle(Math.round(w2), Math.round(h2), Math.ceil(settings.width - (2 * mm20)),
		// 	Math.ceil(settings.height - (2 * mm20)));
		// printBorder.id = 'print_border';
		// printBorder.fill = 'none';
		// printBorder.stroke = getColourObj(BLACK, 0.05);

		// // description
		// var text = sketch.makeText(this.shapeName, 50, 140);
		// text.fontFamily = '\'Oswald\', sans-serif';
		// text.fontWeight = "700"; // 299/300/400/500/600/700
		// text.fontSize = '115px';
		// text.fill = '#CCCCCC';

		// colors
		var group = sketch.makeGroup([]);
		// var group = sketch.makeGroup([printBorder, text]);
		group.id = 'sketch basics';

		// colofon
		createColofon();

		// sketch.update();
		// stop and update?
	}

	function createColofon() {
		var sizeW = 50;
		var sizeH = Math.round(mm2pixel(4));

		var round = sketch.makeRoundedRectangle(0, 0, 100, 60, 2, false);
		round.fill = getColourObj(WHITE);
		round.stroke = getColourObj(GRAY);
		round.setPosition(-23, -23);

		var text0 = sketch.makeText('fold', 0, Math.round(sizeH * 0));
		text0.fontFamily = "Arial";
		text0.fontSize = "8px";
		text0.textAlign = TextAlignType.Right;
		text0.textBaseline = TextBaselineType.Middle; // "middle";
		// text0.textAnchor = TextAnchorType.End; // "end"; // start middle end
		// text0.alignmentBaseline = AlignmentBaselineType.Middle; // "middle";

		var text1 = sketch.makeText('cut', 0, Math.round(sizeH * 1.5));
		text1.fontFamily = "Arial";
		text1.fontSize = "8px";
		text1.textAlign = TextAlignType.Right;
		text1.textBaseline = TextBaselineType.Middle; // "middle";
		// text1.textAnchor = TextAnchorType.End; // "end"; // start middle end
		// text1.alignmentBaseline = AlignmentBaselineType.Middle; // "middle";

		// var text2 = sketch.makeText('glue', 0, Math.round(sizeH * 3));
		// text2.fontFamily = "Arial";
		// text2.fontSize = "8px";
		// text2.textAnchor = "end"; // start middle end
		// text2.alignmentBaseline = "middle";

		var colofonFold = sketch.makeRectangle(Math.round((sizeW / 2) + 10), Math.round(sizeH * 0), sizeW, sizeH);
		colofonFold.dash = dashArray;
		colofonFold.fill = getColourObj(WHITE);
		colofonFold.stroke = getColourObj(BLACK);

		var cut = sketch.makeRectangle(Math.round((sizeW / 2) + 10), Math.round(sizeH * 1.5), sizeW, sizeH);
		cut.fill = getColourObj(WHITE);
		cut.stroke = getColourObj(BLACK);

		// var p1 = {x: Math.round(sizeW + 10), y: Math.round((sizeH * 3) + (sizeH / 2))};
		// var p2 = {x: Math.round(10), y: Math.round((sizeH * 3) + (sizeH / 2))};
		// var p3 = {x: Math.round(10 + sizeH), y: Math.round((sizeH * 3) - (sizeH / 2))};
		// var p4 = {x: Math.round(sizeW + 10 - sizeH), y: Math.round((sizeH * 3) - (sizeH / 2))};
		// var glue = sketch.makePolygon([p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y]);
		// glue.fill = getColourObj(GRAY);
		// glue.stroke = getColourObj(BLACK);

		var group = sketch.makeGroup([round, text0, text1 /*, text2*/, colofonFold, cut /*, glue*/]);
		group.id = 'sketch colofon';
		group.setPosition(30, 800);
	}

	function onEmbedHandler(e) {
		console.log('onEmbedHandler :: ${toString()} -> "${e}"');
		// draw();
	}
}
