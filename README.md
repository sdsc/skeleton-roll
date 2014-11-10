# SDSC "skeleton" roll

## Overview

This roll bundles... <REPLACE_ME> 

For more information about the various packages included in the skeleton roll please visit their official web pages:

- <a href="" target="_blank"></a> is .
- <a href="" target="_blank"></a> is .


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate skeleton source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

Unknown at this time.


## Building

To build the skeleton-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make default 2>&1 | tee build.log
% grep "RPM build error" build.log
```

A successful build will create the file `skeleton-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers and for different
network fabrics and mpi flavors.  By default, it builds using the gnu compilers
for openmpi ethernet.  To build for a different configuration, use the
`ROLLCOMPILER`, `ROLLMPI` and `ROLLNETWORK` make variables, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mpich2 ROLLNETWORK=mx 
```

This roll source supports building with different compilers. The 
`ROLLCOMPILER` make variable can be used to specify the names of compiler 
modulefiles to use for building the software, e.g.,


 ```shell
 % make ROLLCOMPILER=gnu/4.9.1
 ```

If the `ROLLCOMPILER` and/or `ROLLMPI` variables are specified, their values 
are incorporated into the names of the produced roll and rpms, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2_ib
```
produces a roll with a name that begins "`skeleton_intel_mvapich2_ib`"; it
contains and installs similarly-named rpms.

The roll also supports a `ROLLOPTS` make variable values of 'avx' or 'avx2', 
indicating that the target architecture supports AVX or AVX2 instructions.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll skeleton*.iso
% rocks enable roll skeleton
% cd /export/rocks/install
% rocks create distro
% rocks run roll skeleton | bash
```

In addition to the software itself, the roll installs skeleton environment
module files in:

```shell
/opt/modulefiles/applications/.(compiler)/skeleton
```


## Testing

The skeleton-roll includes a test script which can be run to verify proper
installation of the skeleton-roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/skeleton.t 
ok 1 - skeleton is installed
ok 2 - skeleton test run
ok 3 - skeleton module installed
ok 4 - skeleton version module installed
ok 5 - skeleton version module link created
1..5
```

