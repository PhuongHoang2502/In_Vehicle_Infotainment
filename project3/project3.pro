QT += quick

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        HeadUnit/HeadUnit.cpp \
        HeadUnit/HeadUnitQtClass.cpp \
        HeadUnit/HeadUnitSenderClass.cpp \
        HeadUnit/HeadUnitStubImpl.cpp \
        HeadUnit/Infotainment/control/audiocontroller.cpp \
        HeadUnit/Infotainment/control/hvachandler.cpp \
        HeadUnit/Infotainment/control/system.cpp \
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

HEADERS += \
    HeadUnit/HeadUnitQtClass.hpp \
    HeadUnit/HeadUnitSenderClass.hpp \
    HeadUnit/HeadUnitStubImpl.hpp \
    HeadUnit/Infotainment/control/audiocontroller.h \
    HeadUnit/Infotainment/control/hvachandler.h \
    HeadUnit/Infotainment/control/system.h

DISTFILES += \
    HeadUnit/icons/Vector 1.png \
    HeadUnit/icons/Vector 1.svg \
    HeadUnit/icons/Vector 2.png \
    HeadUnit/icons/Vector 2.svg
