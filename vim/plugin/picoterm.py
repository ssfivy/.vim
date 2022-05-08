#!/usr/bin/env python3

#Super miniature terminal
# only supports opening a serial device and reading data for now

import argparse
import serial
import sys

default_port = 'COM3'
default_baudrate = 115200

parser = argparse.ArgumentParser(description='Reads data from serial port')
parser.add_argument('-p', metavar = 'port', type=str, default=default_port, help='Serial port device' )
parser.add_argument('-b', metavar='baudrate', type=int, default=default_baudrate, help='Baudrate of the serial connection')
args = parser.parse_args()

with serial.Serial(args.p, args.b, timeout=1) as ser:
    while True:
        sys.stdout.write(ser.read())

