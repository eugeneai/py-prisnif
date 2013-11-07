module atp;

import pyd.pyd;
import std.stdio;
import std.conv;
import deimos.python.Python;

import prisnif;
import symbol;
import gterm;

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

  override bool can_interp() {
    return pyo ! is null;
  };

  static PydObject interp(GTerm t) {
    PydObject pyd_args;
    PyObject * py_args;
    PyObject * tmp;
    py_args = PyTuple_New(t.args.length);
    foreach(i,a;t.args){
      if (a.symbol.can_interp()) {
        tmp = d_to_python( (cast(Symbol) a.symbol).pyo);
      } else {
        tmp = d_to_python(a.to_string());
      };
      if (tmp is null) {
        writefln("Error: cannot convert!");
        return null;
      };
      PyTuple_SetItem(py_args, i, tmp);
    }
    pyd_args=new PydObject(py_args);
    return (cast(Symbol) t.symbol).pyo.unpack_call(pyd_args);
  }

  static GTerm reduce(GTerm ot) {
    PydObject rc;
    string rcs;
    // writeln("reduce: [start]");
    GTerm t = ot.get_value();
    if(t.is_top_constant())return ot;
    if(t.is_top_atom()){
      foreach(i,a;t.args){
        t.args[i] = Symbol.reduce(a);
      }
      if (! t.symbol.can_interp()) return t;
      if (! (cast (Symbol) t.symbol).pyo.callable()) return t;
      rc = interp(t);
      if (rc is null) return t;
      if (rc == None) return t;
      rcs=rc.toString();
      final switch (rcs) {
      case "False":
        return GTerm.cr_false();
      case "True":
        return null;
      };

      return t; // Just a predicate call, may be true or false must be returned
                        // FIXME. I.e. None - Call and do nothig, True - return true, False - return false.

    }
    if(t.is_top_function()){
      //writeln("reduce: function");
      foreach(i,a;t.args){
        t.args[i] = Symbol.reduce(a);
      }
      if (t.symbol.can_interp()) {
        return t;
      } else { // t.symbol.pyo != null
        rc = interp(t);
        if (rc is null) return t;
        rcs=rc.toString();
        return new GTerm(new Symbol(SymbolType.CONSTANT, "py_" ~ rcs, 0, rc));
      }
    }
    return ot;
  }
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
