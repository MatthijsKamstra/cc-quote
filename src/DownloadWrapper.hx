package;

import js.Browser.*;
import Sketch;
import cc.lets.Go;
import cc.util.GridUtil;
import cc.util.MathUtil.*;
import cc.AST;
import cc.util.ColorUtil.*;
import Sketch;

using StringTools;

class DownloadWrapper {
	public function new(?id:String) {
		if (id != null) {
			trace(id);

			var elem:js.html.Element = document.getElementById(id);

			var el = document.createDivElement();
			el.id = "wrapper_download";
			el.className = 'btn-group';

			el.appendChild(btnCreator('jpg'));
			el.appendChild(btnCreator('png'));
			el.appendChild(btnCreator('svg'));

			elem.appendChild(el);
		}
	}

	function btnCreator(id:String):js.html.AnchorElement {
		var anchor = document.createAnchorElement();
		anchor.setAttribute('download-id', '${id}');
		anchor.className = 'btn btn-dark btn-sm';
		anchor.href = '#${id}';
		anchor.onclick = onButtonClickHandler;
		anchor.innerHTML = '${id} ';
		return anchor;
	}

	function onButtonClickHandler(e:js.html.MouseEvent) {
		// trace(cast(e.currentTarget, js.html.AnchorElement).getAttribute('download-id'));
		var attr = cast(e.currentTarget, js.html.AnchorElement).getAttribute('download-id');
		var wrapperDiv = (cast(e.currentTarget, js.html.AnchorElement).parentElement.parentElement);
		var svg:js.html.svg.SVGElement = cast wrapperDiv.getElementsByTagName('svg')[0];
		var filename = '${wrapperDiv.id}_${Date.now().getTime()}';
		switch (attr) {
			case 'jpg':
				svg2Canvas(svg, true, '${filename}.jpg');
			case 'png':
				svg2Canvas(svg, false, '${filename}.png');
			case 'svg':
				cc.tool.ExportFile.downloadTextFile(svg.outerHTML, '${filename}.svg');
			default:
				trace("case '" + attr + "': trace ('" + attr + "');");
		}
	}

	public static function svgExport(svg:js.html.svg.SVGElement, filename:String) {
		cc.tool.ExportFile.downloadTextFile(svg.outerHTML, '${filename}.svg');
	}

	public static function svg2Canvas(svg:js.html.svg.SVGElement, isJpg:Bool = true, filename:String) {
		// trace(svg, isJpg, filename);
		// trace(svg.outerHTML);

		var svgW = Std.parseInt(svg.getAttribute('width'));
		var svgH = Std.parseInt(svg.getAttribute('height'));

		// trace('${svgW} , ${svgH}');

		var canvas = document.createCanvasElement();
		var ctx = canvas.getContext2d();
		canvas.width = svgW;
		canvas.height = svgH;

		var image = new js.html.Image();
		image.onload = function() {
			// trace('onLoad');
			// downloadImageBg doesn't work... so just fix it here
			// jpg image has a white background, png can be transparant
			if (isJpg) {
				ctx.fillStyle = "white";
				ctx.fillRect(0, 0, canvas.width, canvas.height);
			}
			ctx.drawImage(image, 0, 0, svgW, svgH);
			// trace('export');
			cc.tool.ExportFile.downloadImageBg(ctx, isJpg, filename);
		}
		image.onerror = function(e) {
			console.log(e);
		}

		// trace(svg);
		// trace(svg.outerHTML);

		var str = svg.outerHTML;

		// trace(str.length);

		// <!--[\s\S]*?-->
		// var r = ~/<!--[\s\S]*?-->/g;
		// var rdesc = ~/<desc>[\s\S]*?<\/desc>/g;
		// var nstr = r.replace(str, "");
		// trace(nstr.length);
		// nstr = rdesc.replace(nstr, "");

		// trace(nstr.length);
		// trace(nstr);

		// trace(r.replace("test <!-- test --> <!--foo-->", ""));

		// var xml:Xml = Xml.parse(nstr);
		var xml:Xml = Xml.parse(str);

		image.src = 'data:image/svg+xml;charset=utf-8,${(xml.toString().urlEncode())}';
		document.body.appendChild(canvas);
		document.body.appendChild(image);
	}
}
