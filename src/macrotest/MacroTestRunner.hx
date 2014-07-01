package macrotest;

import Type in StdType;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;

import massive.munit.AssertionException;

using Lambda;

class MacroTestRunner {
	public function new() { }

	public function run<T>(type: Class<T>, inst: T) {
		var typeName = StdType.getClassName(type);
		var methods = listAllMethod(typeName);

		var result = new TestResult();

		for (name in extractTestMethod(methods, ['Test'])) {
			result.testStarted();

			try {
				for (name in extractTestMethod(methods, ['SetUp'])) {
					Reflect.callMethod(inst, Reflect.field(inst, name), []);

					trace('called start up: ${typeName}::${name}');
				}

				{
					Reflect.callMethod(inst, Reflect.field(inst, name), []);

					trace('called method: ${typeName}::${name}');
				}
			}
			catch (ex: AssertionException) {
				trace("fail assertion captured");

				result.testFailed();
			}
			catch (_: Dynamic) {
				trace("error captured");

				result.errorOccured();
			}

			try {
				for (name in extractTestMethod(methods, ['TearDown'])) {
					Reflect.callMethod(inst, Reflect.field(inst, name), []);

					trace('called tear down: ${typeName}::${name}');
				}
			}
			catch (_: Dynamic) {
				trace("tear down error captured");

				result.errorOccured();
			}
		}	

		return result;	
	}

	private function listAllMethod(className) {
		return
			switch (Context.getType(className)) {
			case TInst(_.get().fields.get() => fields, _):
				fields;
			default: [];
			}
		;
	}

	private function extractTestMethod(methods, meta: Array<String>) {
		var isMethod = function(field: ClassField) {
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

		return methods
			.filter(function(f) return f.isPublic && isMethod(f) && isMetaAccepted(f))
			.map(function(f) return f.name)
		;	
	}
}