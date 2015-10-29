// 类型检测
// typeof
// instanceof
// Object.prototype.toString
// constructor
// duck type

function type(a){
	return Object.prototype.toString.apply(a).slice(8,-1);
}

// 类的继承
function Person(name, age){
	this.name = name;
	this.age = age;
}

Person.prototype.hi = function(){
	console.log("Hi, my name is " + this.name + ", I'm " + this.age + " years old now.");
};

Person.prototype.walk = function(){
	console.log("I'm walking...");
};

function Student(name, age, className){
	Person.call(this, name, age);
	this.className = className;
}

Student.prototype = Object.create(Person.prototype);
Student.prototype.constructor = Student;

Student.prototype.hi = function(){
	console.log("Hi, my name is " + this.name + ", I'm " + this.age + " years old now, and from " + this.className + ".");
};

var bosn = new Student('Bosn',27,'Class 3, Grade 2');
bosn.hi();
bosn.walk();

