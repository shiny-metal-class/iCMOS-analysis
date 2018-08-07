function [raw_image] = SIF_image_processor( fname,fpath)
%Processes the given file and saves the processed file in the appropriate
%folder.
%{    
    switch type_flag
        case 'B'
            filename_img=[file_prefix,'B.png']; %Set up file name for saving
            absfilepath=strcat(raw_path,file_prefix,'B.sif'); % sets up the file name
        case 'S'
            filename_img=[file_prefix,'S.png']; %Set up file name for saving
            absfilepath=strcat(raw_path,file_prefix,'S.sif'); % sets up the file name
    end      
%} 
absfilepath = fullfile(fpath,fname);
rc=atsif_readfromfile(absfilepath); % attempt to open the file

if (rc == 22002) % check that the file was successfully opened
  signal=0;
  [rc,present]=atsif_isdatasourcepresent(signal);  % check there is a signal present
  if present
    [rc,no_frames]=atsif_getnumberframes(signal);  % query the number of frames contained in the file (e.g. in the instance of a kinetic series there may be more than 1
    if (no_frames > 0)
        [rc,size]=atsif_getframesize(signal);
        [rc,left,bottom,right,top,hBin,vBin]=atsif_getsubimageinfo(signal,0); % get the dimensions of the frame to open
        xaxis=0;
        [rc,data]=atsif_getframe(signal,0,size); % retrieve the frame data
        [rc,pattern]=atsif_getpropertyvalue(signal,'ReadPattern');

        if(pattern == '4') % image
            width = ((right - left)+1)/hBin;
            height = ((top-bottom)+1)/vBin;
           raw_image(:,:)=reshape(data,width,height); % reshape the 1D array to a 2D array for display
           
           map=colormap(gray(255));
                   
       else
		  %TODO - implement for single-track, multi-track & random track
		  disp('It is not possible to display this acquisition format at this time...')
		end
    end    
  end
else
  disp('Could not load file.  ERROR - ');
  disp(rc);
end


end

