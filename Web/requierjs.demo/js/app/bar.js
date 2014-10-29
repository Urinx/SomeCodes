define(['app/foo'],function(f){

	function test(){
		f.method1();
		f.method2();
	}

	return {
		test: test
	}
});