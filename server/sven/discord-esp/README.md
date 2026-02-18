# Compile and flash firmware

### Flash USB
```bash
docker run --rm --privileged -v "${PWD}":/config --device=/dev/ttyUSB0 -it ghcr.io/esphome/esphome run firmware.yaml
```


### Flash OTA
```bash
docker run --rm --privileged -v "${PWD}":/config -it ghcr.io/esphome/esphome run firmware.yaml --device=10.13.13.2
```