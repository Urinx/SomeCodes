## Copyright (C) 2005 Peter Kovesi
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
## 02110-1301, USA.

## FSPECIAL - Create spatial filters for image processing
##
## Usage:  f = fspecial(filtertype, optionalparams)
##
## filtertype can be
##
##    'average'   - Rectangular averaging filter
##    'disk'      - Circular averaging filter.
##    'gaussian'  - Gaussian filter.
##    'log'       - Laplacian of Gaussian.
##    'laplacian' - Crude 3x3 spproximation to laplacian
##    'unsharp'   - Crude sharpening filter
##    'motion'    - Motion blur filter of width 1 pixel
##    'sobel'     - Horizontal Sobel edge filter
##    'prewitt'   - Horizontal Prewitt edge filter
##
## The parameters that need to be specified depend on the filtertype
##
## Examples of use and associated default values:
##
##  f = fspecial('average',sze)           sze can be a 1 or 2 vector
##                                        default is [3 3].
##  f = fspecial('disk',radius)           default radius = 5
##  f = fspecial('gaussian',sze, sigma)   default sigma is 0.5
##  f = fspecial('laplacian',sze, sigma)  default sze is [5 5]
##                                        default sigma is 0.5
##  f = fspecial('log');
##  f = fspecial('motion', length, angle) default length is 9
##                                        default angle is 0 (degrees)
##  f = fspecial('sobel');
##  f = fspecial('prewitt');
##
## Where sze is specified as a single value the filter will be square.

## Author:   Peter Kovesi <pk@csse.uwa.edu.au>
## Keywords: image processing, spatial filters
## Created:  August 2005


function f = fspecial(varargin)
    
    [filtertype, sze, sigma, radius, len, angle] = checkargs(varargin(:));    
    
    rows = sze(1); cols = sze(2);
    r2 = (rows-1)/2; c2 = (cols-1)/2;

    if strcmpi(filtertype, 'average')
	f = ones(sze)/(rows*cols);
    
    elseif strcmpi(filtertype, 'disk')
	[x,y] = meshgrid(-c2:c2, -r2:r2);
	rad = sqrt(x.^2 + y.^2);	
	f = rad <= radius;
	f = f/sum(f(:));	
	
    elseif strcmpi(filtertype, 'gaussian')
	[x,y] = meshgrid(-c2:c2, -r2:r2);
	radsqrd = x.^2 + y.^2;
	f = exp(-radsqrd/(2*sigma^2));
	f = f/sum(f(:));
	
    elseif strcmpi(filtertype, 'log') 
	[x,y] = meshgrid(-c2:c2, -r2:r2);
	radsqrd = x.^2 + y.^2;	
	f = -1/(pi*sigma^4)*(1-radsqrd/(2*sigma^2))...
	     .*exp(-radsqrd/(2*sigma^2));	   
	f = f-mean(f(:));    # Ensure 0 DC

    elseif strcmpi(filtertype, 'laplacian')	    	
	f = [1  1  1 
	     1 -8  1 
	     1  1  1]; 
    
    elseif strcmpi(filtertype, 'unsharp')	    		
	f = -fspecial('log') + [0 0 0 
		                0 1 0 
		                0 0 0];
	
    elseif strcmpi(filtertype, 'sobel')
	f = [1 2 1; 0 0 0; -1 -2 -1];
    
    elseif strcmpi(filtertype, 'prewitt')
	f = [1 1 1; 0 0 0; -1 -1 -1];	
	
    elseif strcmpi(filtertype, 'motion')	
	# First generate a horizontal line across the middle
	f = zeros(sze);
	f(floor(len/2)+1,1:len) = 1;   

	# Then rotate to specified angle
	f = imrotate(f,angle,'bilinear','loose');
	f = f/sum(f(:));
	
    else
	error('Unrecognized filter type');
	
    end	
	
##----------------------------------------------------------------	
##
## Sort out input arguments, setting defaults and checking for errors.
	
function [filtertype, sze, sigma, radius, len, angle] = checkargs(arg)
    
# Set defaults
    
    sze = [3 3];
    sigma = 0.5;
    radius = 5;
    len = 9;
    angle = 0;

    narg = length(arg);    

    filtertype = arg{1};
    if ~ischar(filtertype)
	error('filtertype must be specified as a string');
    end

    if strcmpi(filtertype, 'log')    
      if narg == 1
	  sze = [5 5];
      end
    end
    
    if strcmpi(filtertype, 'average')   | ...
       strcmpi(filtertype, 'gaussian')  | ...
       strcmpi(filtertype, 'log')
	if narg >= 2
	    sze = arg{2};
	    if isscalar(sze)
		sze = [sze sze];
	    end
	end
    end

    if strcmpi(filtertype, 'gaussian')  | ...
       strcmpi(filtertype, 'log')    
	if narg >= 3
	    sigma = arg{3};
	end
    end
    
    if strcmpi(filtertype, 'disk')  
	if narg >= 2
	    radius = arg{2};
	end
	sze = [2*radius+1 2*radius+1];
    end
    
    if strcmpi(filtertype, 'motion')      
	if narg >= 2
	    len = arg{2};
	end

	if narg >= 3
	    angle = arg{3};
	end
	
	# Ensure size is odd so that there is a middle point 
	# about which to rotate the filter by angle.
	if mod(len,2)         
	    sze = [len len];
	else
	    sze = [len+1 len+1];
	end
    end
    
    if ~isscalar(len) | len < 1
	error('length must be a scalar >= 1');
    end
    
    if ~isscalar(angle)
	error('angle must be a scalar');
    end

    if ~isscalar(radius) | radius < 1
	error('radius must be a scalar >= 1');
    end
    
    if ~isscalar(sigma) | sigma < 0.5
	error('sigma must be a scalar >= 0.5');
    end    
    
    if length(sze) > 2
	error('filter size must be a scalar or 2-vector');
    end
    
    if any(fix(sze) ~= sze)
	error('filter size must be integer');
    end	