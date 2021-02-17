function s = readJSON2struct(fname)
    % This function reads a JSON file as a structure 
    fid = fopen(fname); 
    raw = fread(fid,inf); 
    str = char(raw'); 
    fclose(fid); 
    s = jsondecode(str);
end