function PDB_struct = pdbatom(pdbfile)
%PDBATOM reads a Protein Data Bank file into a structure.
%
%   PDB_STRUCT = PDBATOM(FILENAME) reads the file corresponding to FILENAME
%   and stores the atom information contained in this file in PDBSTRUCT.
%
%   Example:
%
%       % In subsequent MATLAB sessions you can use pdbread to access the
%       % local copy from disk instead of accessing it from the PDB web site.
%       gfl = pdbatom('1gfl.pdb');
%
%Original PDBREAD:
%   Copyright 2003-2004 The MathWorks, Inc.
%   $Revision: 1.11.4.7 $  $Date: 2004/04/08 20:44:17 $
%
%Modified for only get atom info:
%   Date: 2015/12/04 15:54:32

    if ~exist(pdbfile,'file')
        error('Bioinfo:BadPDBFile','File does not exist or does not contain valid PDB data');
    end
    
    fid=fopen(pdbfile,'r');
    if fid == -1
        error('Bioinfo:CouldNotOpenFile','Could not open file %s.', pdbfile);
    else
        PDB_struct = [];
        NumOfAtom = 0;
        NumOfHeterogenAtom = 0;
    end
    
    %fullText = fread(fid,'char=>char')';
    %totalNumberOfAtoms = numel(strfind(fullText,'ATOM'));
    %totalNumberOfHeterogenAtom = numel(strfind(fullText,'HETATM'));
    %clear('fullText');
    fseek(fid,0,-1);
    
    while 1
        tline = fgetl(fid);
        if ~ischar(tline)
            break;
        end
        if ~length(tline)
            continue
        end
        blank = blanks(80);
        tline = [tline blank(length(tline)+1:80)];
        
        Record_name = deblank(upper(tline(1:6)));
        
        switch Record_name
            case 'ATOM'
                NumOfAtom = NumOfAtom + 1;
                PDB_struct.Atom(NumOfAtom) = struct('AtomSerNo',{str2int(tline(7:11))},...
                'AtomName',{strtrim(tline(13:16))},...
                'altLoc',{strtrim(tline(17))},...
                'resName',{strtrim(tline(18:20))},...
                'chainID',{tline(22)},...
                'resSeq',{str2int(tline(23:26))},...
                'iCode',{strtrim(tline(27))},...
                'X',{str2float(tline(31:38))},...
                'Y',{str2float(tline(39:46))},...
                'Z',{str2float(tline(47:54))},...
                'occupancy',{str2int(tline(55:60))},...
                'tempFactor',{str2float(tline(61:66))},...
                'segID',{tline(73:76)},...
                'element',{strtrim(tline(77:78))},...
                'charge',{tline(79:80)});
            
            case 'HETATM'
                NumOfHeterogenAtom = NumOfHeterogenAtom + 1;
                PDB_struct.HeterogenAtom(NumOfHeterogenAtom) = struct('AtomSerNo',{str2int(tline(7:11))},...
                'AtomName',{strtrim(tline(13:16))},...
                'altLoc',{strtrim(tline(17))},...
                'resName',{strtrim(tline(18:20))},...
                'chainID',{tline(22)},...
                'resSeq',{str2double(tline(23:26))},...
                'iCode',{strtrim(tline(27))},...
                'X',{str2double(tline(31:38))},...
                'Y',{str2double(tline(39:46))},...
                'Z',{str2double(tline(47:54))},...
                'occupancy',{str2double(tline(55:60))},...
                'tempFactor',{str2double(tline(61:66))},...
                'segID',{tline(73:76)},...
                'element',{strtrim(tline(77:78))},...
                'charge',{tline(79:80)});
        end
    end
    fclose(fid);
end

function Atom = allocateAtoms
Atom = struct('AtomSerNo',{0},'AtomeName',{''},'altLoc',{''},...
    'resName',{''},...
    'chainID',{''},'resSeq',{0},'iCode',{''},'X',{0},...
    'Y',{0},'Z',{0},'occupancy',{0},'tempFactor',{0},...
    'segID',{''},'element',{''},'charge',{''});
end

function val = str2int(str)
val = sscanf(str,'%d');
end

function val = str2float(str)
val = sscanf(str,'%e');
end
