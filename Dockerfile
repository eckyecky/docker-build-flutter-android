FROM ubuntu:latest

ARG CMDLINE_TOOLS_VERSION=13114758
ARG FLUTTER_VERSION=3.32.8
ARG OPENJDK_VERSION=21
ARG ANDROID_VERSION=35

ENV PATH="/opt/android/cmdline-tools/latest/bin:/opt/flutter/bin:${PATH}"

RUN apt-get update && apt-get install -y unzip curl openjdk-${OPENJDK_VERSION}-jdk-headless xz-utils git ruby ruby-dev build-essential && gem install bundler && chown -Rc 1000:1000 /opt

USER 1000:1000
WORKDIR /opt/android/cmdline-tools

RUN curl -o tools.zip -L "https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip" && \
    unzip tools.zip && \
    rm tools.zip && \
    mv cmdline-tools latest && \
    sdkmanager --update && \
    yes | sdkmanager --licenses && \
    yes | sdkmanager "platforms;android-${ANDROID_VERSION}"

RUN curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar xJ -C /opt && \
    git config --global --add safe.directory /opt/flutter && \
    flutter config --android-sdk /opt/android

