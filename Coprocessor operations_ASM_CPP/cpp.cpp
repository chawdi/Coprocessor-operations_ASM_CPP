// lab 5, variant 18: (c * 149 + b * b) / (a + b - 117)
#include <iostream>
#include <climits>
#include <iomanip>

float a, b;
int32_t c;
float result, num, denom;

extern "C" { void calculate_asm(void); }

void f_c(void)
{
	std::cout << "in function f_c:\n";
	std::cout << "numerator = " << (num = c * 149 + b * b) << "\n";
	std::cout << "denominator = " << (denom = a + b - 117) << "\n";
	std::cout << "result = " << (result = num / denom) << "\n";
}

void f_asm(void)
{
	std::cout << "in function f_asm:\n";
	calculate_asm();
	std::cout << "numerator = " << num << "\n";
	std::cout << "denominator = " << denom << "\n";
	std::cout << "result = " << result << "\n";
}

int main(void)
{
	std::cout.precision(10);
	std::cout	<< "a and b are float, c is integer.\n"
			<< "Enter a b c: ";
	if(!(std::cin >> a >> b >> c))
		return 1;
	f_c();
	result = 0; num = 0; denom = 0;
	f_asm();
	return 0;
}
