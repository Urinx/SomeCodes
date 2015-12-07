function atom_dist = atomdist(atoms)
%ATOMDIST calculate the distance of each atom in the structure
%
%   ATOM_DIST = ATOMDIST(ATOMS) reads the atom's structure infomations
%   and calculate the distance of each atom in the structure.
%
%   Example:
%
%       pdb_1gfl = pdbatom('1gfl.pdb');
%		atom_dist = atomdist(pdb_1gfl.Atom);
%
%Modified for only get atom info:
%   Date: 2015/12/07 20:04:42

N = length(atoms);
xyz = zeros(N, 3);
atom_dist = zeros( N*(N-1)/2, 3);

for i=1:N
    atom = atoms(i);
    xyz(i, :) = [atom.X atom.Y atom.Z];
end

D = pdist(xyz, 'euclidean'); % 欧氏距离

a = 0;
for i=1:N
	for j=i+1:N
		atom_dist(a, :) = [atoms(i).AtomSerNo atoms(j).AtomSerNo D(++a)];
	end
end

end