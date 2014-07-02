package ;

import Type in StdType;

import macrotest.TestResult;
import macrotest.MacroTestRunner;
import macrotest.TestFinder;

import massive.munit.Assert;

import failtest.FailSetUpTest;
import failtest.FailTearDownTest;
import failtest.FailTest;

using Lambda;

class TestMain {
	static function main() {
		runAtMacro();
	}

	macro
	public static function runAtMacro() {
		var runner = new MacroTestRunner();

		testResultFormatting();
		testTestFinder();

		testOnly(runner);
		testWithSetUp(runner);
		testWithTearDown(runner);
		testFoo(runner);
		testMultiCase(runner);
		testFailSetUp(runner);
		testFailTearDown(runner);
		testFailed(runner);

		testAll(runner);

		return macro null;
	}

	public static function testOnly(runner) {
		var inst = new MostSimpleTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(MostSimpleTest, inst);

		Assert.areEqual(1, inst.logs.length);
		Assert.areEqual("testMethod", inst.logs.join(" "));		
		Assert.areEqual("1 run(s), 0 failed, 0 error(s)", result.summary());
	}

	public static function testWithSetUp(runner: MacroTestRunner) {
		var inst = new WithSetUpTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(WithSetUpTest, inst);

		Assert.areEqual(2, inst.logs.length);
		Assert.areEqual("setUp testMethod", inst.logs.join(" "));
		Assert.areEqual("1 run(s), 0 failed, 0 error(s)", result.summary());
	}

	public static function testWithTearDown(runner) {
		var inst = new WithTearDownTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(WithTearDownTest, inst);

		Assert.areEqual(2, inst.logs.length);
		Assert.areEqual("testMethod tearDown", inst.logs.join(" "));
		Assert.areEqual("1 run(s), 0 failed, 0 error(s)", result.summary());
	}

	public static function testFoo(runner) {
		var inst = new FooTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(FooTest, inst);

		Assert.areEqual(3, inst.logs.length);
		Assert.areEqual("setUp testMethod tearDown", inst.logs.join(" "));
		Assert.areEqual("1 run(s), 0 failed, 0 error(s)", result.summary());
	}

	public static function testMultiCase(runner) {
		var inst = new HogeTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(HogeTest, inst);

		Assert.areEqual(3, inst.logs.length);
		Assert.areEqual("test1 test2 test3", inst.logs.join(" "));
		Assert.areEqual("3 run(s), 0 failed, 0 error(s)", result.summary());
	} 

	public static function testFailSetUp(runner) {
		var inst = new FailSetUpTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(FailSetUpTest, inst);

		Assert.areEqual(2, inst.logs.length);
		Assert.areEqual("failSetUp tearDown", inst.logs.join(" "));

		Assert.areEqual("1 run(s), 0 failed, 1 error(s)", result.summary());		
	}

	public static function testFailTearDown(runner) {
		var inst = new FailTearDownTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(FailTearDownTest, inst);

		Assert.areEqual(1, inst.logs.length);
		Assert.areEqual("testMethod", inst.logs.join(" "));

		Assert.areEqual("1 run(s), 0 failed, 1 error(s)", result.summary());				
	}

	public static function testFailed(runner) {
		var inst = new FailTest();

		Assert.areEqual(0, inst.logs.length);

		var result = runner.run(FailTest, inst);

		Assert.areEqual(2, inst.logs.length);
		Assert.areEqual("test1 test3", inst.logs.join(" "));

		Assert.areEqual("3 run(s), 1 failed, 0 error(s)", result.summary());				
	}

	public static function testAll(runner) {
		var result = runner.runAll(new TestFinder("."));

		Assert.areEqual("12 run(s), 1 failed, 2 error(s)", result.summary());
	}

	public static function testResultFormatting() {
		var result = new TestResult();
		result.testStarted();
		result.testFailed();
		result.testStarted();
		result.errorOccured();
		result.testStarted();

		Assert.areEqual("3 run(s), 1 failed, 1 error(s)", result.summary());
	}  

	public static function testTestFinder() {
		var finder = new TestFinder(".");

		var names = finder.listTestClassNames();

		Assert.areEqual(8, names.length);
		Assert.areNotEqual(-1, names.indexOf("FooTest"));
		Assert.areNotEqual(-1, names.indexOf("HogeTest"));
		Assert.areNotEqual(-1, names.indexOf("MostSimpleTest"));
		Assert.areNotEqual(-1, names.indexOf("WithSetUpTest"));
		Assert.areNotEqual(-1, names.indexOf("WithTearDownTest"));

		Assert.areNotEqual(-1, names.indexOf("failtest.FailSetUpTest"));
		Assert.areNotEqual(-1, names.indexOf("failtest.FailTearDownTest"));
		Assert.areNotEqual(-1, names.indexOf("failtest.FailTest"));

		var classes = 
			finder.map(function(c) return StdType.getClassName(c)).array()
		;

		Assert.areEqual(8, classes.length);

		Assert.areNotEqual(-1, classes.indexOf("FooTest"));
		Assert.areNotEqual(-1, classes.indexOf("HogeTest"));
		Assert.areNotEqual(-1, classes.indexOf("MostSimpleTest"));
		Assert.areNotEqual(-1, classes.indexOf("WithSetUpTest"));
		Assert.areNotEqual(-1, classes.indexOf("WithTearDownTest"));

		Assert.areNotEqual(-1, classes.indexOf("failtest.FailSetUpTest"));
		Assert.areNotEqual(-1, classes.indexOf("failtest.FailTearDownTest"));
		Assert.areNotEqual(-1, classes.indexOf("failtest.FailTest"));
	}
}