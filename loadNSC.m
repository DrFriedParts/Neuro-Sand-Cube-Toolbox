function [ nscData, outFilename ] = loadNSC( filename )
%[nscData, outFilename] = loadNSC(filename) Load NSC log files into MATLAB.
%   Takes in a string path to the NSC log file. Relative paths are ok.
%   Returns the MATLAB cell array (nscData) as well as writes the data to
%   disk so that future conversion is unnecessary. The filename written to
%   disk is available as the second output parameter. It is the input
%   filename with '.MAT' file extension appended.

    %=== INIT    
    s = dir(filename);
    fileSize = s.bytes;

    %=== STEP 1
    tic
    disp(['[1.] Preallocate space for file ' filename '...']);
    numLines = 0;
    fid = fopen(filename);
    tline = fgets(fid);
    while ischar(tline)
        numLines = numLines + 1;
        tline = fgets(fid);
    end
    fclose(fid);
    nscData = cell(1, numLines);
    fprintf('[1.] Allocated for %d lines.', numLines)
    toc
    
    %=== STEP 2
    tic
    disp(['[2.] Processing file ' filename '...']);
    fid = fopen(filename);
    batchCount = 0;    
    tline = fgets(fid);
    while ischar(tline)
        batchCount = batchCount + 1;
        nscData{batchCount} = loadjson(tline);
        tline = fgets(fid);        
    end
    fclose(fid);
    disp('[2.] File processed.');
    toc
    
    %=== STEP 3
    tic
    outFilename = [filename '.MAT'];
    disp(['[3.] Writing results to ' outFilename '...']);
    save(outFilename, 'nscData');
    disp('[3.] MatLab formatted data written to disk.');
    toc
end