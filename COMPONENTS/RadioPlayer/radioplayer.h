#ifndef RADIOPLAYER_H
#define RADIOPLAYER_H

#include <QObject>
#include "tea5767driver.h"

class RadioPlayer : public QObject
{
    Q_OBJECT
public:
    explicit RadioPlayer(QObject *parent = nullptr);

    Q_PROPERTY(double currentFrequency READ getCurrentFrequency WRITE setRadioFrequency NOTIFY frequencyChanged);

public slots:
    void setRadioFrequency(double f_frequency);
    void playRadio();
    double getCurrentFrequency();

private:
    TEA5767Driver driver;
    double currentFrequency;

signals:
    void frequencyChanged();



};

#endif // RADIOPLAYER_H
