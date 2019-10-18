package;

import js.Browser.*;
import js.html.XMLHttpRequest;

class MainLoad {
	var url = "_nav.html";
	var req = new XMLHttpRequest();

	public function new() {
		loadHTML(url, document.getElementById("storage"));
	}

	function loadHTML(?url:String, ?el:js.html.Element) {
		// your code
		req.open('GET', url);
		req.onload = function() {
			// trace(req.response);
			var body = getBody(req.response);
			// trace(body);
			processHTML(body, document.getElementById("storage"));
		};

		req.onerror = function(error) {
			console.error('[JS] error: $error');
		};

		req.send();
	}

	function getBody(html) {
		var test:String = html.toLowerCase(); // to eliminate case sensitivity
		var x:Int = test.indexOf("<body");
		if (x == -1)
			return "";

		x = test.indexOf(">", x);
		if (x == -1)
			return "";
		var y = test.lastIndexOf("</body>");
		if (y == -1)
			y = test.lastIndexOf("</html>");
		if (y == -1)
			y = html.length; // If no HTML then just grab everything till end
		return html.slice(x + 1, y);
	}

	function processHTML(content:String, target:js.html.Element) {
		target.innerHTML = content;
	}

	static public function main() {
		var app = new MainLoad();
	}
}
