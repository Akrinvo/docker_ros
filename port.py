


import os
try:
    import pyudev
except:
    os.system("sudo apt-get install python3-pip")
    os.system("pip install pyudev")
    import pyudev

context = pyudev.Context()
major,minor=8,0
device=pyudev.Devices.from_name(context, "tty","ttyUSB0")
kernel_=str(device).split('/')[-4]
#/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0

print(kernel_)
name="esp_2"
commands = [f'echo \'KERNEL=="ttyUSB*", KERNELS=="{kernel_}", SYMLINK+="{name}", MODE=="0666"\' |  tee /etc/udev/rules.d/99-usb-serial.rules',"udevadm control --reload-rules"]

def global_path_maker():
     
    while commands :
        print("Start")
        com=commands.pop(0)
        print(com)
        aa=os.system(com)
        print(aa,"end")

global_path_maker()
