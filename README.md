![ofxCMake Logo](ofxCMake_Logo.jpg)

# CMake for OpenFrameworks


## Description
CMake is a meta build system, so it can generate different build systems like Visual Studio Projects, xCode, make etc. It can also create installers like DEB, RPM and MSI. 

***CMake Intro:***

[CMake](https://cmake.org) is a universal, plattform independent build system. It tells which source files and libraries of OpenFrameworks, your project and addOns have to be compiled together so you have your application. CMake is supported e.g. by the IDEs: [CLion](https://www.jetbrains.com/clion/), [QTCreator](https://www.qt.io/ide/), [KDevelop](https://www.kdevelop.org).

### *Note*
This is not an ofxAddOn in the normal way.
So do not just copy it into the `of/addons/` folder and expect it to work.


## Usage
In your project directory that contains your openFrameworks app sources:

- Setup openFrameworks 0.10.1:

    ```bash
    $ wget https://github.com/openframeworks/openFrameworks/archive/0.10.1.tar.gz && tar xvzf 0.10.1.tar.gz && rm 0.10.1.tar.gz
    $ openFrameworks-0.10.1/scripts/linux/download_libs.sh
    ```

- Setup ofxCMake:

    ```bash
    $ git clone https://github.com/mm318/ofxCMake.git openFrameworks-0.10.1/addons/ofxCMake
    $ cp openFrameworks-0.10.1/addons/ofxCMake/project/CMakeLists.txt .
    ```

- Modify `./CMakeLists.txt` like `APP_NAME` and `${APP_NAME}_SOURCE_FILES` to suit your project

- Build like an usual CMake project, for example:
    
    ```bash
    $ mkdir build
    $ cd build
    $ cmake ..
    $ make -j4
    ```


## Addons

#### Internal Addons – *Usage*
- Uncomment the internal addOn, you want to use in the `CMakeLists.txt` of your project

#### External Addons – *Creation*
- Create an addon-file `ofxNAME.cmake` from the templates in `ofxCMake/addOns`
- Copy the file into `ofxCMake/addOns/external`
- Add the path to the file `ofxCMake/modules/addOnsExternal.cmake` – like e.g. `include( ${OF_CMAKE_ADDONS}/external/ofxNAME.cmake )`
- Add the name of your addOn into your projects `CMakeLists.txt` in the section `AddOns`

**Note:**
*This approach is static and centralised. It is not a perfect solution, but it lets your openFramework file structure untouched, if you want to update OpenFrameworks or remove CMake. Future approach might include a configuration file in each new AddOn*


## Development Philosophy
- The project file `CMakeLists.txt` is simplified for readability.
- A modular file approach (each OS has it's own .cmake files), so understanding of the code and version control is easier
- Having all ofxCMake files in one folder (including addOns) has the advantage:
    - Can easily be installed
    - OpenFrameworks can be updated, without having to do changes in the openframeworks and the CMake folders
- Down sides:
    - The addOn files are not placed in the addOns itself (but in `of/addons/`). It would be better, if each addOn has it's .cmake file already included. But this would mean, that the developer deliver it in their source code. 


## Compatibility
At the moment (Dec 2018) only Ubuntu 16.04 is tested.


## Special Thanks
- **[BildPeter](https://github.com/BildPeter)**
- **[Avilleret](https://github.com/avilleret)**
