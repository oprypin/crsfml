# Compiling SFML with CMake

## Introduction

Admittedly, the title of this tutorial is a bit misleading. You will not *compile* SFML with CMake, because CMake is *not a compiler*. So... what is CMake? 

CMake is an open-source meta build system. Instead of building SFML, it builds what builds SFML: Visual Studio solutions, Code::Blocks projects, Linux makefiles, XCode projects, etc. In fact it can generate the makefiles or projects for any operating system and compiler of your choice. It is similar to autoconf/automake or premake for those who are already familiar with these tools. 

CMake is used by many projects including well-known ones such as Blender, Boost, KDE, and Ogre. You can read more about CMake on its [official website](http://www.cmake.org/ "CMake official website") or in its [Wikipedia article](http://en.wikipedia.org/wiki/CMake "Wikipedia page of CMake"). 

As you might expect, this tutorial is divided into two main sections: Generating the build configuration with CMake, and building SFML with your toolchain using that build configuration. 

## Installing dependencies

SFML depends on a few other libraries, so before starting to configure you must have their development files installed. 

On Windows and Mac OS X, all the required dependencies are provided alongside SFML so you won't have to download/install anything else. Building will work out of the box. 

On Linux however, nothing is provided. SFML relies on you to install all of its dependencies on your own. Here is a list of what you need to install before building SFML: 

  * freetype
  * jpeg
  * x11
  * xrandr
  * xcb
  * x11-xcb
  * xcb-randr
  * xcb-image
  * opengl
  * flac
  * ogg
  * vorbis
  * vorbisenc
  * vorbisfile
  * openal
  * pthread

The exact name of the packages may vary from distribution to distribution. Once those packages are installed, don't forget to install their *development headers* as well. 

## Configuring your SFML build

This step consists of creating the projects/makefiles that will finally compile SFML. Basically it consists of choosing *what* to build, *how* to build it and *where* to build it. There are several other options as well which allow you to create a build configuration that suits your needs. We'll see that in detail later. 

The first thing to choose is where the projects/makefiles and object files (files resulting from the compilation process) will be created. You can generate them directly in the source tree (i.e. the SFML root directory), but it will then be polluted with a lot of garbage: a complete hierarchy of build files, object files, etc. The cleanest solution is to generate them in a completely separate folder so that you can keep your SFML directory clean. Using separate folders will also make it easier to have multiple different builds (static, dynamic, debug, release, ...). 

Now that you've chosen the build directory, there's one more thing to do before you can run CMake. When CMake configures your project, it tests the availability of the compiler (and checks its version as well). As a consequence, the compiler executable must be available when CMake is run. This is not a problem for Linux and Mac OS X users, since the compilers are installed in a standard path and are always globally available, but on Windows you may have to add the directory of your compiler in the PATH environment variable, so that CMake can find it automatically. This is especially important when you have several compilers installed, or multiple versions of the same compiler. 

On Windows, if you want to use GCC (MinGW), you can temporarily add the MinGW\bin directory to the PATH and then run CMake from the command shell: 

```
> set PATH=%PATH%;your_mingw_folder\bin
> cmake -G"MinGW Makefiles" ./build
```

With Visual C++, you can either run CMake from the "Visual Studio command prompt" available from the start menu, or run the vcvars32.bat batch file of your Visual Studio installation in the console you have open. The batch file will set all the necessary environment variables in that console window for you. 

```
> your_visual_studio_folder\VC\bin\vcvars32.bat
> cmake -G"NMake Makefiles" ./build
```

Now you are ready to run CMake. In fact there are three different ways to run it: 

  * **cmake-gui**  
This is CMake's graphical interface which allows you to configure everything with buttons and text fields. It's very convenient to see and edit the build options and is probably the easiest solution for beginners and people who don't want to deal with the command line. 
  * **cmake -i**  
This is CMake's interactive command line wizard which guides you through filling build options one at a time. It is a good option if you want to start by using the command line since you are probably not able to remember all the different options that are available and which of them are important. 
  * **cmake**  
This is the direct call to CMake. If you use this, you must specify all the option names and their values as command line parameters. To print out a list of all options, run cmake -L. 

In this tutorial we will be using cmake-gui, as this is what most beginners are likely to use. We assume that people who use the command line variants can refer to the CMake documentation for their usage. With the exception of the screenshots and the instructions to click buttons, everything that is explained below will apply to the command line variants as well (the options are the same). 

Here is what the CMake GUI looks like: 

![Screenshot of the cmake-gui tool](./images/cmake-gui-start.png)

The first steps that need to be done are as follows (perform them in order): 

  1. Tell CMake where the source code of SFML is (this must be the root folder of the SFML folder hierarchy, basically where the top level CMakeLists.txt file is).
  2. Choose where you want the projects/makefiles to be generated (if the directory doesn't exist, CMake will create it).
  3. Click the "Configure" button.

If this is the first time CMake is run in this directory (or if you cleared the cache), the CMake GUI will prompt you to select a generator. In other words, this is where you select your compiler/IDE. 

![Screenshot of the generator selection dialog box](./images/cmake-choose-generator.png)

For example, if you are using Visual Studio 2010, you should select "Visual Studio 10 2010" from the drop-down list. To generate makefiles usable with NMake on the Visual Studio command line, select "NMake Makefiles". To create makefiles usable with MinGW (GCC), select "MinGW Makefiles". It is generally easier to build SFML using makefiles rather than IDE projects: you can build the entire library with a single command, or even batch together multiple builds in a single script. Since you only plan to build SFML and not edit its source files, IDE projects aren't as useful.  
More importantly, the installation process (described further down) may not work with the "Xcode" generator. It is therefore highly recommended to use the "Makefile" generator when building on Mac OS X. 

Always keep the "Use default native compilers" option enabled. The other three fields can be left alone. 

After selecting the generator, CMake will run a series of tests to gather information about your toolchain environment: compiler path, standard headers, SFML dependencies, etc. If the tests succeed, it should finish with the "Configuring done" message. If something goes wrong, read the error(s) printed to the output log carefully. It might be the case that your compiler is not accessible (see above) or configured properly, or that one of SFML's external dependencies is missing. 

![Screenshot of the cmake-gui window after configure](./images/cmake-configure.png)

After configuring is done, the build options appear in the center of the window. CMake itself has many options, but most of them are already set to the right value by default. Some of them are cache variables and better left unchanged, they simply provide feedback about what CMake automatically found.  
Here are the few options that you may want to have a look at when configuring your SFML build:   

<table>
    <thead>
        <tr>
            <th>Variable</th>
            <th>Meaning</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>CMAKE_BUILD_TYPE</code></td>
            <td>
                This option selects the build configuration type. Valid values are "Debug" and "Release" (there are other types such as "RelWithDebInfo" or "MinSizeRel",
                but they are meant for more advanced builds). Note that if you generate a workspace for an IDE that supports multiple configurations,
                such as Visual Studio, this option is ignored since the workspace can contain multiple configurations simultaneously.
            </td>
        </tr>
        <tr>
            <td><code>CMAKE_INSTALL_PREFIX</code></td>
            <td>
                This is the install path. By default, it is set to the installation path that is most typical on the operating system ("/usr/local" for Linux and Mac OS X,
                "C:\Program Files" for Windows, etc.). Installing SFML after building it is not mandatory since you can use the binaries directly from where
                they were built. It may be a better solution, however, to install them properly so you can remove all the temporary files produced during
                the build process.
            </td>
        </tr>
        <tr>
            <td><code>CMAKE_INSTALL_FRAMEWORK_PREFIX<br/>(Mac OS X only)</code></td>
            <td>
                This is the install path for frameworks. By default, it is set to the root library folder
                i.e. /Library/Frameworks. As stated explained above for CMAKE_INSTALL_PREFIX, it is not mandatory to install SFML
                after building it, but it is definitely cleaner to do so.<br>
                This path is also used to install the sndfile framework on your system (a required dependency not provided by Apple)
                and SFML as frameworks if BUILD_FRAMEWORKS is selected.
            </td>
        </tr>
        <tr>
            <td><code>BUILD_SHARED_LIBS</code></td>
            <td>
                This boolean option controls whether you build SFML as dynamic (shared) libraries, or as static ones. <br/>
                This option should not be enabled simultaneously with SFML_USE_STATIC_STD_LIBS, they are mutually exclusive.
            </td>
        </tr>
        <tr>
            <td><code>SFML_BUILD_FRAMEWORKS<br/>(Mac OS X only)</code></td>
            <td>
                This boolean option controls whether you build SFML as
                <a title="go to Apple documentation about frameworks" href="http://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPFrameworks/Frameworks.html">framework bundles</a>
                or as
                <a title="go to Apple documentation about dynamic library" href="http://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/DynamicLibraries/000-Introduction/Introduction.html">dylib binaries</a>.
                Building frameworks requires BUILD_SHARED_LIBS to be selected.<br>
                It is recommended to use SFML as frameworks when publishing your applications. Note however,
                that SFML cannot be built in the debug configuration as frameworks. In that case, use dylibs instead. 
            </td>
        </tr>
        <tr>
            <td><code>SFML_BUILD_EXAMPLES</code></td>
            <td>
                This boolean option controls whether the SFML examples are built alongside the library or not.
            </td>
        </tr>
        <tr>
            <td><code>SFML_BUILD_DOC</code></td>
            <td>
                This boolean option controls whether you generate the SFML documentation or not. Note that the
                <a title="go to doxygen website" href="http://www.doxygen.org">Doxygen</a> tool must be installed and accessible, otherwise
                enabling this option will produce an error.<br>
                On Mac OS X you can either install the classic-Unix doxygen binary into /usr/bin or any similar directory,
                or install Doxygen.app into any "Applications" folder, e.g. ~/Applications.
            </td>
        </tr>
        <tr>
            <td><code>SFML_USE_STATIC_STD_LIBS<br/>(Windows only)</code></td>
            <td>
                This boolean option selects the type of the C/C++ runtime library which is linked to SFML. <br/>
                TRUE statically links the standard libraries, which means that SFML is self-contained and doesn't depend on the compiler's
                specific DLLs. <br/>
                FALSE (the default) dynamically links the standard libraries, which means that SFML depends on the compiler's DLLs
                (msvcrxx.dll/msvcpxx.dll for Visual C++, libgcc_s_xxx-1.dll/libstdc++-6.dll for GCC). Be careful when setting this. The setting must match your own project's
                setting or else your application may fail to run. <br/>
                This option should not be enabled simultaneously with BUILD_SHARED_LIBS, they are mutually exclusive.
            </td>
        </tr>
        <tr>
            <td><code>CMAKE_OSX_ARCHITECTURES<br/>(Mac OS X only)</code></td>
            <td>
                This setting specifies for which architectures SFML should be built. The recommended value is "i386;x86_64" to generate universal binaries for both
                32 and 64-bit systems.
            </td>
        </tr>
        <tr>
            <td><code>SFML_INSTALL_XCODE_TEMPLATES<br/>(Mac OS X only)</code></td>
            <td>
                This boolean option controls whether CMake will install the Xcode templates on your system or not.
                Please make sure that /Library/Developer/Xcode/Templates/SFML exists and is writable.
                More information about these templates is given in the "Getting started" tutorial for Mac OS X.
            </td>
        </tr>
        <tr>
            <td><code>SFML_INSTALL_PKGCONFIG_FILES<br/>(Linux shared libraries only)</code></td>
            <td>
                This boolean option controls whether CMake will install the pkg-config files on your system or not.
                pkg-config is a tool that provides a unified interface for querying installed libraries.
            </td>
        </tr>
    </tbody>
</table>

After everything is configured, click the "Configure" button once again. There should no longer be any options highlighted in red, and the "Generate" button should be enabled. Click it to finally generate the chosen makefiles/projects. 

![Screenshot of the cmake-gui window after generate](./images/cmake-generate.png)

CMake creates a variable cache for every project. Therefore, if you decide to reconfigure something at a later time, you'll find that your settings have been saved from the previous configuration. Make the necessary changes, reconfigure and generate the updated makefiles/projects. 

### C++11 and Mac OS X

If you want to use C++11 features in your application on Mac OS X, you have to use clang (Apple's official compiler) and libc++. Moreover, you will need to build SFML with these tools to work around any incompatibility between the standard libraries and compilers. 

Here are the settings to use to build SFML with clang and libc++: 

  * Choose "Specify native compilers" rather than "Use default native compilers" when you select the generator.
  * Set `CMAKE_CXX_COMPILER` to /usr/bin/clang++ (see screenshot).
  * Set `CMAKE_C_COMPILER` to /usr/bin/clang (see screenshot).
  * Set `CMAKE_CXX_FLAGS` and `CMAKE_C_FLAGS` to "-stdlib=libc++".
![Screenshot of the compiler configuration on OS X](./images/cmake-osx-compilers.png)

## Building SFML

Let's begin this section with some good news: you won't have to go through the configuration step any more, even if you update your working copy of SFML. CMake is smart: It adds a custom step to the generated makefiles/projects, that automatically regenerates the build files whenever something changes. 

You're now ready to build SFML. Of course, how to do it depends on what makefiles/projects you've generated. If you created a project/solution/workspace, open it with your IDE and build SFML like you would any other project. We won't go into the details here, there are simply too many different IDEs and we have to assume that you know how to use yours well enough to perform this simple task on your own. 

If you generated a makefile, open a command shell and execute the make command corresponding to your environment. For example, run "nmake" if you generated an NMake (Visual Studio) makefile, "mingw32-make" if you generated a MinGW (GCC) makefile, or simply "make" if you generated a Linux makefile.  
Note: On Windows, the make program (nmake or mingw32-make) may not be accessible. If this is the case, don't forget to add its location to your PATH environment variable. See the explanations at the beginning of the "Configuring your SFML build" section for more details. 

By default, building the project will build everything (all the SFML libraries, as well as all the examples if you enabled the SFML_BUILD_EXAMPLES option). If you just want to build a specific SFML library or example, you can select a different target. You can also choose to clean or install the built files, with the corresponding targets.  
Here are all the targets that are available, depending on the configure options that you chose:   

<table>
    <thead>
        <tr>
            <th>Target</th>
            <th>Meaning</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>all</code></td>
            <td>
                This is the default target, it is used if no target is explicitly specified. It builds all the targets that produce a binary
                (SFML libraries and examples).
            </td>
        </tr>
        <tr>
            <td><code>sfml&#8209;system<br/>sfml&#8209;window<br/>sfml&#8209;network<br/>sfml&#8209;graphics<br/>sfml&#8209;audio<br/>sfml&#8209;main</code></td>
            <td>
                Builds the corresponding SFML library. The "sfml-main" target is available only when building for Windows.
            </td>
        </tr>
        <tr>
            <td><code>cocoa<br/>ftp<br/>opengl<br/>pong<br/>shader<br/>sockets<br/>sound<br/>sound&#8209;capture<br/>voip<br/>window<br/>win32<br/>X11</code></td>
            <td>
                Builds the corresponding SFML example. These targets are available only if the <code>SFML_BUILD_EXAMPLES</code> option is enabled. Note that some of the
                targets are available only on certain operating systems ("cocoa" is available on Mac OS X, "win32" on Windows, "X11" on Linux, etc.).
            </td>
        </tr>
        <tr>
            <td><code>doc</code></td>
            <td>
                Generates the API documentation. This target is available only if <code>SFML_BUILD_DOC</code> is enabled.
            </td>
        </tr>
        <tr>
            <td><code>clean</code></td>
            <td>
                Removes all the object files, libraries and example binaries produced by a previous build. You generally don't need to invoke this target, the exception being when you want
                to completely rebuild SFML (some source updates may be incompatible with existing object files and cleaning everything is the only solution).
            </td>
        </tr>
        <tr>
            <td><code>install</code></td>
            <td>
                Installs SFML to the path given by <code>CMAKE_INSTALL_PREFIX</code> and <code>CMAKE_INSTALL_FRAMEWORK_PREFIX</code>. It copies over the
                SFML libraries and headers, as well as examples and documentation if <code>SFML_BUILD_EXAMPLES</code> and <code>SFML_BUILD_DOC</code> are enabled.
                After installing, you get a clean distribution of SFML, just as if you had downloaded the SDK or installed it from your distribution's package repository.
            </td>
        </tr>
    </tbody>
</table>

If you use an IDE, a target is simply a project. To build a target, select the corresponding project and compile it (even "clean" and "install" must be built to be executed -- don't be confused by the fact that no source code is actually compiled).  
If you use a makefile, pass the name of the target to the make command to build the target. Examples: "`nmake doc`", "`mingw32-make install`", "`make sfml-network`". 

At this point you should have successfully built SFML. Congratulations! 
