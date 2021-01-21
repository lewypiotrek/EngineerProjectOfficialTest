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
    connect(player, &QMediaPlayer::durationChanged, this, &MusicPlayer::durationChanged);
    connect(player, QOverload<>::of(&QMediaPlayer::metaDataChanged), this, &MusicPlayer::metaDataChanged);

    // Connectiong slot and signals to handle all QML controls
    connect(player,SIGNAL(volumeChanged(int)),player,SLOT(setVolume(int)));
    connect(player,SIGNAL(durationChanged(qint64)),this,SLOT(setDuration(qint64)));

    // Additionals settings
    tracksDefaultPath = "/home/pi/Music";

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

void MusicPlayer::durationChanged(qint64 f_duration)
{
    duration = f_duration / 1000;

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
    QStringList musicFiles = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files|QDir::Readable);

    // load items from string list to playlist
    foreach(QString fileName, musicFiles){
        playlist->addMedia(QMediaContent(QUrl::fromLocalFile(tracksDefaultPath + "/" + fileName)));
    }
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

void MusicPlayer::setDuration(qint64 f_duration)
{
    duration = f_duration;
}

qint64 MusicPlayer::getDuration()
{
    return duration;
}


void MusicPlayer::setTrackInfo(const QString &info)
{
    trackInfo = info;
}
