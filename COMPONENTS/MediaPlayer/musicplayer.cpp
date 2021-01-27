#include "musicplayer.h"
#include <QMediaMetaData>
#include <QtWidgets>


MusicPlayer::MusicPlayer(QObject *parent) : QObject(parent)
{
    // Create media player
    player = new QMediaPlayer(this);
    player->setAudioRole(QAudio::MusicRole);

    // Create Playlist
    playlist = new QMediaPlaylist();
    player->setPlaylist(playlist);

    // Connecting slots and signal to handle metadata changes like title,duration, etc.
    connect(player, QOverload<>::of(&QMediaPlayer::metaDataChanged), this, &MusicPlayer::metaDataChanged);

    // Connectiong slot and signals to handle all QML controls
    connect(player,SIGNAL(volumeChanged(int)),player,SLOT(setVolume(int)));
    connect(player,SIGNAL(durationChanged(qint64)),this,SLOT(setDuration(qint64)));
    connect(player,SIGNAL(mutedChanged(bool)),player,SLOT(setMuted(bool)));

    // Connecting signals to handle music duration and current position for slider
    connect(player,SIGNAL(durationChanged(qint64)),this,SLOT(setDurationFromMedia(qint64)));
    connect(player,SIGNAL(positionChanged(qint64)),this,SLOT(setCurrentPositon(qint64)));


    // Additionals variables settings
    tracksDefaultPath = "/home/pi/Music";
    isMuted = false;
    isRepeatModeOn = false;
    volume = 100;
    duration = 1;
    currectSongPosition = 1;

    // Load playlist
    loadTracksFromDefaultUrl();

}

static bool isPlaylist(const QUrl &url) // Check for ".m3u" playlists.
{
    if (!url.isLocalFile())
        return false;
    const QFileInfo fileInfo(url.toLocalFile());
    return fileInfo.exists() && !fileInfo.suffix().compare(QLatin1String("m3u"), Qt::CaseInsensitive);
}

void MusicPlayer::addToPlaylist(QList<QUrl> urlPath)
{
    for (auto &url: urlPath) {
        if (isPlaylist(url))
            playlist->load(url);
        else
            playlist->addMedia(url);
    }
}

void MusicPlayer::metaDataChanged()
{
    if (player->isMetaDataAvailable())
    {
        setTrackInfo(QString("%1 - %2")
                .arg(player->metaData(QMediaMetaData::AlbumArtist).toString())
                .arg(player->metaData(QMediaMetaData::Title).toString()));
    }
}

void MusicPlayer::loadTracksFromDefaultUrl()
{
    // load files to string list
    QDir directory(tracksDefaultPath);
    musicFiles = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files|QDir::Readable);

    // load items from string list to playlist
    foreach(QString fileName, musicFiles){        
        playlist->addMedia(QMediaContent(QUrl::fromLocalFile(tracksDefaultPath + "/" + fileName)));
    }

    // This is nessery to upload information about duration, etc. There is no easy way to
    // read metaData before file is opened. This two lanes resolved this issue
    player->play();
    player->stop();
}

/*  --- SLOTS FOR QML CONTROLS ---  */

void MusicPlayer::playMusic()
{
    if(player->state() == QMediaPlayer::PlayingState)
    {
        player->pause();
    }
    else
    {
        player->play();
    }
}

void MusicPlayer::nextSong()
{
    playlist->next();
}

void MusicPlayer::previouseSong()
{
    playlist->previous();
}

void MusicPlayer::stopMusic()
{
    if(player->state() == QMediaPlayer::PlayingState)
    {
       player->stop();
    }
}

int MusicPlayer::getVolume()
{
    return volume;
}

void MusicPlayer::setVolume(double f_volume)
{
    volume = f_volume;
    emit player->volumeChanged(volume);
}

void MusicPlayer::muteSong()
{
    if(isMuted)
    {
        emit player->mutedChanged(false);
    }
    else
    {
        emit player->mutedChanged(true);
    }
     isMuted = !isMuted;
}

void MusicPlayer::repeatSong()
{
    if(isRepeatModeOn)
    {
        playlist->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }
    else
    {
        playlist->setPlaybackMode(QMediaPlaylist::Loop);
    }
}


// driver for duration slider
/*----------------------------*/
void MusicPlayer::setDurationFromMedia(qint64 f_duration)
{
    // slot to get duration from file metadata
    duration = f_duration;
}

qint64 MusicPlayer::getDuration()
{
    // returning song duration in ms
    return duration;
}

void MusicPlayer::setCurrentPositon(qint64 f_currectSongPosition)
{
    currectSongPosition = f_currectSongPosition/1000;
    emit this->currentPositionChanged();
}

qint64 MusicPlayer::getCurrentPositon()
{
    return currectSongPosition;
}
/*----------------------------*/

void MusicPlayer::setTrackInfo(const QString &info)
{
    trackInfo = info;
}
