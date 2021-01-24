#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QQuickView>

class MusicPlayer : public QObject
{
    Q_OBJECT
public:
    explicit MusicPlayer(QObject *parent = nullptr);

public:
    Q_PROPERTY(qint64 currectSongPosition READ getCurrentPositon WRITE setCurrentPositon NOTIFY currentPositionChanged)
    void addToPlaylist(QList<QUrl> urlPath);

public slots:
    void metaDataChanged();
    void loadTracksFromDefaultUrl();

    // QML Controls
    void playMusic();
    void nextSong();
    void previouseSong();
    void stopMusic();
    int getVolume();
    void setVolume(double f_volume);
    void muteSong();
    void repeatSong();

    // Handle overall duration
    void setDurationFromMedia(qint64 f_duration);
    qint64 getDuration();

    // Slots to update slider which represent current song position
    void setCurrentPositon(qint64 f_currectSongPosition);
    qint64 getCurrentPositon();


signals:
    void currentPositionChanged();  // signal for Q_PROPERTY to update slider

private:
    void setTrackInfo(const QString &info);

private:
    QMediaPlayer * player = nullptr;
    QMediaPlaylist * playlist = nullptr;
    QString trackInfo;
    QString tracksDefaultPath;
    int volume;
    bool isMuted;
    bool isRepeatModeOn;
    qint64 duration;            // overall duration in seconds
    qint64 currectSongPosition; // in seconds
    QStringList musicFiles;

};

#endif // MUSICPLAYER_H
