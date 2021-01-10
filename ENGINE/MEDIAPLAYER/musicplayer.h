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

private:
    QMediaPlayer * player = nullptr;
    QMediaPlaylist * playList = nullptr;
    const QString folderPath = "/home/pi/Music";
    bool isPlaying;
    QString currentSongTitle;

    void createMusicPlayer();
    void setPlaylist(QString musicFolder);

public slots:
    void playMusic();
    void switchNextSong();
    void switchPreviouseSong();
    void setVolume(int f_volume);
    void pausePlaying();

};

#endif // MUSICPLAYER_H
