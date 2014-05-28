# Texada Readme

### Directory Structure

Texada
   /bin  -- contains top-level makefile object files
      /src -- contains src objects
      /tests -- contains test objects
   /src -- source code for main project
   /tests -- main project tests

### Required Libraries

Texada relies on two non-standard libraries, [SPOT](http://spot.lip6.fr/wiki/GetSpot) and [Google Test](https://code.google.com/p/googletest/). Google Test can be used in Eclipse if the C/C++ Unit Testing Support item, which can be installed from CDT Optional Features in the Eclipse Install New Software Dialogue.

### Cloning project

An installation of mercurial is required.
Create a bitbucket account and navigate to https://bitbucket.org/bestchai/texada. Clicking on "Clone" will give you the correct terminal command to clone, something like:
hg clone https://yourusername@bitbucket.org/bestchai/texada
From there, you can either run this command directly from terminal, whilst in the directory you wish to clone to, or go from Eclipse. 
To clone from Eclipse, you'll need the MercurialEclipse plug-in. Then run File->Import->Mercurial->Clone From Existing Mercurial Repository to import the project to your workspace.

### Building the project

#### Building From Shell:

Navigate to Texada/bin/. Four environment variables must be set: 
SPOT_LIB: the location of the spot library
SPOT_INCL: the location of pot header files 
GTEST_LIB: the location of gtest and gtest_main libraries
GTEST_INCL: the location of gtest header files
This can be done via the export command. Then run make in Texada/bin/.

#### Building From Eclipse:

Right-click on the Texada project and click "Properties" Under C/C++ Build, uncheck "Generate Makefiles automatically" and set the build location to bin. Then expand Build and click on Build Variables. There, add the four variables described above. They should all be of type string. 
