#!/bin/bash
# Old school RuneScape client. Not free software!

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/runescape"
rm -rf "$INSTALL"
mkdir -p "$INSTALL"

wget -O "$INSTALL/OldSchool.msi" "http://www.runescape.com/downloads/oldschool.msi" \
&& 7z e -o"$INSTALL/OldSchool-msi" -y "$INSTALL/OldSchool.msi" \
&& 7z e -o"$INSTALL/rslauncher-cab" -y "$INSTALL/OldSchool-msi/rslauncher.cab" \
&& cp "$INSTALL/rslauncher-cab/JagexAppletViewerJarFile"* "$INSTALL/jagexappletviewer.jar"

tee $HOME/.local/bin/runescape << EOF
cd "$INSTALL" && java -Duser.home="." -Djava.class.path="jagexappletviewer.jar" -Dcom.jagex.config="http://oldschool.runescape.com/jav_config.ws" "jagexappletviewer" "oldschool"
EOF
chmod +x $HOME/.local/bin/runescape
