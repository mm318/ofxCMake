# ======================= ofxCMake Vers. 0.1 =============
#  PUT THIS FILE INTO YOUR OPENFRAMEWORKS PROJECT FOLDER

# ========================================================
# ===================== CMake Settings ===================
# ========================================================
cmake_minimum_required( VERSION 3.16 )
project( openframeworks LANGUAGES C CXX )

# ========================================================
# ===================== User Settings ====================
# ========================================================
# ------------------------ OF Path -----------------------
# --- If outside the OF structure, set an absolute OF path
set( OF_DIRECTORY_BY_USER "${CMAKE_CURRENT_LIST_DIR}/of_v0.12.1_linux64_gcc6_release"
     CACHE PATH "openFrameworks 0.12.1 installation" )

# ---------------------- App name  -----------------------
set( APP_NAME ofApp )

# --------------------- Source Files ---------------------
set( ${APP_NAME}_SOURCE_FILES
        src/main.cpp
        src/ofApp.cpp )

# ------------------------ AddOns  -----------------------
set( OFX_ADDONS_ACTIVE
        #        ofxXmlSettings
        #        ofxOsc
        #        ofxGui
        #        ofxNetwork
        #        ofxThreadedImageLoader
        #        ofxAssimpModelLoader
        #        ofxKinect
        #        ofxOpenCv
        #        ofxSvg
                CACHE STRING "openFrameworks add-ons to build (semicolon-separated)" )

# =========================================================================
# ============================== OpenFrameworks ===========================
# =========================================================================
include( "${OF_DIRECTORY_BY_USER}/addons/ofxCMake/modules/main.cmake" )
# =========================================================================
