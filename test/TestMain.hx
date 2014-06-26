package ;

import Type in StdType;
import haxe.macro.Context;
import haxe.macro.Type;

import FooTest;

using Lambda;

class TestMain {
	static function main() {
		runAtMacro();
	}

	macro
	private static function runAtMacro() {
		var foo = new FooTest();

		trace('startupCalled: ${foo.startupCalled}');
		trace('methodCalled: ${foo.methodCalled}');
		runTest(FooTest, foo);
		trace('startupCalled: ${foo.startupCalled}');
		trace('methodCalled: ${foo.methodCalled}');

		return macro null;
	}

	public static function runTest(type, test) {
		var className = StdType.getClassName(type);

		for (name in extractTestMethod(className, ['StartUp'])) {
			Reflect.callMethod(test, Reflect.field(test, name), []);

			trace('called startup: ${name}');
		}

		for (name in extractTestMethod(className, ['Test'])) {
			Reflect.callMethod(test, Reflect.field(test, name), []);

			trace('called method: ${name}');
		}
	}

	private static function extractTestMethod(className, meta: Array<String>) {
		var isMethod = function(field) {
			return 
				switch (field.kind) {
				case FMethod(_): true;
				default: false;
				}
			;
		}

		var isMetaAccepted = function(field: ClassField) {
			return
				field.meta.get().exists(
					function(m) return meta.has(m.name)
				)
			;
		}

		return
			switch (Context.getType(className)) {
			case TInst(_.get().fields.get() => fields, _):
				fields
					.filter(function(f) return f.isPublic && isMethod(f) && isMetaAccepted(f))
					.map(function(f) return f.name);
			default: [];
			}
		;	
	}
}