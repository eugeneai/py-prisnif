module atp;

import pyd.pyd;
import std.stdio;
import std.conv;

import prisnif;
import symbol;

int run(string let, string arg, string par){
  int rc=0;
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
    rc=p.start(let, to!int(arg), par);
  }
  return rc;
}

void hello_func(string s) {
  writef("Hello, world! ");
  writefln(s);
}

int symbol(string type, string name, ulong arity, PydObject o = null) {
  SymbolType t;
  switch (type) {
    case "const":
      t=SymbolType.CONSTANT;
      break;
    case "fun":
      t=SymbolType.FUNCTION;
      break;
    case "atom":
    case "pred":
      t=SymbolType.ATOM;
      break;
    case "int":
      t=SymbolType.INTEGER;
      break;
    case "float":
      t=SymbolType.FLOAT;
      break;
    case "str":
      t=SymbolType.STRING;
      break;
  default:
    writefln("Unknown type of term '%s'", type);
    return 0;
  };
  writefln("Added term '%s' to the symbol table.", name);
  return 1;
};

extern (C) void PydMain() {
  def!(hello_func)();
  def!(run)();
  def!(symbol)();
  module_init();
}
