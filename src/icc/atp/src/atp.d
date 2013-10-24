module atp;

import pyd.pyd;
import std.stdio;
import std.conv;

import prisnif;

void run(string args[]){
	Prover p = new Prover();
	if (args[1]=="u"){
		p.uncoTest();
	}else if(args[1]=="c"){
		p.copyx();
	}else if(args[1]=="s"){
		p.select();
	}else if(args[1]=="a"){
		p.parseappendix(args[2]);
	}else if(args[1]=="v"){
		p.statvar();
	}else if(args[1]=="b"){
		p.statvar2();
	}else if(args[1] == "sv"){
		p.statSize();
	}else{
		p.start(args[1],to!int(args[2]),args[3]);
	}

}

void hello_func() {
  writefln("Hello, world!");
}

extern (C) void PydMain() {
  def!(hello_func)();
  //def!(run)();
  module_init();
}
