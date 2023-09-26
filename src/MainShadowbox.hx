package;

import js.Browser.*;
import model.constants.App;

class MainShadowbox {
	public function new() {
		// console.log('START :: main');
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('${App.NAME} Dom ready :: build: ${App.BUILD} ');
			var cc = new art.SVGShadowBox();
			var svg:js.html.svg.SVGElement = cast document.getElementsByTagName('svg')[0];
		});
	}

	static public function main() {
		var app = new MainShadowbox();
	}
}
