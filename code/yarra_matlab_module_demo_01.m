function yarra_matlab_module_demo_01( workDirPath, taskFileName, outputDirPath )
%YARRA_MATLAB_MODULE_DEMO_01  Demonstrate Yarra module functionality.
%
%   YARRA_MATLAB_MODULE_DEMO_01( workDirPath, taskFileName, outputDirPath )
%   executes task in workDirPath described by taskFileName and saves 
%   results to outputDirPath.

%   jfpva (joshua.vanamerom@sickkids.ca)


%% Identify and Verify Files

% Task File
taskFilePath = fullfile( workDirPath, taskFileName );
assert( exist( taskFilePath, 'file' ) == 2, sprintf('File does not exist: %s',taskFilePath) )
taskParam = yarra_read_ini_file( taskFilePath );

% Scan File
scanFilePath = fullfile( workDirPath, taskParam.task.scanfile );
assert( exist( scanFilePath, 'file' ) == 2, sprintf('File does not exist: %s',scanFilePath) )


%% Start Up

fprintf( '\n' );
fprintf( '%s\n', taskParam.task.reconname );
fprintf( '===============================================\n' );
fprintf( '\n' );

reconStart = tic;


%% Read Measurement Data

fprintf( 'Loading %s...', scanFilePath );

% Load File
twixObj = mapVBVD( scanFilePath );
if length(twixObj)>1
    twixObj = twixObj{end};
end

% Extract K-Space Data
kData = twixObj.image.unsorted();  


%% Derive Acquisition Parameters from Header

TR = twixObj.hdr.Config.TR / twixObj.image.NSet * 1e-3;  % in milliseconds
pixelSpacing = twixObj.hdr.Meas.PhaseFoV / twixObj.hdr.Meas.PhaseEncodingLines * [1,1];  % in millimetres


%% Define Prefix for Output Files

[~,twixFileName] = fileparts( twixObj.image.filename );
outputFileNamePrefix = strrep( twixFileName, 'meas_', '' );


%% Reconstruction Parameters

% Set Default Values for Reconstruction Parameters
reconParam = struct;
reconParam.sacParamValue = 0;  % default parameter value

% Overwrite the Defaults with Values from Task and Mode Files

% Parameter Defined in Stand Alone Client Interface
if ( isfield( taskParam.task, 'paramvalue' ) )
    if ~isempty( taskParam.task.paramvalue )
        reconParam.sacParamValue = taskParam.task.paramvalue;
    end
end


%% Report Info

fprintf( '-----------------------------------------------\n' );
fprintf( 'Data\n' );
fprintf( '-----------------------------------------------\n');
fprintf( 'K-Space Data Size\n' )
for iDim = 1:numel(twixObj.image.dataDims)
    fprintf( '%16s = %5i\n',   twixObj.image.dataDims{iDim}, twixObj.image.dataSize(iDim) )
end
fprintf( 'Acquisition Parameters\n' )
fprintf( 'TR               = %g ms\n',   TR );
fprintf( 'pixelSpacing     = %.2f x %.2f mm\n', pixelSpacing(1), pixelSpacing(2) );
fprintf( 'Reconstruction Parameters\n' )
fprintf( 'SAC parameter    = %g\n',   reconParam.sacParamValue );
fprintf( '-----------------------------------------------\n' );


%% Reconstruct Images

fprintf( 'Reconstructing images...\n' );

% Use Phantom Image for Demonstration Purposes
imData = phantom( 'Modified Shepp-Logan', twixObj.hdr.Dicom.lBaseResolution );


%% Store Images as Dicom

fprintf( 'Saving results...\n' )

dicomFileName = sprintf( '%s.dcm', outputFileNamePrefix );
dicomFilePath = fullfile( outputDirPath, dicomFileName );

fprintf( '   %s\n', dicomFilePath );

dicomwrite( imData, dicomFilePath );


%% Save Data to .mat File

matFileName = strcat( outputFileNamePrefix, '.mat' );
matFilePath = fullfile( outputDirPath, matFileName );

fprintf( '   %s\n', matFilePath );

save( matFilePath, 'imData', 'pixelSpacing', '-v7.3' )


%% Wrap Up

fprintf( 'Complete.\n' )
toc( reconStart );


end  % yarra_matlab_module_demo_01(...)
