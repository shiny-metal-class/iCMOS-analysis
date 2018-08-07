classdef Data < handle
    %Data container for iCCD software
    properties (SetObservable = true)
       current_data = []; %current displayed data
       selected_data = 1; %cell index of desired data
       file_path = '' %path for raw files
       file_names = {} %cell array listing file names
    end %public properties
    
    properties (SetAccess = private, Hidden = true)
        %private set of data including image matrix and various data around
        %it
        matrix
        integral %pixel integration of each photo
        num_files
    end %private properties
    methods
        function img = Data(varargin) %initialise the object
            img.matrix = {}; %cell ray of matrices containing raw images
            img.integral = [];
        end %init
        function data = get.current_data(img)
            data = img.matrix{img.selected_data};
        end %
        function set.selected_data(img,selection)
            img.selected_data = selection;
            notify(img,'selectionChanged');
            if ~isempty(img.matrix)
                imagesc(img.matrix{selection}); axis off;
            end
        end
        function set.file_path(img,file_path)
            img.file_path = file_path;
        end
        function set.file_names(img,file_names) %converts data upon getting new file_names
            notify(img,'new_load');
            if ischar(file_names)
                img.file_names = {file_names};
            end
            img.num_files = length(file_names);
            img.file_names  = file_names;
            for i = 1:img.num_files
                img.matrix{i} = SIF_image_loader(file_names{i},img.file_path);
                img.integral{i} = sum(sum(img.matrix{i}));
            end
            img.selected_data = 1;
        end
        
            
    end %methods
    events
        new_load
        selectionChanged
        error
    end %events
end %img object