classdef Grain
    %GRAIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        state
        color
        energy
        x
        y
    end
    
    methods
        function obj = Grain(state,color, energy, x, y)
            %GRAIN Construct an instance of this class
            %   Detailed explanation goes here
            if nargin > 4
                obj.state = state;
                obj.color = color;
                obj.energy = energy;
                obj.x = x;
                obj.y = y;
            end
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

