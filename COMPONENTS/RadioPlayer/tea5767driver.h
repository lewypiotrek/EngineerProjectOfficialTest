#ifndef TEA5767DRIVER_H
#define TEA5767DRIVER_H

#include <unistd.h>
#include "wiringPi.h"
#include "wiringPiI2C.h"
#include <iostream>
#include <stdlib.h>

#define DEVICE_ADDRESS 0x60
#define READY_WAIT_TIME 15000
#define MAX_STATION 256
#define HCC_DEFAULT 1	// High Cut Control
#define SNC_DEFAULT 1	// Stereo Noise Cancelling(Signal dependant stereo)
#define FORCED_MONO 0	// 1:forced mono, 0:stereo on
#define SEARCH_MODE_DEFAULT 2	// 1: Low, 2: Middle, 3: High
#define RADIO_STATION_INFO "/var/local/radio/radio_station"
#define TUNED_FREQ "/var/local/radio/tuned_freq"
#define MAX_STATION_NAME_LEN 128



class TEA5767Driver
{

private:
    bool isInitialized;
    bool isPlaying;
    int fd;
    unsigned char frequencyH;
    unsigned char frequencyL;
    unsigned int frequencyB;
    char *prog_name;
    int	station_info_num;

    struct _station_info {
        double freq;
        char name[MAX_STATION_NAME_LEN];
    } station_info[MAX_STATION];


public:
    TEA5767Driver();
    void initializeComunicationI2C();
    int waitReady();

    // Two functions to setting frequency advanced and simply way for button binding
    void setFrequency(double frequency, int hcc, int snc, unsigned char force_mono, int mute, int standby);
    void setFrequency(double frequency);

    void turnOnStandby();
    double getFrequency();

    bool getPlayStatsu();
    bool getInitializationStatus();


};

#endif // TEA5767DRIVER_H
