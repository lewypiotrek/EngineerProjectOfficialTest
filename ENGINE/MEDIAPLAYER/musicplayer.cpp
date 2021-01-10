#include "musicplayer.h"

MusicPlayer::MusicPlayer(QObject *parent) : QObject(parent)
{
    createMusicPlayer();
}

void MusicPlayer::createMusicPlayer()
{
    player = new QMediaPlayer();
    playList = new QMediaPlaylist();
    player->setVolume(100);
    setPlaylist(folderPath);
    isPlaying = false;
    currentSongTitle="...";
}

void MusicPlayer::setPlaylist(const QString f_folderPath)
{
    // load files to string list
    QDir directory(f_folderPath);
    QStringList musicFiles = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files|QDir::Readable);

    // clear old playlist
    //playList->clear();

    // load items from string list to playlist
    foreach(QString fileName, musicFiles){
        playList->addMedia(QMediaContent(QUrl::fromLocalFile(f_folderPath + "/" + fileName)));
    }
    playList->setCurrentIndex(0);
    player->setPlaylist(playList);

    // DEBUGS
    qDebug() <<playList->errorString();
    qDebug() << player->errorString();
}

void MusicPlayer::playMusic()
{
    if(!playList->isEmpty())
    {
        player->play();
    }
}

void MusicPlayer::switchNextSong()
{
    playList->next();
}

void MusicPlayer::switchPreviouseSong()
{
        playList->previous();
}

void MusicPlayer::setVolume(int f_volume)
{
    player->setVolume(f_volume);
}

void MusicPlayer::pausePlaying()
{
    player->pause();
}
