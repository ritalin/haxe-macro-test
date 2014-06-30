package macrotest;

import Type in StdType;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;

using Lambda;

class MacroTestRunner {
	public function new() { }

	public function run(type, inst) {
		var methods = listAllMethod(StdType.getClassName(type));


		for (name in extractTestMethod(methods, ['Test'])) {
			for (name in extractTestMethod(methods, ['StartUp'])) {
				Reflect.callMethod(inst, Reflect.field(inst, name), []);

				trace('called start up: ${name}');
			}

			{
				Reflect.callMethod(inst, Reflect.field(inst, name), []);

				trace('called method: ${name}');
			}

			for (name in extractTestMethod(methods, ['TearDown'])) {
				Reflect.callMethod(inst, Reflect.field(inst, name), []);

				trace('called tear down: ${name}');
			}
		}		
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