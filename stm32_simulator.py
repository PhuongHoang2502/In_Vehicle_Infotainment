import can
import time
import random
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')

def main():
    # Initialize CAN bus (vcan0)
    try:
        bus = can.interface.Bus(channel='vcan0', bustype='socketcan')
        logging.info("Connected to vcan0")
    except Exception as e:
        logging.error(f"Failed to connect to vcan0: {e}")
        return

    # Data ranges (mimicking STM32)
    gear_values = [0, 1, 2, 3]  # P, R, N, D
    speed_range = (0, 400)       # km/h
    light_range = (0, 100)       # %
    temp_range = (0, 500)        # 0.0-50.0°C (x10)
    humidity_range = (0, 100)    # %
    distance_range = (0, 400)    # cm
    buzzer_values = [0, 1]
    led_values = [0, 1]

    try:
        while True:
            # Gear (ID 0x100, 1 byte)
            gear = random.choice(gear_values)
            msg = can.Message(arbitration_id=0x100, data=[gear], is_extended_id=False)
            bus.send(msg)
            logging.info(f"Sent ID=0x100, Data={gear:02X}")

            # Speed (ID 0x101, 2 bytes, big-endian)
            speed = random.randint(*speed_range)
            data = [(speed >> 8) & 0xFF, speed & 0xFF]
            msg = can.Message(arbitration_id=0x101, data=data, is_extended_id=False)
            bus.send(msg)
            logging.info(f"Sent ID=0x101, Data={data[0]:02X} {data[1]:02X} ({speed} km/h)")

            # Light (ID 0x102, 1 byte)
            light = random.randint(*light_range)
            msg = can.Message(arbitration_id=0x102, data=[light], is_extended_id=False)
            bus.send(msg)
            logging.info(f"Sent ID=0x102, Data={light:02X}")

            # Temperature (ID 0x103, 2 bytes, big-endian, x10)
            temp = random.randint(*temp_range)
            data = [(temp >> 8) & 0xFF, temp & 0xFF]
            msg = can.Message(arbitration_id=0x103, data=data, is_extended_id=False)
            bus.send(msg)
            logging.info(f"Sent ID=0x103, Data={data[0]:02X} {data[1]:02X} ({temp/10.0:.1f}°C)")

            # Humidity (ID 0x104, 1 byte)
            humidity = random.randint(*humidity_range)
            msg = can.Message(arbitration_id=0x104, data=[humidity], is_extended_id=False)
            bus.send(msg)
            logging.info(f"Sent ID=0x104, Data={humidity:02X}")

            # Distance (ID 0x105, 2 bytes, big-endian)
            distance = random.randint(*distance_range)
            data = [(distance >> 8) & 0xFF, distance & 0xFF]
            msg = can.Message(arbitration_id=0x105, data=data, is_extended_id=False)
            bus.send(msg)
            logging.info(f"Sent ID=0x105, Data={data[0]:02X} {data[1]:02X} ({distance} cm)")

            # # Buzzer (ID 0x106, 1 byte)
            # buzzer = random.choice(buzzer_values)
            # msg = can.Message(arbitration_id=0x106, data=[buzzer], is_extended_id=False)
            # bus.send(msg)
            # logging.info(f"Sent ID=0x106, Data={buzzer:02X}")

            # # LED (ID 0x107, 1 byte)
            # led = random.choice(led_values)
            # msg = can.Message(arbitration_id=0x107, data=[led], is_extended_id=False)
            # bus.send(msg)
            # logging.info(f"Sent ID=0x107, Data={led:02X}")

            # Receive control messages (buzzer 0x200, LED 0x201)
            msg = bus.recv(timeout=0.1)
            if msg:
                logging.info(f"Received ID=0x{msg.arbitration_id:X}, Data=" + " ".join(f"{b:02X}" for b in msg.data))

            time.sleep(3)  # Send every 1 second

    except KeyboardInterrupt:
        logging.info("Simulator stopped")
    except Exception as e:
        logging.error(f"Error: {e}")
    finally:
        bus.shutdown()

if __name__ == "__main__":
    main()
