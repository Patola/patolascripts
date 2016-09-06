#!/usr/bin/python
from gi.repository import Gtk
import sys,re,os,time
import urllib2
import subprocess,signal



bitRates={
  "QVGA":(1,[128,256,384,512]),
  "VGA":(0,[128,256,384,512,640,768,896,1024]),
  "720P":(3,[128,256,384,512,640,768,896,1024,1280,1536,1792,2048,2560,3072,3584,4096])
}
frameRates=range(1,31)

# default values
wCamDefaultPort=81
wCamDefaultMode="VGA"
wCamDefaultBitRate=1024
wCamDefaultFrameRate=15
wCamAddress="10.0.0.54"    # wCamAddress is mandatory
wCamDefaultUser="admin"
wCamDefaultPassWord="888888"


wCamPort = wCamDefaultPort
wCamMode=wCamDefaultMode
wCamBitRate=wCamDefaultBitRate
wCamFrameRate=wCamDefaultFrameRate
wCamAddress=None    # wCamAddress is mandatory
wCamUser=wCamDefaultUser
wCamPassWord=wCamDefaultPassWord
wCamTitle=None

mplayerPid=None



def usage():
    print "Usage : %s <OPTIONS>" % (sys.argv[0])
    print "-h,  --help                        show this help"
    print "-u,  --user=<user>                 set user ( default is [%s] )" % (wCamDefaultUser)
    print "-x,  --password=<password>         set password ( default is [%s] )" % (wCamDefaultPassWord)
    print "-a,  --address=<webcam address>    set webcam address e.g -i 192.168.0.253 or -i=starcam.myhome.lan ( mandatory )"
    print "-p,  --port=<webcam ip address>    set webcam port e.g. -p 81 (default is [%s])" % (wCamDefaultPort) 
    print "-m,  --mode=<mode>                 set output resolution: allowed values: QVGA, VGA, 720P e.g. -m VGA (default is [%s])" % (wCamDefaultMode)
    print "-b,  --bitrate=<bitrate>           set bitrate: allowed values depends from mode: (default is [%s])" % (wCamDefaultBitRate)
    for mode,rates in bitRates.iteritems():
      print "                                        for %s: %s" % (mode,rates[1])
    print "-f,  --framerate=<fps>             set framerate: allowed values %s e.g -f 25 (default is [%s])" % (frameRates,wCamDefaultFrameRate)

    sys.exit(1)



def kill_child_processes(parent_pid,sig=signal.SIGTERM):
        
    cmd="ps -o pid --ppid %d --noheaders" % (parent_pid)
    print "cmd [%s]" % (cmd)
    ps_command = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    ps_output = ps_command.stdout.read()
    retcode = ps_command.wait()
    if retcode == 0:
      for pid_str in ps_output.split("\n")[:-1]:
          kill_child_processes (int(pid_str))
          print "child kill pid %s" % (pid_str)
          try:
            os.kill(int(pid_str), sig)
          except:
            pass


    else:
      try:
        os.kill(parent_pid, sig)
      except:
        pass
      



# http://starcam/camera_control.cgi?loginuse=admin&loginpas=888888&param=13&value=512&140094356 38360.6156135550700128&_=140094356 3838

def httpGet(uri,params):
    import random
    import time
#    params="%s&%f" % (params,time.time()*1000+random.random())
    url="http://%s:%s/%s?loginuse=%s&loginpas=%s&%s" % (wCamAddress,wCamPort,uri,wCamUser,wCamPassWord,params)
    print url

    sock=urllib2.urlopen (url,None,4)
    response = sock.read()
    sock.close()

    print response


class CamWindow(Gtk.Window):

    def __init__(self):


        Gtk.Window.__init__(self, title="CAM control")
        self.set_border_width(10)
        self.set_title(wCamTitle)


