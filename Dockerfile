ARG CMDLINE_TOOLS_VERSION=11076708
ARG FLUTTER_VERSION=3.16.9
FROM ubuntu:latest

RUN apt-get update && apt-get install -y unzip curl openjdk-18-jdk-headless xz-utils git ruby ruby-dev build-essential && gem install bundler

WORKDIR /opt/android/cmdline-tools

RUN curl -o tools.zip -L "https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip" && \
    unzip tools.zip && \
    rm tools.zip && \
    mv cmdline-tools latest && \
    latest/bin/sdkmanager --update && \
    yes | latest/bin/sdkmanager --licenses && \
    yes | latest/bin/sdkmanager "platform-tools"

ENV PATH="/opt/android/cmdline-tools/latest/bin:/opt/flutter/bin:${PATH}"

RUN curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar xJ -C /opt && \
    git config --global --add safe.directory /opt/flutter && \
    flutter config --android-sdk /opt/android
