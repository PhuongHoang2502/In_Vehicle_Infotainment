/****************************************************************************
** Meta object code from reading C++ file 'CanController.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.8)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../Tesla-Dashboard-UI-3/CanController.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'CanController.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.8. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_CanController_t {
    QByteArrayData data[27];
    char stringdata0[354];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_CanController_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_CanController_t qt_meta_stringdata_CanController = {
    {
QT_MOC_LITERAL(0, 0, 13), // "CanController"
QT_MOC_LITERAL(1, 14, 11), // "gearChanged"
QT_MOC_LITERAL(2, 26, 0), // ""
QT_MOC_LITERAL(3, 27, 12), // "speedChanged"
QT_MOC_LITERAL(4, 40, 12), // "lightChanged"
QT_MOC_LITERAL(5, 53, 18), // "temperatureChanged"
QT_MOC_LITERAL(6, 72, 15), // "humidityChanged"
QT_MOC_LITERAL(7, 88, 15), // "distanceChanged"
QT_MOC_LITERAL(8, 104, 20), // "buzzerEnabledChanged"
QT_MOC_LITERAL(9, 125, 12), // "ledOnChanged"
QT_MOC_LITERAL(10, 138, 22), // "autoBeamEnabledChanged"
QT_MOC_LITERAL(11, 161, 22), // "headlightOutputChanged"
QT_MOC_LITERAL(12, 184, 12), // "toggleBuzzer"
QT_MOC_LITERAL(13, 197, 9), // "toggleLed"
QT_MOC_LITERAL(14, 207, 15), // "receiveCanFrame"
QT_MOC_LITERAL(15, 223, 14), // "handleCanError"
QT_MOC_LITERAL(16, 238, 26), // "QCanBusDevice::CanBusError"
QT_MOC_LITERAL(17, 265, 5), // "error"
QT_MOC_LITERAL(18, 271, 4), // "gear"
QT_MOC_LITERAL(19, 276, 5), // "speed"
QT_MOC_LITERAL(20, 282, 5), // "light"
QT_MOC_LITERAL(21, 288, 11), // "temperature"
QT_MOC_LITERAL(22, 300, 8), // "humidity"
QT_MOC_LITERAL(23, 309, 8), // "distance"
QT_MOC_LITERAL(24, 318, 13), // "buzzerEnabled"
QT_MOC_LITERAL(25, 332, 5), // "ledOn"
QT_MOC_LITERAL(26, 338, 15) // "autoBeamEnabled"

    },
    "CanController\0gearChanged\0\0speedChanged\0"
    "lightChanged\0temperatureChanged\0"
    "humidityChanged\0distanceChanged\0"
    "buzzerEnabledChanged\0ledOnChanged\0"
    "autoBeamEnabledChanged\0headlightOutputChanged\0"
    "toggleBuzzer\0toggleLed\0receiveCanFrame\0"
    "handleCanError\0QCanBusDevice::CanBusError\0"
    "error\0gear\0speed\0light\0temperature\0"
    "humidity\0distance\0buzzerEnabled\0ledOn\0"
    "autoBeamEnabled"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_CanController[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       9,  100, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      10,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   84,    2, 0x06 /* Public */,
       3,    0,   85,    2, 0x06 /* Public */,
       4,    0,   86,    2, 0x06 /* Public */,
       5,    0,   87,    2, 0x06 /* Public */,
       6,    0,   88,    2, 0x06 /* Public */,
       7,    0,   89,    2, 0x06 /* Public */,
       8,    0,   90,    2, 0x06 /* Public */,
       9,    0,   91,    2, 0x06 /* Public */,
      10,    0,   92,    2, 0x06 /* Public */,
      11,    0,   93,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      12,    0,   94,    2, 0x0a /* Public */,
      13,    0,   95,    2, 0x0a /* Public */,
      14,    0,   96,    2, 0x08 /* Private */,
      15,    1,   97,    2, 0x08 /* Private */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 16,   17,

 // properties: name, type, flags
      18, QMetaType::Int, 0x00495001,
      19, QMetaType::Int, 0x00495001,
      20, QMetaType::Int, 0x00495001,
      21, QMetaType::Float, 0x00495001,
      22, QMetaType::Int, 0x00495001,
      23, QMetaType::Int, 0x00495001,
      24, QMetaType::Bool, 0x00495001,
      25, QMetaType::Bool, 0x00495001,
      26, QMetaType::Bool, 0x00495103,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,
       5,
       6,
       7,
       8,

       0        // eod
};

void CanController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<CanController *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->gearChanged(); break;
        case 1: _t->speedChanged(); break;
        case 2: _t->lightChanged(); break;
        case 3: _t->temperatureChanged(); break;
        case 4: _t->humidityChanged(); break;
        case 5: _t->distanceChanged(); break;
        case 6: _t->buzzerEnabledChanged(); break;
        case 7: _t->ledOnChanged(); break;
        case 8: _t->autoBeamEnabledChanged(); break;
        case 9: _t->headlightOutputChanged(); break;
        case 10: _t->toggleBuzzer(); break;
        case 11: _t->toggleLed(); break;
        case 12: _t->receiveCanFrame(); break;
        case 13: _t->handleCanError((*reinterpret_cast< QCanBusDevice::CanBusError(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::gearChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::speedChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::lightChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::temperatureChanged)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::humidityChanged)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::distanceChanged)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::buzzerEnabledChanged)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::ledOnChanged)) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::autoBeamEnabledChanged)) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (CanController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CanController::headlightOutputChanged)) {
                *result = 9;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<CanController *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->gear(); break;
        case 1: *reinterpret_cast< int*>(_v) = _t->speed(); break;
        case 2: *reinterpret_cast< int*>(_v) = _t->light(); break;
        case 3: *reinterpret_cast< float*>(_v) = _t->temperature(); break;
        case 4: *reinterpret_cast< int*>(_v) = _t->humidity(); break;
        case 5: *reinterpret_cast< int*>(_v) = _t->distance(); break;
        case 6: *reinterpret_cast< bool*>(_v) = _t->buzzerEnabled(); break;
        case 7: *reinterpret_cast< bool*>(_v) = _t->ledOn(); break;
        case 8: *reinterpret_cast< bool*>(_v) = _t->autoBeamEnabled(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<CanController *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 8: _t->setAutoBeamEnabled(*reinterpret_cast< bool*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject CanController::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_CanController.data,
    qt_meta_data_CanController,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *CanController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CanController::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CanController.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int CanController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 14)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 14;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 9;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void CanController::gearChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void CanController::speedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void CanController::lightChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void CanController::temperatureChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void CanController::humidityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void CanController::distanceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void CanController::buzzerEnabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void CanController::ledOnChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void CanController::autoBeamEnabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void CanController::headlightOutputChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
