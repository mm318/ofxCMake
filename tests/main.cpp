#include "ofMain.h"
#include "ofTimerFps.h"

#ifdef OFX_TEST_ofxGui
#include "ofxGui.h"
#endif
#ifdef OFX_TEST_ofxOsc
#include "ofxOsc.h"
#endif
#ifdef OFX_TEST_ofxNetwork
#include "ofxNetwork.h"
#endif
#ifdef OFX_TEST_ofxXmlSettings
#include "ofxXmlSettings.h"
#endif
#ifdef OFX_TEST_ofxThreadedImageLoader
#include "ofxThreadedImageLoader.h"
#endif
#ifdef OFX_TEST_ofxSvg
#include "ofxSvg.h"
#endif
#ifdef OFX_TEST_ofxAssimpModelLoader
#include "ofxAssimpModelLoader.h"
#endif
#ifdef OFX_TEST_ofxOpenCv
#include "ofxOpenCv.h"
#endif
#ifdef OFX_TEST_ofxKinect
#include "ofxKinect.h"
#endif

// Pull selected add-on implementations into the link without opening hardware,
// starting worker threads or creating a graphics context in the headless test.
void checkAddons() {
#ifdef OFX_TEST_ofxGui
    ofxPanel panel;
#endif
#ifdef OFX_TEST_ofxOsc
    ofxOscMessage message;
    message.addStringArg("smoke");
#endif
#ifdef OFX_TEST_ofxNetwork
    ofxTCPClient client;
#endif
#ifdef OFX_TEST_ofxXmlSettings
    ofxXmlSettings settings;
#endif
#ifdef OFX_TEST_ofxThreadedImageLoader
    ofxThreadedImageLoader loader;
#endif
#ifdef OFX_TEST_ofxSvg
    ofxSVG svg;
#endif
#ifdef OFX_TEST_ofxAssimpModelLoader
    ofxAssimpModelLoader model;
#endif
#ifdef OFX_TEST_ofxOpenCv
    ofxCvColorImage image;
#endif
#ifdef OFX_TEST_ofxKinect
    ofxKinect kinect;
#endif
}

int main(int argc, char **) {
    ofInit();
    ofTimerFps timer;
    timer.setFps(60);
    timer.reset();
    ofXml xml;
    if (!xml.parse("<smoke>0.12.1</smoke>")) return 1;
    ofSoundBuffer sound;
    sound.allocate(16, 2);
    const ofJson json = {{"version", "0.12.1"}};
    if (json.at("version") != "0.12.1") return 2;
    if (ofBufferFromFile("probe.txt").getText() != "ofxCMake data\n") return 3;
    if (argc > 1) checkAddons();
    return 0;
}
