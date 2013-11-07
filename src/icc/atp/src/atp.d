module atp;

import pyd.pyd;
import std.stdio;
import std.conv;

import prisnif;
import symbol;

class Symbol:symbol.Symbol{
  PydObject pyo = null; // Object that is called (if not NULL or None)

  this(){
  }

  this(Symbol s){
    super(s);
    set_pyd_object(s.pyo);
  }

  this(SymbolType _type, string _name, ulong _arity, PydObject _pyo = null){
    super(_type, _name, _arity);
    set_pyd_object(_pyo);
  }

  PydObject set_pyd_object(PydObject obj) {
    PydObject o = pyo;
    pyo = obj;
    return pyo;
  };


}

SymbolTable st = null;

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
    rc=p.start(let, to!int(arg), par, st);
  }
  return rc;
}

void hello_func(string s) {
  writef("Hello, world! ");
  writefln(s);
}

bool symb(string type, string name, ulong arity, PydObject o = null) {
  SymbolType t;
  Symbol s;
  bool rc;

  if (st is null) {
    st = new SymbolTable();
  }

  switch (type) {
    case "const":
      t=SymbolType.CONSTANT;
      break;
    case "func":
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
    writefln("Warning:Unknown type of term '%s'", type);
    return false;
  };

  s=new Symbol(t, name, arity, o);
  rc = st.add_symbol(s);
  if (rc) {
    writefln("Added term '%s' to the symbol table.", name);
  } else {
    writefln("Warning: Term '%s' is already added.", name);
  }
  return rc;
};

extern (C) void PydMain() {
  def!(hello_func)();
  def!(run)();
  def!(symb)();
  module_init();
}
