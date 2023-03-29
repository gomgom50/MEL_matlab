function matrix = struct2mat(struct)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
matrix = cell2mat(struct2cell(struct));
end