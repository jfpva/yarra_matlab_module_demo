# yarra_matlab_module_demo

_Demonstration of simple Yarra module using Matlab._

## Installation

This repository uses [git-submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules), which will be missing when downloading from GitHub as a .zip.

When cloning the main repository, use the `--recurse-submodules` flag to also clone the submodules. Tthe contents of the repository can then be bundled as a .zip file and upload to the YarraServer via the WebGUI.  

E.g.,
```
git clone --recurse-submodules https://github.com/jfpva/yarra_matlab_module_demo
cd yarra_matlab_module_demo
zip -r yarra_matlab_module_demo.zip .
```

## Usage

Details of Yarra funtionality can be found at [yarraframework.com](http://yarraframework.com).

### Spefifying Additional Files

Additional files can be specified by the user in the SAC as of version 020b4.
Alternatively, additional files can be manually specified in the .task file as follows:
```
[AdjustmentFiles]
%00=taskID_0.dat
OriginalName_0=original_name_of_file.ext
%01=taskID_1.dat
OriginalName_1=original_name_of_another_file.ext
```
