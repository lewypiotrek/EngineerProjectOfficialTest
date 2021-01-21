#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H

#include <QObject>
#include <QtMultimedia/QMediaPlayer>
#include <QtMultimedia/QMediaPlaylist>
#include <QDir>
#include <QStandardPaths>

class MusicPlayer : public QObject
{
    Q_OBJECT
public:
    explicit MusicPlayer(QObject *parent = nullptr);

    // variables
private:
    QMediaPlayer * player = nullptr;
    QMediaPlaylist * playList = nullptr;
    const QString folderPath = "/home/pi/Music";    // temporary path
    QStringList musicFiles; //temp variable
    bool isPlaying;
    QString currentSongTitle;
    int volume;
    qint64 songDuration;


    // private methods
private:
    void createMusicPlayer();
    void setPlaylist(QString f_folderPath);




public slots:
    void playMusic();
    void pausePlaying();
    void switchNextSong();
    void switchPreviouseSong();
    void setVolume(int f_volume);
    int getVolume();
    QString getSongTitle();
    void setSongTitle(QString f_title);
    QString getSongDuration();
    void setSongDuration(qint64 f_duration);



signals:
    void songChanged();


};

#endif // MUSICPLAYER_H
