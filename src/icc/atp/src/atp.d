module atp;

import pyd.pyd;
import std.stdio;
import std.conv;

import prisnif;

void run(string let, string arg, string par){
	Prover p = new Prover();
	if (let=="u"){
		p.uncoTest();
	}else if(let=="c"){
		p.copyx();
	}else if(let=="s"){
		p.select();
	}else if(let=="a"){
		p.parseappendix(arg);
	}else if(let=="v"){
		p.statvar();
	}else if(let=="b"){
		p.statvar2();
	}else if(let == "sv"){
		p.statSize();
	}else{
          p.start(let, to!int(arg), par);
	}

}

void hello_func(string s) {
  writef("Hello, world! ");
  writefln(s);
}

extern (C) void PydMain() {
  def!(hello_func)();
  def!(run)();
  module_init();
}
