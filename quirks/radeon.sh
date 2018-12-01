#!/bin/bash
# This script sets the configuration for my AMD Radeon HD 7950.

sudo tee '/usr/share/X11/xorg.conf.d/20-radeon.conf' << EOF
Section "Device"
    # Do 'man radeon' for more information
    Identifier "Radeon"
    Driver "radeon"
    Option "DRI" "3"
    Option "DynamicPM" "on" # Dynamic powersaving
    Option "ClockGating" "on" # Assisting option for powersaving
    Option "AccelMethod" "glamor" # Glamor is default since TAHITI
    Option "ColorTiling" "on" # Increases 3D stability
    Option "ColorTiling2D" "on"
    Option "ShadowPrimary" "on" # May improve performance for 2D over 3D.
                                # Disables page flipping.
    Option "EnablePageFlip" "on"
    Option "TearFree" "on"

    #Option "EXAVSync" "on" # EXAVSync is explained above.
    #Option "DMAForXv" "on" # Forced option in order to enable Xv overlay.
    #Option "ScalerWidth" "2048" # That should fix some very rare bugs.
    #Option "RenderAccel" "on" # Optional. It should be enabled by default.
    #Option "AccelDFS" "on" #Optional. See the man page.
    #Option "AccelMethod" "XAA"
    # XAA/EXA
    #Option "AccelDFS"    "1"
    # 1/0 On for PCIE, off for AGP
    # Manpage: Use  or  don't  use accelerated EXA DownloadFromScreen hook
    # when possible.
    #Option "AGPMode" "1"
    # 1-8 Does not affect PCIE models.
    #Option "AGPFastWrite" "1"
    # 1/0 Does not affect PCIE models. Not recommended.
    #Option "GARTSize" "64"
    # 0-64 Megabytes of gart (system) memory used.
    # Wrongly defaults to 8MB sometimes, see your logfile.
    # Bigger seems better.
    #Option "EnablePageFlip" "1"
    # 1/0 Increases 3D performance substantially
    # seemingly in XAA mode only
    # 1/0 Increases 3D performance substantially
    # affected stability only positively on my system
EndSection

Section "DRI"
    Group "video"
    Mode 0660
EndSection
EOF
