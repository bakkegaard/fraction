import std.conv, std.stdio, std.numeric;

struct Fraction(T){
	T numerator;
	T denominator;
	this(T n, T d){
		if(d==0) throw new Exception("Cannot initialize fraction with denominator being zero");
		T divisor= gcd(n,d);
		numerator= n/divisor;
		denominator= d/divisor;
	}
	T getNumerator(){
		return numerator;
	}

	T getDenominator(){
		return denominator;
	}
	unittest{
		auto f=  Fraction(1,2);
		assert(f.getNumerator()==1);
		assert(f.getDenominator()==2);

		f= Fraction(15,21);
		assert(f.getNumerator()==5);
		assert(f.getDenominator()==7);
	}

	string toString(){
		return to!string(numerator) ~ "/" ~ to!string(denominator);
	}

	unittest{
		auto f= Fraction(2,3);
		assert("2/3"==f.toString());
	}

	bool opEquals(Fraction rhs){
		bool denominatorEqual= (this.denominator==rhs.getDenominator());
		bool numeratorEqual= (this.numerator==rhs.getNumerator());
		return denominatorEqual && numeratorEqual;
	}
	unittest{
		auto f1 =  Fraction(2,5);
		assert(f1==f1);
		auto f2 =  Fraction(4,10);
		assert(f1==f2);
	}

	int opCmp(Fraction!T rhs) {
		if(getDenominator()==rhs.getDenominator()){
			return getNumerator()-rhs.getNumerator();
		}
		else{
			auto cross1= getNumerator()*rhs.getDenominator();
			auto cross2= getDenominator()*rhs.getNumerator();
			return cross1-cross2;
		}
	}

	unittest{
		auto f1 = Fraction(1,3);
		auto f2 = Fraction(2,3);
		assert((f1<f2)==true);

		auto f3 = Fraction(1,2);
		assert((f1<f3)==true);
	}
	Fraction!T opBinary(string op)(Fraction!T rhs){
		static if(op=="*"){
			auto resultNumerator= getNumerator()*rhs.getNumerator();
			auto resultDenominator= getDenominator()*rhs.getDenominator();
			return Fraction(resultNumerator,resultDenominator);
		}
		else static if(op=="/"){
			auto resultNumerator= getNumerator()*rhs.getDenominator();
			auto resultDenominator= getDenominator()*rhs.getNumerator();
			return Fraction(resultNumerator,resultDenominator);
		}
	}
	unittest{
		auto f1 = Fraction(2,5);
		auto f2 = Fraction(4,10);
		assert(f1*f2 == Fraction(2*4,5*10));
	}

	unittest{
		auto f1 = Fraction(2,5);
		auto f2 = Fraction(4,10);
		assert(f1/f2 == Fraction(2*10,4*5));
	}
	unittest{
		//auto f1 = Fraction(2,5);
		//auto f2 = Fraction(4,10);
		//assert(f1+f2 == Fraction(8,10));
	}

}

void main(){
	auto frac = Fraction!int(1,2);
	writeln(frac);
}
