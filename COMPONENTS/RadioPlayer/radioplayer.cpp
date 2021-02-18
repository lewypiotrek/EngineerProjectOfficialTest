#include "radioplayer.h"
#include "tea5767driver.h"

RadioPlayer::RadioPlayer(QObject *parent) : QObject(parent)
{
    // Open comunication via I2C bus
    driver.initializeComunicationI2C();
    currentFrequency = 90.1;
}

void RadioPlayer::setRadioFrequency(double f_frequency)
{
    currentFrequency = f_frequency;
    driver.setFrequency(f_frequency);
    emit frequencyChanged();
}

void RadioPlayer::playRadio()
{
    if(driver.getPlayStatsu())
    {
        driver.turnOnStandby();
    }
    else
    {
        driver.setFrequency(currentFrequency);
    }
}

double RadioPlayer::getCurrentFrequency()
{
    return currentFrequency;
}

