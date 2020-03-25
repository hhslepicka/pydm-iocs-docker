
# PyDM IOCs Docker

A docker image with Simulated Motors and AreaDetector IOCs built-in.


## How to run the container

```
$ docker pull pydm/pydm-iocs:latest
$ docker run --rm -it -p 5064:5064 -p 5064:5064/udp -p 5065:5065 pydm/pydm-iocs
```

## Which IOCs are available

#### Motor Record Instances
IOC:m1 .. IOC:m6

#### Area Detector SimDetector Instance
13SIM1:cam1 .. 13SIM1:cam2

#### Linker
In order to simulate a beam alignment the Linker IOC connects Motor `IOC:m1` to
the `13SIM1:cam1:PeakStartX` and `IOC:m2` to `13SIM1:cam1:PeakStartY`.
This generates the effect of a beam alignment since when those motors are moved
the simulated peak moves on the image.

##### Linker Database

This is the `db` file used for the linker.
```
record(seq, "linkX")
{
	field(DESC, "Link to X Start on camera")
	field(DOL1, "IOC:m1.RBV CP")
	field(LNK1, "13SIM1:cam1:PeakStartX CA PP")
}

record(seq, "linkY")
{
	field(DESC, "Link to Y Start on camera")
	field(DOL1, "IOC:m2.RBV CP")
	field(LNK1, "13SIM1:cam1:PeakStartY CA PP")
}
```


## How to build the container

You can build the container, for example, like this:

```
$ git clone https://github.com/hhslepicka/pydm-iocs-docker.git
$ cd pydm-iocs-docker
$ docker build -t pydm/pydm-iocs .
```
