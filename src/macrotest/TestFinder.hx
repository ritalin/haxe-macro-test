package macrotest;

import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;
import Type in StdType;

import haxe.ds.Option;

using Lambda;

class TestFinder {
	private var rootDir: String;

	public function new(rootDir: String) {
		this.rootDir = rootDir;
	}

	public function iterator() : Iterator<Class<Dynamic>> {
		return this.listTestClasses().iterator();
	}

	private function listTestClasses(): Array<Class<Dynamic>> {
		return 
			this.listTestClassNames()
			.map(function(n: String) return StdType.resolveClass(n))
		;
	}

	public function listTestClassNames(): Array<String> {
		var classes = [];

		for (file in sys.FileSystem.readDirectory('.')) {
			var p = new haxe.io.Path(file);

			if(p.ext != "hx" ) continue;

			var types = 
				Context.getModule(p.file)
				.map(this.classFilter)
				.filter(this.filterTestFixture)
				.map(this.extractClassName)
			;

			classes = classes.concat(types);

			// trace(StdType.enumConstructor(type));
		}	
		
		trace(classes);

		return classes;	
	}

	private function classFilter(t: Type): Option<ClassType> {
		return
			switch (t) {
			case TInst(_.get() => ct, _): Some(ct);
			default: None;
			}
		;
	}

	private function filterTestFixture(t: Option<ClassType>) {
		return
			switch (t) {
			case Some(_.meta.get() => md):
				md.exists(function(meta) return meta.name == "TestFixture");

			default: false;
			}
		;
	}

	private function extractClassName(t: Option<ClassType>) {
		return
			switch (t) {
			case Some(ct):
				ct.name;

			default: "";
			}
		;
	}
}