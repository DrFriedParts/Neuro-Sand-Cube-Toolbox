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
    disp(['[1.] Loading file ' filename '...']);
    fid = fopen(filename);
    json = '[';
    tline = fgets(fid);
    while ischar(tline)
        %disp(tline)
        json = [json tline ','];
        tline = fgets(fid);
    end
    json(length(json)) = ']'; %replace last comma with array terminator
    fclose(fid);
    disp('[1.] File loaded.');
    toc
    
    %=== STEP 2
    tic
    sprintf('[2.] Parsing %d bytes of JSON to MatLab...', fileSize);
    nscData = loadjson(json);
    disp('[2.] JSON processed.');
    toc

    %=== STEP 3
    tic
    outFilename = [filename '.MAT'];
    disp(['[3.] Writing results to ' outFilename '...']);
    save(outFilename, 'nscData');
    disp('[3.] MatLab formatted data written to disk.');
    toc
end