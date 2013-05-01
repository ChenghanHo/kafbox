% Profiler extension for Fixed-Budget Kernel Recursive Least Squares
% Author: Steven Van Vaerenbergh, 2013
%
% This file is part of the Kernel Adaptive Filtering Toolbox for Matlab.
% http://sourceforge.net/projects/kafbox/

classdef fbkrls_profiler < fbkrls
    
    methods
        
        function flops = lastflops(kaf) % flops for last iteration
            m = size(kaf.dict,1);
            if ~kaf.prune, m = m-1; end
            floptions = struct(...
                'sum',4*m^2+2 + kaf.prune*(m^2),...
                'mult',4*m^2+3*m+2 + kaf.prune*(m^2+m),...
                'div',1 + kaf.prune*(m+2),...
                'kernel',[kaf.kerneltype,m+1,size(kaf.dict,2)]);
            flops = kflops(floptions);
        end
        
        function bytes = lastbytes(kaf) % bytes used in last iteration
            m = size(kaf.dict,1);
            bytes = 8*m*(m+2+size(kaf.dict,2)); % 8 bytes (double precision)
        end
        
    end
end
