![ofxCMake Logo](ofxCMake_Logo.jpg)

# CMake for OpenFrameworks


## Description
CMake is a meta build system, so it can generate different build systems like
Visual Studio Projects, xCode, make etc. It can also create installers like DEB,
RPM and MSI.

***CMake Intro:***

[CMake](https://cmake.org) is a universal, plattform independent build system.
It tells which source files and libraries of OpenFrameworks, your project and
addOns have to be compiled together so you have your application. CMake is
supported e.g. by the IDEs: [CLion](https://www.jetbrains.com/clion/),
[QTCreator](https://www.qt.io/ide/), [KDevelop](https://www.kdevelop.org).

### *Note*
This is not an ofxAddOn in the normal way.
So do not just copy it into the `of/addons/` folder and expect it to work.


## Usage
This configuration targets **openFrameworks 0.12.1 on desktop Linux**. You need
CMake 3.16 or newer, pkg-config, and a compiler supporting C++17. GCC 10 and
newer use C++20 by default, matching the upstream Linux build; you can select
another standard with `-DCMAKE_CXX_STANDARD=17` (or newer).

Start in a working directory where you can download and unpack openFrameworks.
You will choose its final location and connect it to your application in step 3.

1. Download the official package, which includes the matching third-party
   libraries:

    ```bash
    wget https://github.com/openframeworks/openFrameworks/releases/download/0.12.1/of_v0.12.1_linux64_gcc6_release.tar.gz
    tar -xzf of_v0.12.1_linux64_gcc6_release.tar.gz
    ```

    For another architecture, use the matching
    [0.12.1 release package][of-release].
    A GitHub source archive alone does not include the required third-party
    libraries.

2. Install openFrameworks' system dependencies using the script for your
   distribution.
   On Ubuntu:

    ```bash
    sudo of_v0.12.1_linux64_gcc6_release/scripts/linux/ubuntu/install_dependencies.sh
    ```

    Install `cmake` and `pkg-config` too if they are not already available. Core
    dependencies include GLFW, GLEW/OpenGL, GStreamer 1.0, Cairo, FreeImage,
    FreeType/fontconfig, RtAudio, OpenAL, sndfile, ALSA/PulseAudio, udev,
    OpenSSL, curl, pugixml, uriparser and X11 development packages. GTK and
    mpg123 are enabled when pkg-config finds them. Linux sound playback uses
    OpenAL.

3. Choose where to keep the extracted openFrameworks folder. Leave it where it
   is, or move it to your preferred location. It can be inside your application
   directory or elsewhere, shared by multiple applications.

    Set `OF_ROOT` to the absolute path of that folder. Then change to your
    application's root directory (containing `src/main.cpp` and `src/ofApp.cpp`)
    and set up ofxCMake:

    ```bash
    OF_ROOT=/absolute/path/to/openFrameworks
    cd /absolute/path/to/your/app
    git clone https://github.com/mm318/ofxCMake.git "$OF_ROOT/addons/ofxCMake"
    cp "$OF_ROOT/addons/ofxCMake/project/CMakeLists.txt" ./CMakeLists.txt
    ```

    This copies the template to your application's root, alongside `src/`.

4. Adjust `APP_NAME`, `${APP_NAME}_SOURCE_FILES` and `OFX_ADDONS_ACTIVE` in
   `CMakeLists.txt`, then build from that directory in the same shell:

    ```bash
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DOF_DIRECTORY_BY_USER="$OF_ROOT"
    cmake --build build --parallel
    ./build/bin/ofApp
    ```

    Generated libraries stay in `build/lib`; the app is in `build/bin`. The
    project's `bin/data` folder is copied beside the app after building. No
    separate build of openFrameworks is needed.


## Addons

#### Internal Addons – *Usage*
- Uncomment the internal add-on you want in your project's `CMakeLists.txt`, or
  pass `-DOFX_ADDONS_ACTIVE="ofxGui;ofxOsc"` when configuring.
- `ofxAssimpModelLoader` uses the system `assimp` package. `ofxOpenCv` uses
  `opencv4` and `harfbuzz`. `ofxKinect` uses system `libusb-1.0`.
- `ofxSvg` uses the `svgtiny` and `libxml2` archives bundled with 0.12.1, plus
  system zlib and lzma.
- External add-on configurations are legacy integrations; compatibility depends
  on the version of each external add-on.

#### External Addons – *Creation*
- Create an addon-file `ofxNAME.cmake` from the templates in `ofxCMake/addOns`
- Copy the file into `ofxCMake/addOns/external`
- Register it in `ofxCMake/modules/addOns.cmake` with
  `OF_include_external_addOn(ofxNAME)`.
- Add the name of your addOn into your projects `CMakeLists.txt` in the section
  `AddOns`

**Note:**
*This approach is static and centralised. It is not a perfect solution, but it
lets your openFramework file structure untouched, if you want to update
OpenFrameworks or remove CMake. Future approach might include a configuration
file in each new AddOn*


## Development Philosophy
- The project file `CMakeLists.txt` is simplified for readability.
- A modular file approach (each OS has it's own .cmake files), so understanding
  of the code and version control is easier
- Having all ofxCMake files in one folder (including addOns) has the advantage:
    - Can easily be installed
    - OpenFrameworks can be updated, without having to do changes in the
      openframeworks and the CMake folders
- Down sides:
    - The addOn files are not placed in the addOns itself (but in `of/addons/`).
      It would be better, if each addOn has it's .cmake file already included.
      But this would mean, that the developer deliver it in their source code.


## Compatibility
The supported platform is desktop Linux. macOS, Windows, Emscripten and the
32-bit ARM/EGL backend are not supported by these CMake modules. Bundled library
paths are selected from the target architecture (`linux64`, `linuxaarch64` or
`linux`); `OF_PLATFORM` can override that directory for a custom package.

Validated against the official 0.12.1 Linux x86-64 package on Ubuntu 26.04
with GCC 15.2 and CMake 4.2: a GLFW app builds, the headless tests pass with
C++17 and C++20, and all nine add-ons listed below compile and link. Graphics
and hardware behavior, other architectures and external add-ons were not tested.

To compile and run the headless integration test against your OF installation:

```bash
cmake -S tests -B build-tests -DOF_DIRECTORY_BY_USER=/absolute/path/to/openFrameworks
cmake --build build-tests --parallel
ctest --test-dir build-tests --output-on-failure
```

Add `-DOFX_ADDONS_ACTIVE="ofxGui;ofxOsc;ofxNetwork;ofxXmlSettings;ofxThreadedImageLoader;ofxSvg;ofxAssimpModelLoader;ofxOpenCv;ofxKinect"`
to compile and link those add-ons as well. The test exercises core
initialization, XML, JSON, audio buffers, the new frame timer and the copied
data directory; it runs without a graphics context or audio/camera hardware.


## Special Thanks
- **[BildPeter](https://github.com/BildPeter)**
- **[Avilleret](https://github.com/avilleret)**

[of-release]:
  https://github.com/openframeworks/openFrameworks/releases/tag/0.12.1
