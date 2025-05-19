In-Car Infotainment System Setup Guide
This README provides instructions for setting up the development environment for an in-car infotainment system project, including Qt setup, STM32 firmware resources, and virtual CAN simulation.
Prerequisites

Ubuntu-based system (tested on Ubuntu 20.04 or later)
Internet connection for package downloads
STM32 microcontroller for firmware development
MCP2515 CAN module for CAN communication

Qt Setup
Install the required Qt packages and dependencies for the infotainment system UI and CAN communication.
sudo apt install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
sudo apt-get install qtcreator
sudo apt-get install qtdeclarative5-dev
sudo apt-get install qml-module-qtquick-window2
sudo apt install qml-module-qtquick-controls2
sudo apt install libsocketcan2 libsocketcan-dev
sudo apt install libqt5svg5-dev
sudo apt install qtmultimedia5-dev
sudo apt-get install libqt5multimedia5-plugins

Qt Serial Bus Setup
To enable CAN communication via Qt, install the QtSerialBus module.
# Install private headers to resolve private/qobject_p.h error
sudo apt-get install qtbase5-private-dev

# Clone and build QtSerialBus
git clone git://code.qt.io/qt/qtserialbus.git
cd qtserialbus
git checkout 5.12
qmake
make -j$(nproc)
sudo make install

For additional reference, see: Qt Serial Bus Gist
STM32 Firmware Development Resources
Below are resources for developing STM32 firmware for peripherals used in the infotainment system. Note that these resources are not exhaustive and serve as starting points.
MCP2515 CAN Controller

MicroPeta Video Tutorial
Naver Blog Tutorial
MCP2515 Datasheet
Beyond Logic: CAN on Raspberry Pi
GitHub Repositories:
RaspberryPi_MCP2515_CAN
CANBus-MCP2515-Raspi
MCP2515-CAN-Bus-Module



SocketCAN

Beyond Logic: SocketCAN Example Code

Light Sensor (LDR)

STM32 LDR Interfacing Tutorial

Analog-to-Digital Converter (ADC)

STM32 ADC Tutorial
STM32 ADC Single Channel Polling

Ultrasonic Sensor (HC-SR04)

HC-SR04 with STM32
STM32 Ultrasonic Input Capture

Virtual CAN Setup
To simulate CAN data remotely, set up a virtual CAN interface.
sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0
ip link show vcan0

Next Steps

Verify Qt installation by running qtcreator and creating a sample QML project.
Test CAN communication using the QtSerialBus module and virtual CAN interface.
Develop STM32 firmware for peripherals (MCP2515, LDR, ADC, ultrasonic sensor) using the provided resources.
Integrate the Qt-based UI with CAN data from the STM32.

Troubleshooting

Ensure all Qt dependencies are installed correctly by checking qmake --version.
If CAN communication fails, verify the MCP2515 module wiring and test with candump vcan0 on the virtual CAN interface.
For STM32 firmware issues, refer to the specific peripheral documentation and example code.

