#!/usr/bin/python3

def convert_from_decimal_larger_bases(number,base):
	strings="0123456789ABCDEFGHIJ"
	result=""
	while number>0:
		result=strings[number%base]+result
		number=number//base
	return result

def test_convert_from_decimal_larger_bases():
	number,base=31,16
	assert(convert_from_decimal_larger_bases(number,base)=='1F')
	print('Tests passed!')

if __name__=='__main__':
	test_convert_from_decimal_larger_bases()