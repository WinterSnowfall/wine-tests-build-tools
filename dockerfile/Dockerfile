FROM archlinux:latest

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
    && pacman -Syu --noconfirm && pacman -S --noconfirm \
    mingw-w64-gcc \
    glslang \
    git \
    make \
    gcc \
    lib32-gcc-libs \
    flex \
    bison \
    libx11 \
    libxcomposite \
    libxcursor \
    libxfixes \
    libxi \
    libxrandr \
    libxrender \
    libxext \
    freetype2 \
    fontconfig \
    pkgconf \
    mesa \
    sdl2 \
    alsa-lib \
    libpulse \
    gstreamer \
    gst-plugins-base-libs
RUN useradd -m builder \
    && chmod 777 /home/builder
    
USER builder

WORKDIR /home/builder/source

ENV TEST_LIB=d3d8
ENV BUILD_X86_BITS=32

CMD ["bash", "-c", "/home/builder/source/wine_build.sh $TEST_LIB $BUILD_X86_BITS"]

