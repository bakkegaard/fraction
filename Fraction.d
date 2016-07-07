import std.conv, std.stdio, std.numeric;

struct Fraction(T){
	T numerator;
	T denominator;
	this(T n, T d){
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
}

void main(){
	auto frac = Fraction!int(1,2);
	writeln(frac);
}
