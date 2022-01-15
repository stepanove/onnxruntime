# Build (or cross-build) ONNX runtime for Ubuntu aarch64 (RPi 4 and similar) using docker
To build a wheel file on x86_64 PC you can use quemu:
```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```
Build a docker image using a command like this:
```
docker build -t onnx -f Dockerfile .
```
It will take some time, after it finishes you should have an image tagged "onnx"


To extract a weel file from the image, execute following command:
````
docker run --rm onnx tar -cC /workspace/onnxruntime/build/Linux/Release/dist/ *.whl | tar -xvC ./
````
It will create and start a container, copy the wheel file into the current directory and remove the container.

# References 
https://onnxruntime.ai/docs/build/inferencing.html
