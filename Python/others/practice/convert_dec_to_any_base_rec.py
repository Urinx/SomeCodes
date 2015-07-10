#!/usr/bin/python3

def convert_dec_to_any_base_rec(number,base):
	''' convert an integer to a string in any base '''
	convertString='0123456789ABCDEF'
	if number<base: return convertString[number]
	else:
		return convert_dec_to_any_base_rec(number//base,base)+convertString[number%base]

def test_convert_dec_to_any_base_rec(module_name='this module'):
	number,base=9,2
	assert(convert_dec_to_any_base_rec(number,base)=='1001')
	s='Tests in {name} have {con}!'
	print(s.format(name=module_name,con='passed'))

if __name__=='__main__':
	test_convert_dec_to_any_base_rec()