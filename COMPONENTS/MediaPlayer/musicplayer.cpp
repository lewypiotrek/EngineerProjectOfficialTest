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

    // Connectiong slot and signals to handle all QML controls
    connect(player,SIGNAL(volumeChanged(int)),player,SLOT(setVolume(int)));
    connect(player,SIGNAL(durationChanged(qint64)),this,SLOT(setDuration(qint64)));
    connect(player,SIGNAL(mutedChanged(bool)),player,SLOT(setMuted(bool)));

    // Connecting signals to handle music duration and current position for slider
    connect(player,SIGNAL(durationChanged(qint64)),this,SLOT(setDurationFromMedia(qint64)));

    // Connecting signals to handle duration slider - showing acctually position
    connect(player,SIGNAL(positionChanged(qint64)),this,SLOT(setCurrentPositon(qint64)));

    // Slot to update data when the song is automatically switched
    connect(playlist, SIGNAL(currentIndexChanged(int)),this,SLOT(UpdateSongInformation()));

    // Additionals variables settings
    tracksDefaultPath = "/home/pi/Music";
    isMuted = false;
    isRepeatModeOn = false;
    volume = 100;
    duration = 0;
    currectSongPosition = 1;
    songTitle = "...";
    playlistSize = 0;

    // Load playlist
    loadTracksFromDefaultUrl();
}

MusicPlayer::~MusicPlayer()
{
    delete playlist;
    delete player;
}

void MusicPlayer::loadTracksFromDefaultUrl()
{
    // load files to string list
    QDir directory(tracksDefaultPath);
    musicFiles = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files|QDir::Readable);

    playlistSize = musicFiles.size();

    // load items from string list to playlist
    foreach(QString fileName, musicFiles){        
        playlist->addMedia(QMediaContent(QUrl::fromLocalFile(tracksDefaultPath + "/" + fileName)));
    }

    // This is nessery to upload information about duration, etc. There is no easy way to
    // read metaData before file is opened. This two lanes resolved this issue
    player->play();
    player->stop();

    // Inform QML that the playlist has been changed
    emit playlistModelChanged();
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
        // restart current position
        setCurrentPositon(0);
        player->play();
        emit this->currentPositionChanged();
    }
}

void MusicPlayer::nextSong()
{
    if(playlist->currentIndex() + 1 < playlistSize)
    {
        playlist->next();
        currectSongPosition = 1;
        UpdateSongInformation();
    }
}

void MusicPlayer::previouseSong()
{
    if(playlist->currentIndex() - 1 >= 0)
    {
        playlist->previous();
        currectSongPosition = 1;
        UpdateSongInformation();
    }
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

QString MusicPlayer::getSongTitle()
{
    songTitle = musicFiles[playlist->currentIndex()];
    return songTitle;
}

void MusicPlayer::setSongTitle(QString f_title)
{
    songTitle = f_title;
    emit this->currentPositionChanged();
}

void MusicPlayer::playIndex(int f_index)
{
    try{
        if(f_index >= 0)
        {
            // Set the right music file
            stopMusic();
            playlist->setCurrentIndex(f_index);

            // Update duration and song title
            duration = 0;
            setCurrentPositon(0);

            // Start playing music
            playMusic();
            setSongTitle(musicFiles[playlist->currentIndex()]);
            emit currentPositionChanged();
            UpdateSongInformation();
        }
    }
    catch(...)
    {
        qDebug() << "Error: Cannot play index: " + QString::number(f_index) + " musicplayer.cpp 189 line\n";
    }
}

void MusicPlayer::UpdateSongInformation()
{
    emit songTitleChanged();
    emit currentPositionChanged();
}
