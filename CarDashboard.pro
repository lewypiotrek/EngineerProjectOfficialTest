QT += quick virtualkeyboard
QT += multimedia
QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        COMPONENTS/MediaPlayer/musicplayer.cpp \
        COMPONENTS/RadioPlayer/radioplayer.cpp \
        COMPONENTS/RadioPlayer/tea5767driver.cpp \
        COMPONENTS/WebBrowser/webbrowser.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    COMPONENTS/MediaPlayer/musicplayer.h \
    COMPONENTS/RadioPlayer/radioplayer.h \
    COMPONENTS/RadioPlayer/tea5767driver.h \
    COMPONENTS/WebBrowser/webbrowser.h

LIBS +=-L/home/plewandowski/rpi/sysroot/usr/lib -lwiringPi
