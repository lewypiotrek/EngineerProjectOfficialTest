#include "musicplayer.h"
#include <QMediaMetaData>

MusicPlayer::MusicPlayer(QObject *parent) : QObject(parent)
{
    createMusicPlayer();
}

void MusicPlayer::createMusicPlayer()
{
    player = new QMediaPlayer(this);
    playList = new QMediaPlaylist(this);
    // connect slots & signals to determine duration
    connect(player, &QMediaPlayer::durationChanged,this,[&](qint64 f_duration) {
        songDuration = f_duration;
    });

// TEST AREA !!!!!!!!!!!!!!!!
    connect(player, &QMediaObject::metaDataAvailableChanged, this, [&](){
        //currentSongTitle = playList->metaData(QStringLiteral("Author")).toString();
        QVariant v = playList->mediaObject()->metaData("Title");
        currentSongTitle = v.toString();
    });

//    connect(player, &QMediaPlayer::mediaStatusChanged, [&](QMediaPlayer::MediaStatus status){
//            if(playList->mediaObject()->isMetaDataAvailable())
//            {
//                currentSongTitle = playList->mediaObject()->metaData(QMediaMetaData::Title).toString();

//            }
//            else
//            {
//                currentSongTitle = playList->currentMedia().canonicalUrl().toString();
//            }
//    });
// TEST AREA !!!!!!!!!!!!!!!!


    // Play a whole list in a loop
    playList->setPlaybackMode(QMediaPlaylist::Loop);

    volume = 100;
    player->setVolume(volume);
    songDuration=0;

    setPlaylist(folderPath);
    isPlaying = false;
    currentSongTitle="...";
}

void MusicPlayer::setPlaylist(const QString f_folderPath)
{   
    if(!playList->isEmpty())
    {
        playList->clear();
    }

    // load files to string list
    QDir directory(f_folderPath);
    musicFiles = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files|QDir::Readable);

    // clear old playlist
    //playList->clear();

    // load items from string list to playlist
    foreach(QString fileName, musicFiles){
        playList->addMedia(QMediaContent(QUrl::fromLocalFile(f_folderPath + "/" + fileName)));
    }
    playList->setCurrentIndex(0);
    player->setPlaylist(playList);

}

void MusicPlayer::playMusic()
{
    if(!playList->isEmpty())
    {       
        currentSongTitle = player->metaData(QMediaMetaData::Title).toString();
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
    volume = f_volume;
}

int MusicPlayer::getVolume()
{
    return volume;
}

void MusicPlayer::pausePlaying()
{
    player->pause();
}

QString MusicPlayer::getSongTitle()
{
    return currentSongTitle;
}

void MusicPlayer::setSongTitle(QString f_title)
{
    if(f_title.isEmpty())
    {
        currentSongTitle = "...";
    }
    else
    {
        currentSongTitle = f_title;
    }
}

QString MusicPlayer::getSongDuration()
{

    // IT DOESNT WORK - NEED TO FIX IT
    QString duration = QString::number(songDuration);
    return duration;
}

void MusicPlayer::setSongDuration(qint64 f_duration)
{
    songDuration = f_duration;
    qDebug() << "duration = " << f_duration;
}
