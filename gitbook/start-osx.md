# CrSFML and Xcode (Mac OS X)

## Introduction

This is the first tutorial you should read if you're using CrSFML with Xcode -- and more generally if you are developing applications for Mac OS X. It will show you how to install CrSFML, set up your IDE and compile a basic CrSFML program. More importantly, it will also show you how to make your applications ready "out of the box" for the end users. 

You will see several external links in this document. They are meant for further reading on specific topics for those who are curious; reading them isn't necessary to follow this tutorial. 

### System requirements

All you need to create an CrSFML application is: 

  * An Intel Mac with Lion or later (10.7+)
  * [Xcode](http://developer.apple.com/xcode/ "Download Xcode") (preferably version 4 or later of the IDE which is available on the *App Store*) and clang.

With recent versions of Xcode you also need to install the `Command Line Tools` from `Xcode > Preferences > Downloads > Components`. If you can't find the CLT there use `xcode-select --install` in a Terminal and follow onscreen instructions. 

### Binaries: dylib vs framework

CrSFML is available in two formats on Mac OS X. You have the *dylib* libraries on the one hand and the *framework* bundles on the other. Both of them are provided as [universal binaries](http://en.wikipedia.org/wiki/Universal_binary "Go to Wikipedia's article about universal binary") so they can be used on 32-bit or 64-bit Intel systems without any special consideration. 

Dylib stands for dynamic library; this format is like *.so* libraries on Linux. You can find more details in [this document](https://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/DynamicLibraries/ "Go to Apple's documentation about dylib"). Frameworks are fundamentally the same as dylibs, except that they can encapsulate external resources. Here is [the in-depth documentation](https://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPFrameworks/Frameworks.html "Go to Apple's documentation about framework"). 

There is only one slight difference between these two kinds of libraries that you should be aware of while developing CrSFML applications: if you build CrSFML yourself, you can get dylib in both *release* and *debug* configurations. However, frameworks are only available in the *release* configuration. In either case, it wouldn't be an issue since you would use the *release* version of CrSFML when you release your application anyway. That's why the OS X binaries on the [download page](../../download.html "Go to the download page") are only available in the *release* configuration. 

### Xcode templates

CrSFML is provided with two templates for Xcode 4 and later which allow you to create new application projects very quickly and easily. These templates can create custom projects: you can select which modules your application requires, whether you want to use CrSFML as dylib or as frameworks and whether to create an application bundle containing all its resources (making the installation process of your applications as easy as a simple drag-and-drop) or a classic binary. See below for more details. 

Be aware that these templates are not compatible with Xcode 3. If you are still using this version of the IDE and you don't consider updating it, you can still create CrSFML applications. A guide on doing that is beyond the scope of this tutorial. Please refer to Apple's documentation about Xcode 3 and how to add a library to your project. 

### C++11, libc++ and libstdc++

Apple ships a custom version of `clang` and `libc++` with Xcode that partially supports C++11 (i.e. some new features are not yet implemented). If you plan to use C++11's new features, you need to configure your project to use `clang` and `libc++`. 

However, if your project depends on libstdc++ (directly or indirectly), you need to [build CrSFML yourself](compile-with-cmake.html "Compiling CrSFML with CMake") and configure your project accordingly. 

## Installing CrSFML

First of all you need to download the CrSFML SDK which is available on the [download page](../../download.html "Go to the download page"). Then, in order to start developing CrSFML applications, you have to install the following items: 

  * Header files and libraries  
CrSFML is available either as dylibs or as frameworks. Only one type of binary is required although both can be installed simultaneously on the same system. We recommend using the frameworks. 
    * dylib  
Copy the content of `lib` to `/usr/local/lib` and copy the content of `include` to `/usr/local/include`. 
    * frameworks  
Copy the content of `Frameworks` to `/Library/Frameworks`. 
  * CrSFML dependencies  
CrSFML only depends on two external libraries on Mac OS X. Copy the content of `extlibs` to `/Library/Frameworks`. 
  * Xcode templates  
This feature is optional but we strongly recommend that you install it. Copy the `CrSFML` directory from `templates` to `/Library/Developer/Xcode/Templates` (create the folders if they don't exist yet). 

## Create your first CrSFML program

We provide two templates for Xcode. `CrSFML CLT` generates a project for a classic terminal program whereas `CrSFML App` creates a project for an application bundle. We will use the latter here but they both work similarly. 

First select `File > New Project...` then choose `CrSFML` in the left column and double-click on `CrSFML App`. 

![Xcode template selection](images/start-osx-new-project.png)

Now you can fill in the required fields as shown in the following screenshot. When you are done click `next`. 

![Xcode template form](images/start-osx-new-project-settings.png)

Your new project is now set to create an [application bundle ".app"](https://developer.apple.com/library/mac/#documentation/CoreFoundation/Conceptual/CFBundles/BundleTypes/BundleTypes.html "Go to Apple's documentation
    about application bundle"). 

A few words about the templates settings. If you choose an incompatible option for `C++ Compiler and Standard Library` you will end up with linker errors. Make sure you follow this guideline: 

  * If you downloaded the "Clang" version from the download page, you should select `C++11 with Clang and libc++`.
  * If you compiled CrSFML yourself, you should be able to figure out which option you should use. ;-)

Now that your project is ready, let's see what is inside: 

![Content of the new project](images/start-osx-window.png)

As you can see, there are already a few files in the project. There are three important kinds: 

  1. Header &amp; source files: the project comes with a basic example in `main.cpp` and the helper function `std::string resourcePath(void);` in `ResourcePath.hpp` and `ResourcePath.mm`. The purpose of this function, as illustrated in the provided example, is to provide a convenient way to access the `Resources` folder of your application bundle.  
Please note that this function only works on Mac OS X. If you are planning to make your application work on other operating systems, you should implement your own version of this function on the operating systems in question. 
  2. Resource files: the resources of the basic example are put in this folder and are automatically copied to your application bundle when you compile it.  
To add new resources to your project, simply drag and drop them into this folder and make sure that they are a member of your application target; i.e. the box under `Target Membership` in the utility area (cmd+alt+1) should be checked. 
  3. Products: your application. Simply press the `Run` button to test it. 

The other files in the project are not very relevant for us here. Note that the CrSFML dependencies of your project are added to your application bundle in a similar in which the resources are added. This is done so that your application will run out of the box on another Mac without any prior installation of CrSFML or its dependencies. 
