#include "tea5767driver.h"

TEA5767Driver::TEA5767Driver()
{
    isInitialized = false;
    isPlaying = false;
    frequencyH = 0;
    frequencyL = 0;
    station_info_num = 0;

}

void TEA5767Driver::initializeComunicationI2C()
{
    std::cout << "Initialization connection.... \n";
    if((fd = wiringPiI2CSetup(DEVICE_ADDRESS)) < 0) {
        fprintf(stderr, "error opening i2c channel\n");
        exit(1);
    }
    else
    {
        std::cout << "Connection I2C without errors \n";
    }

}

void TEA5767Driver::setFrequency(double frequency, int hcc, int snc, unsigned char force_mono, int mute, int standby)
{
    unsigned char radio[5] = {0};
    frequencyB = 4 * (frequency * 1000000 + 225000) / 32768; //calculating PLL word
    frequencyH = frequencyB >> 8;
    frequencyL = frequencyB & 0xFF;
    radio[0] = frequencyH; //FREQUENCY H
    if (mute) radio[0] |= 0x80;
    radio[1] = frequencyL; //FREQUENCY L
    radio[2] = 0xB0; //3 byte (0xB0): high side LO injection is on,.
    if (force_mono) radio[2] |= 0x08;
    radio[3] = 0x10; // Xtal is 32.768 kHz
    if (frequency < 87.5) radio[3] |= 0x20;
    if (hcc) radio[3] |= 0x04;
    if (snc) radio[3] |= 0x02;
    if (standby) radio[3] |= 0x40;
    radio[4] = 0x40; // deemphasis is 75us in Korea and US
    write(fd, radio, 5);

    isPlaying = true;
}

void TEA5767Driver::setFrequency(double frequency)
{
    unsigned char radio[5] = {0};

    // Calculate frequency
    frequencyB = 4 * (frequency * 1000000 + 225000) / 32768;
    frequencyH = frequencyB >> 8;
    frequencyL = frequencyB & 0xFF;

    // Preparing frame data
    radio[0] = frequencyH;
    radio[1] = frequencyL;
    radio[2] = 0xB0;
    radio[3] = 0x10;
    radio[4] = 0x40;

    // Send data
    write(fd, radio, 5);

    // Change flag status
    isPlaying = true;

}

void TEA5767Driver::turnOnStandby()
{
    setFrequency(getFrequency(), HCC_DEFAULT, SNC_DEFAULT, FORCED_MONO, 0, 1);

}

double TEA5767Driver::getFrequency()
{
    unsigned char radio[5] = {0};
    double frequency;

    read(fd, radio, 5);
    frequency = ((((radio[0] & 0x3F) << 8) + radio[1]) * 32768 / 4 - 225000) / 10000;
    frequency = (frequency * 10.0)/1000.0;
    frequency = (frequency * 10.0)/10.0;

    return frequency;

}


