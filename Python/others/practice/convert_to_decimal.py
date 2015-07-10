#!/usr/bin/python3

def convert_to_decimal(number, base):
	multiplier,result = 1,0
	while number>0:
		result+=number%10*multiplier
		multiplier*=base
		number=number//10 #right shift a digit
	return result

def test_convert_to_decimal():
	number,base=1001,2
	assert(convert_to_decimal(number,base) == 9)
	print('Tests passed!')

if __name__=='__main__':
	test_convert_to_decimal()