function atom_rad = atomrad(atoms)
%ATOMANGLE calculate the rad of three atoms in the structure
%
%   ATOM_RAD = ATOMRAD(ATOMS) reads the atom's structure infomations
%   and calculate the rad of three atoms in the structure.
%
%   Example:
%
%       pdb_1gfl = pdbatom('1gfl.pdb');
%		atom_rad = atomrad(pdb_1gfl.Atom);
%		%b atom_rad: [A B C <CAB <ABC <BCA]
%
%Modified for only get atom info:
%   Date: 2015/12/07 21:05:10

N = length(atoms);
xyz = zeros(N, 3);
atom_rad = zeros( N*(N-1)*(N-2)/6, 6);

for i=1:N
    atom = atoms(i);
    xyz(i, :) = [atom.X atom.Y atom.Z];
end

D = pdist(xyz, 'euclidean'); % 欧氏距离
% the distence of (i, j) is at D( ( N-1 + N-i+1 )*(i-1) / 2 + (j-i) )
% i.e. D( N(i-1) + j - i(i+1)/2 )   (i>j)

a = 0;
for i=1:N
	A = xyz(i,:);
	for j=i+1:N
		B = xyz(j,:);
		AB = A - B;
		ab = D( N*(i-1)+j-i*(i+1)/2 );
		for k=j+1:N
			C = xyz(k,:);
			AC = A - C;
			BC = B - C;
			ac = D( N*(i-1)+k-i*(i+1)/2 );
			bc = D( N*(j-1)+k-j*(j+1)/2 );
			% rad = acos( AB.AC / |AB|*|AC| )
			rA = acos( AB*AC' / (ab * ac) );
			rB = acos( AB*BC' / (ab * bc) );
			rC = acos( BC*AC' / (bc * ac) );
			atom_rad(++a, :) = [atoms(i).AtomSerNo atoms(j).AtomSerNo atoms(k).AtomSerNo rA rB rC];
		end
	end
end

end