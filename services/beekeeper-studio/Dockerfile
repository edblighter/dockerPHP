FROM debian:13-slim

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NOVNC_PORT=8080 \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x800

# ----------------------------------------------------------
# Install required dependencies, Beekeeper Studio, and setup environment
# ----------------------------------------------------------
RUN apt-get update && apt-get install -y \
    # GUI
    xfce4 xfce4-terminal mousepad dbus-x11 \
    # VNC / X11
    tigervnc-standalone-server tigervnc-tools x11-xserver-utils \
    # noVNC + tools
    python3 python3-websockify wget curl git unzip \
    # AppImage required libs (runtime only)
    libglib2.0-0 libgdk-pixbuf-2.0-0 libgtk-3-0 libnss3 libxss1 libasound2 libnotify4 \
    libsecret-1-0 libxkbfile1 libx11-xcb1 libxcb-dri3-0 libxcb-shape0 libxcb-randr0 \
    xdg-utils ca-certificates gnupg gpg \
    && useradd -m -s /bin/bash docker \
    && mkdir -p /etc/apt/keyrings \
    && wget -q -O - https://deb.beekeeperstudio.io/beekeeper.key | gpg --dearmor -o /etc/apt/keyrings/beekeeper-studio.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/beekeeper-studio.gpg] https://deb.beekeeperstudio.io stable main" > /etc/apt/sources.list.d/beekeeper-studio.list \
    && apt-get update && apt-get install -y beekeeper-studio \
    && git clone https://github.com/novnc/noVNC.git /opt/novnc \
    && git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify \
    && ln -s /opt/novnc/vnc.html /opt/novnc/index.html \
    && mkdir -p /home/docker/.vnc /home/docker/.config/tigervnc \
    && echo "securepass" | vncpasswd -f > /home/docker/.vnc/passwd \
    && chmod 600 /home/docker/.vnc/passwd \
    && echo "SecurityTypes=None" > /home/docker/.config/tigervnc/config \
    && echo '#!/bin/bash\n\
xrdb $HOME/.Xresources\n\
startxfce4 &\n\
beekeeper-studio &' \
> /home/docker/.vnc/xstartup && chmod +x /home/docker/.vnc/xstartup \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && chown -R docker:docker /home/docker

ENV HOME=/home/docker
WORKDIR /home/docker

# ----------------------------------------------------------
# Entrypoint script
# ----------------------------------------------------------
RUN echo '#!/bin/bash\n\
export USER=docker\n\
export HOME=/home/docker\n\
\n\
mkdir -p $HOME/.vnc\n\
mkdir -p $HOME/.config/tigervnc\n\
rm -f $HOME/.vnc/*.pid\n\
rm -f /tmp/.X11-unix/X1\n\
\n\
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION\n\
sleep 2\n\
\n\
/opt/novnc/utils/novnc_proxy --vnc localhost:$VNC_PORT --listen $NOVNC_PORT\n\
\n\
tail -f /dev/null' \
> /home/docker/start.sh && chmod +x /home/docker/start.sh

EXPOSE 8080

CMD ["/home/docker/start.sh"]
