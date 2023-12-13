# docker-build-flutter-android

This is a simple dockerfile to create a docker image for building a flutter application in docker.

## Building

```bash
docker build -t eckyecky/build-flutter-android:latest .
```

## Installation

```bash
docker pull eckyecky/build-flutter-android:latest
```

## Usage

To run the tests,

```bash
docker run --rm -v $PWD:/app -w /app eckyecky/build-flutter-android:latest flutter test
```

To build the bundle,

```bash
docker run --rm -v $PWD:/app -w /app eckyecky/build-flutter-android:latest flutter build appbundle --release
```
