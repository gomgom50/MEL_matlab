classdef MatrixClass
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Matrix
        RedRowEF
        Inverted
    end

    methods
        function obj = MatrixClass(Matrix)
            % Create the matrix class here
            arguments
                Matrix
            end

            obj.Matrix = Matrix;

        end

        function obj = RREF(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.RedRowEF = rref(obj.Matrix);
        end

        function obj = InvertMatrix(obj)
            
            obj.Inverted = inv(rref(obj.Matrix));

        end
    end
end