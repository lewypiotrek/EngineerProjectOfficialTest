#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>

class MusicPlayer : public QObject
{
    Q_OBJECT
public:
    explicit MusicPlayer(QObject *parent = nullptr);

public:
    void addToPlaylist(QList<QUrl> urlPath);

public slots:
    void durationChanged(qint64 duration);
    void metaDataChanged();
    void loadTracksFromDefaultUrl();

    // QML Controls
    void playMusic();
    void nextSong();
    void previouseSong();
    void stopMusic();
    int getVolume();
    void setVolume(double f_volume);
    void setDuration(qint64 f_duration);
    qint64 getDuration();
    void muteSong();
    void repeatSong();

private:
    void setTrackInfo(const QString &info);

private:
    QMediaPlayer * player = nullptr;
    QMediaPlaylist * playlist = nullptr;
    qint64 duration;
    QString trackInfo;
    QString tracksDefaultPath;
    int volume;
    bool isMuted;
    bool isRepeatModeOn;




};

#endif // MUSICPLAYER_H
