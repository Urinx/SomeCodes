#! /usr/bin/env python
import sys
from matplotlib.pyplot import *
from numpy import *

def Usage():
	print '='*80
	print 'Usage: ./%s [photo_file] [kernel_size]' % sys.argv[0]
	print 'Eg: ./%s myphoto.png 3' % sys.argv[0]
	print '='*80

def fspecial(func_name,kernel_size=3,sigma=1):
	if func_name=='gaussian':
		m=n=(kernel_size-1.)/2.
		y,x=ogrid[-m:m+1,-n:n+1]
		h=exp( -(x*x + y*y) / (2.*sigma*sigma) )
		h[ h < finfo(h.dtype).eps*h.max() ] = 0
		sumh=h.sum()
		if sumh!=0:
			h/=sumh
		return h

def RGB(rgb_mat,g_filter,flag=255):

	def foo(A,B):
		t=sum(A*B)
		if t>flag: return flag
		return t

	return [foo(rgb_mat[:,:,i],g_filter) for i in range(3)]

# Return a Nx3 matrix of pixels
def loadImageData(self,imagefile):
	# If you don't have matplotlib but have PIL,
	# you can use this to load image data.
	from PIL import Image
	im=Image.open(imagefile)
	m,n=im.size
	data=im.getdata()
	imgMat=zeros((m*n,3))

	for i in xrange(m*n):
		imgMat[i]=data[i]

	return imgMat

def GaussianFilter(image_file,k=3):
	# Read image data
	im=imread(image_file)
	m,n,a=im.shape
	g_im=im.copy()
	print 'Load Image Data Successful!'
	
	# Initial
	if im.max()>1:
		flag=255
	else:
		flag=1
	sigma=1
	w=k/2
	g_filter=fspecial('gaussian',k,sigma)
	print 'Gaussian Kernel is setup.'

	print 'The Gaussian Filter is processing...'
	for i in xrange(w,m-w):
		for j in xrange(w,n-w):
			t=RGB(im[i-w:i+w+1,j-w:j+w+1],g_filter,flag)
			g_im[i,j]=t

	print 'Finished.'
	print 'Show the photo.'
	subplot(121)
	title('Original')
	imshow(im)
	subplot(122)
	title('Filtered')
	imshow(g_im)
	show()

if __name__=='__main__':
	argc=len(sys.argv)
	if argc<3:
		Usage()
	else:
		image_file=sys.argv[1]
		# Kernel size
		k=int(sys.argv[2])

		GaussianFilter(image_file,k)