# yarra_matlab_module_demo

_Demonstration of simple Yarra module using Matlab._

Other example modules, written by the developers of Yarra, can be found in the [YarraFramework team bitbucket collection](https://bitbucket.org/%7B651dd565-451c-4701-a251-5cd56ccb3cfc%7D/):
* [YarraFramework/Modules/YarraModules-Examples](https://bitbucket.org/yarra-dev/yarramodules-examples/src/default/)
* [YarraFramework/Modules/YarraModules-GRASP-Basic](https://bitbucket.org/yarra-dev/yarramodules-grasp-basic/src/default/)

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

### Specifying Additional Files

Additional files can be specified by the user in the SAC as of version [020b4](https://bitbucket.org/yarra-dev/yarraclient/commits/2954e2ccab2c282d28b42936360c755e25bc6c0d).
Alternatively, additional files can be manually specified in the .task file as follows:
```
[AdjustmentFiles]
%00=taskID_0.dat
OriginalName_0=original_name_of_file.ext
%01=taskID_1.dat
OriginalName_1=original_name_of_another_file.ext
```
