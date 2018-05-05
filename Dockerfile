FROM alpine:latest
MAINTAINER Wesley Castro <root670@gmail.com>

ARG BINUTILS_VERSION=2.30
ARG GCC_VERSION=7.3.0
ARG PSXSDK_URL=http://unhaut.x10host.com/psxsdk/psxsdk-20180115.tar.bz2

WORKDIR /build

# Install build dependencies
RUN apk update && apk upgrade && apk add \
  bash \
  gcc \
  g++ \
  gmp-dev \
  make \
  mpc1-dev \
  mpfr-dev \
  musl-dev \
  patch \
  wget

# Compile binutils
RUN wget http://ftpmirror.gnu.org/binutils/binutils-${BINUTILS_VERSION}.tar.xz && \
  tar -xf binutils-${BINUTILS_VERSION}.tar.xz && \
  cd binutils-${BINUTILS_VERSION} && \
  mkdir build && \
  cd build && \
  ../configure --disable-nls --prefix='/usr/local/psxsdk' --target=mipsel-unknown-elf --with-float=soft && \
  make && \
  make install && \
  cd ../.. && \
  rm -rf binutils-${BINUTILS_VERSION}

# Compile GCC
RUN wget http://ftpmirror.gnu.org/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz && \
  tar -xf gcc-${GCC_VERSION}.tar.xz && \
  cd gcc-${GCC_VERSION} && \
  mkdir build && \
  cd build && \
  ../configure --disable-nls --disable-libada --disable-libssp --disable-libquadmath --disable-libstdc++-v3 --target=mipsel-unknown-elf --prefix='/usr/local/psxsdk' --with-float=soft --enable-languages=c && \
  make && \
  make install && \
  cd ../.. && \
  rm -rf gcc-${GCC_VERSION}

# Remove dependencies no longer needed
RUN cd / && \
  rm -rf /build/* && \
  apk del \
  gcc \
  g++ \
  gmp-dev \
  mpc1-dev \
  mpfr-dev