# http://python-gtk-3-tutorial.readthedocs.org/en/latest/layout.html#grid

        grid = Gtk.Grid()
        self.add(grid)

        top = Gtk.Button("Up")
        top.connect("pressed", self._pressed,"decoder_control.cgi","command=0&onestep=0")
        top.connect("released", self._released,"decoder_control.cgi","command=1&onestep=0")

        grid.attach(top, 1, 0, 1, 1)

        left = Gtk.Button("Left")
        left.connect("pressed", self._pressed,"decoder_control.cgi","command=4&onestep=0")
        left.connect("released", self._released,"decoder_control.cgi","command=5&onestep=0")
        grid.attach(left, 0, 1, 1, 1)

        right = Gtk.Button("Right")
        right.connect("pressed", self._pressed,"decoder_control.cgi","command=6&onestep=0")
        right.connect("released", self._released,"decoder_control.cgi","command=7&onestep=0")
        grid.attach(right, 2, 1, 1, 1)

        bottom = Gtk.Button("Down")
        bottom.connect("pressed", self._pressed,"decoder_control.cgi","command=2&onestep=0")
        bottom.connect("released", self._released,"decoder_control.cgi","command=3&onestep=0")

        grid.attach(bottom, 1, 2, 1, 1)


        zoomout = Gtk.Button("Zoom Out")
        zoomout.connect("pressed", self._pressed,"camera_control.cgi","param=17&value=1")
        zoomout.connect("released", self._released,"camera_control.cgi","param=17&value=0")

        grid.attach(zoomout, 3, 2, 1, 1)

        zoomin = Gtk.Button("Zoom In")
        zoomin.connect("pressed", self._pressed,"camera_control.cgi","param=18&value=1")
        zoomin.connect("released", self._released,"camera_control.cgi","param=18&value=0")

        grid.attach(zoomin, 3, 0, 1, 1)



    def _pressed(self, button,uri,params):
        print("press")
        httpGet (uri,params)

    def _released(self, button,uri,params):
        print("release")
        httpGet (uri,params)



    def on_close_clicked(self, button):
        print("Closing application")
        Gtk.main_quit()



def go():
    win = CamWindow()
    win.connect("delete-event", Gtk.main_quit)
    win.show_all()
    Gtk.main()


if __name__ == '__main__':
    import getopt
    try:
        opts, args = getopt.getopt(sys.argv[1:], "a:p:m:b:f:h", ["help", "address=","port=","mode=","bitrate=","framerate="])
    except getopt.GetoptError:
        # print help information and exit:
        usage()
        sys.exit(2)
      
    verbose = False

    for o, a in opts:
        if o in ( "-u","--user"):
            wCamUser = a
        if o in ( "-x","--password"):
            wCamPassWord = a
        if o in ( "-a","--address"):
            wCamAddress = a
        if o in ( "-p","--port"):
            wCamPort = a
        if o in ( "-m","--mode"):
            wCamMode = a
        if o in ( "-b","--bitrate"):
            wCamBitRate = int(a)
        if o in ( "-f","--framerate"):
            wCamFrameRate = int(a)

        if o in ( "-v","--verbose"):
            verbose = a
        if o in ("-h","--help"):
            usage()

    if (not wCamAddress):
        usage()            
            
        
    if verbose:
        print "Verbose is [%d]" % (verbose)


    if wCamMode not in bitRates.keys():
        print "Invalid Mode [%s]" % (wCamMode)
        usage()
    else:        
        if not wCamBitRate in bitRates[wCamMode][1]:
            print "Invalid bitRate [%s] for mode [%s]" % (wCamBitRate, wCamMode)
            usage()

    if wCamFrameRate not in frameRates:
        print "Invalid frameRate [%s]" % (wCamFrameRate)
        usage()

    wCamTitle="%s:%s" % (wCamAddress,wCamPort)
    print "Using user %s:%s %s:%s, mode %s, bitrate %s, framerate %s" % (wCamUser,wCamPassWord,wCamAddress,wCamPort,wCamMode,wCamBitRate,wCamFrameRate)



# set framerate
    httpGet ("camera_control.cgi","param=6&value=%d" % (wCamFrameRate))
    time.sleep(1)
    #httpGet ("get_camera_params.cgi","")

# set video format
    httpGet ("camera_control.cgi","param=0&value=%s" % (bitRates[wCamMode][0]))
    time.sleep(1)


    httpGet ("get_camera_params.cgi","")



    streamingUrl="http://%s:%s/livestream.cgi?user=%s&pwd=%s&streamid=0&audio=0&filename=" % (wCamAddress,wCamPort,wCamUser,wCamPassWord)
    cmd="curl -s \"%s\" | mplayer -title \"%s\" -quiet -nocache -vc ffh264 -demuxer h264es -fps %s -noextbased -" % (streamingUrl,wCamTitle,wCamFrameRate)

    mplayerPid=os.fork()
    print "player pid %d" % (mplayerPid)
    if not mplayerPid:
      os.system (cmd)
    else:
      time.sleep(4)
  # set bitrate
      httpGet ("camera_control.cgi","param=13&value=%d" % (wCamBitRate))

      go()
      kill_child_processes (mplayerPid)
      #os.kill (mplayerPid,signal.SIGTERM)


