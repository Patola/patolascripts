#!/usr/bin/python3

from bluepy import btle
import sys

class DiscoLH(btle.DefaultDelegate):

    def __init__(self):
        self.devices = []
        btle.DefaultDelegate.__init__(self)

    def handleDiscovery(self, dev, isNewDev, isNewData):
        if not isNewDev:
            return

        isLH = False
        name = ""

        v = dev.getValue(btle.ScanEntry.MANUFACTURER)

        if v is not None and v[0:4] == b'\x5d\x05\x00\x02':
            print('Found LightHouse %s: address = %s' %
                  (dev.getValue(btle.ScanEntry.COMPLETE_LOCAL_NAME), dev.addr))
            self.devices.append(dev.addr)

if __name__ == '__main__':
    scanner = btle.Scanner()
    delegate = DiscoLH()
    scanner.withDelegate(delegate)
    scanner.scan(2)
    for device in delegate.devices:
        lh = btle.Peripheral()
        print("Connecting to %s" % (device))
        lh.connect(device, addrType = btle.ADDR_TYPE_RANDOM)
        if len(sys.argv) > 1 and sys.argv[1] == 'on':
            lh.writeCharacteristic(0x12, b'\x01')
        elif len(sys.argv) > 1 and sys.argv[1] == 'off':
            lh.writeCharacteristic(0x12, b'\x00')
        else:
            # toggle
            current = lh.readCharacteristic(0x12)
            if(current) == b'\x00':
                # turn on
                lh.writeCharacteristic(0x12, b'\x01')
            else:
                # turn off
                lh.writeCharacteristic(0x12, b'\x00')
        lh.disconnect()
