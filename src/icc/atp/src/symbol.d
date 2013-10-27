module symbol;

import std.stdio;
import std.conv;
import pyd.pyd;

enum SymbolType {CONSTANT, EVARIABLE, AVARIABLE, FUNCTION, ATOM, INTEGER, FLOAT, STRING, UHE};
/*
UHE = "unconfined herbrand element".
*/

/*------------------------------------------------------------*/
/*Symbol description*/
class Symbol{
  /*string representation*/
  string name;
  SymbolType type;
  ulong arity;
  PydObject pyo = null; // Object that is called (if not NULL or None)

	static ulong uhecount=1;
	static Symbol cr_uhe(){
		Symbol s = new Symbol(SymbolType.UHE,"h"~to!string(uhecount),0);
		uhecount++;
		return s;
	}
	this(){

	}

	this(Symbol s){
		type = s.type;
		name = s.name;
		arity = s.arity;
                set_pyd_object(s.pyo);
	}

	this(SymbolType _type){
		type = _type;
	}

  this(SymbolType _type, string _name, ulong _arity, PydObject _pyo = null){
		type=_type;
		name = _name;
		if(type==SymbolType.EVARIABLE || type==SymbolType.INTEGER || type==SymbolType.FLOAT || type==SymbolType.CONSTANT){
			arity = 0;
		}else if(type==SymbolType.AVARIABLE || type==SymbolType.UHE){
			arity = 0;
		}else{
			arity=_arity;
		}
                set_pyd_object(_pyo);
	}

	bool is_mutable(){
		if (type==SymbolType.AVARIABLE || type==SymbolType.UHE) return true; else return false;
	}

	void get_sema(){

	}

	bool compare(Symbol _s){
		if(_s==this) return true;
		if(_s.type==SymbolType.EVARIABLE) return false;
		if(_s.name == name)return true; else return false;
		//}
		return false;
	}
  PydObject  set_pyd_object(PydObject obj) {
    PydObject o = pyo;
    pyo = obj;
    return pyo;
  };
}

/*--------------------------------------------------*/
/*Symbol table*/
class SymbolTable{
	Symbol[string] table;
	static ulong i=0;
	//static Symbol[10000] table;
	this(){
		//table = new Symbol[1000];
	}

	Symbol get_symbol(string str){
		if(str in table) return table[str]; else return null;
	}

	Symbol addget_symbol(Symbol s){
		if(s.name in table)
			return table[s.name];
		else{
			table[s.name] = s;
			return table[s.name];
		}
	}

	bool is_contains(Symbol s){
		if(s.name in table){
			if(table[s.name]==s)return true;else return false;
		}else return false;
	}

	bool is_contains_string(string s){
		if(s in table)return true; else return false;
	}

	bool add_symbol(Symbol s){
		if(! is_contains(s)){
			table[s.name] = s;
			i++;
                        return true;
		} else {
                  return false;
                }
	}
};
