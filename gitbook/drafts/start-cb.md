# CrSFML and Code::Blocks (MinGW)

## Introduction

This tutorial is the first one you should read if you're using CrSFML with the Code::Blocks IDE, and the GCC compiler (this is the default one). It will explain how to configure your CrSFML projects. 

## Installing CrSFML

First, you must download the CrSFML SDK from the [download page](../../download.html "Go to the download page"). 

There are multiple variants of GCC for Windows, which are incompatible with each other (different exception management, threading model, etc.). Make sure you select the package which corresponds to the version that you use. If you are unsure, check which of the libgcc_s_sjlj-1.dll or libgcc_s_dw2-1.dll files is present in your MinGW/bin folder. If MinGW was installed along with Code::Blocks, you probably have an SJLJ version.   
If you feel like your version of GCC can't work with the precompiled CrSFML libraries, don't hesitate to [build CrSFML yourself](compile-with-cmake.md "How to compile CrSFML"), it's not complicated. 

You can then unpack the CrSFML archive wherever you like. Copying headers and libraries to your installation of MinGW is not recommended, it's better to keep libraries in their own separate location, especially if you intend to use several versions of the same library, or several compilers. 

## Creating and configuring a CrSFML project

The first thing to do is choose what kind of project to create. Code::Blocks offers a wide variety of project types, including an "CrSFML project". **Don't use it!** It hasn't been updated in a long time and is likely incompatible with recent versions of CrSFML. Instead, create an Empty project. If you want to get rid of the console, in the project properties, go to the "Build targets" tab and select "GUI application" in the combo box instead of "Console application". 

Now we need to tell the compiler where to find the CrSFML headers (.hpp files), and the linker where to find the CrSFML libraries (.a files). 

In the project's "Build options", "Search directories" tab, add: 

  * The path to the CrSFML headers (*&lt;sfml-install-path&gt;/include*) to the Compiler search directories
  * The path to the CrSFML libraries (*&lt;sfml-install-path&gt;/lib*) to the Linker search directories

These paths are the same in both Debug and Release configuration, so you can set them globally for your project. 

![Screenshot of the dialog box for setting up the search paths](images/start-cb-paths.png)

The next step is to link your application to the CrSFML libraries (.a files) that your code will need. CrSFML is made of 5 modules (system, window, graphics, network and audio), and there's one library for each of them.  
Libraries must be added to the "Link libraries" list in the project's build options, under the "Linker settings" tab. Add all the CrSFML libraries that you need, for example "sfml-graphics", "sfml-window" and "sfml-system" (the "lib" prefix and the ".a" extension must be omitted). 

![Screenshot of the dialog box for setting up the project's libraries](images/start-cb-link-libs.png)

It is important to link to the libraries that match the configuration: "sfml-xxx-d" for Debug, and "sfml-xxx" for Release. A bad mix may result in crashes. 

When linking to multiple CrSFML libraries, make sure that you link them in the right order, it is very important for GCC. The rule is that libraries that depend on other libraries must be put first in the list. Every CrSFML library depends on sfml-system, and sfml-graphics also depends on sfml-window. So, the correct order for these three libraries would be: sfml-graphics, sfml-window, sfml-system -- as shown in the screen capture above. 

The settings shown here will result in your application being linked to the dynamic version of CrSFML, the one that needs the DLL files. If you want to get rid of these DLLs and have CrSFML directly integrated into your executable, you must link to the static version. Static CrSFML libraries have the "-s" suffix: "sfml-xxx-s-d" for Debug, and "sfml-xxx-s" for Release.  
In this case, you'll also need to define the CrSFML_STATIC macro in the preprocessor options of your project. 

![Screenshot of the dialog box for defining the CrSFML_STATIC macro](images/start-cb-static.png)

Starting from CrSFML 2.2, when static linking, you will have to link all of CrSFML's dependencies to your project as well. This means that if you are linking sfml-window-s or sfml-window-s-d for example, you will also have to link opengl32, winmm and gdi32. Some of these dependency libraries might already be listed under "Inherited values", but adding them again yourself shouldn't cause any problems. 

Here are the dependencies of each module, append the -d as described above if you want to link the CrSFML debug libraries:   

<table class="styled expanded">
    <thead>
        <tr>
            <th>Module</th>
            <th>Dependencies</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>sfml-graphics-s</code></td>
            <td><ul>
                <li>sfml-window-s</li>
                <li>sfml-system-s</li>
                <li>opengl32</li>
                <li>freetype</li>
                <li>jpeg</li>
            </ul></td>
        </tr>
        <tr>
            <td><code>sfml-window-s</code></td>
            <td><ul>
                <li>sfml-system-s</li>
                <li>opengl32</li>
                <li>winmm</li>
                <li>gdi32</li>
            </ul></td>
        </tr>
        <tr>
            <td><code>sfml-audio-s</code></td>
            <td><ul>
                <li>sfml-system-s</li>
                <li>openal32</li>
                <li>flac</li>
                <li>vorbisenc</li>
                <li>vorbisfile</li>
                <li>vorbis</li>
                <li>ogg</li>
            </ul></td>
        </tr>
        <tr>
            <td><code>sfml-network-s</code></td>
            <td><ul>
                <li>sfml-system-s</li>
                <li>ws2_32</li>
            </ul></td>
        </tr>
        <tr>
            <td><code>sfml-system-s</code></td>
            <td><ul>
                <li>winmm</li>
            </ul></td>
        </tr>
    </tbody>
</table>

You might have noticed from the table that CrSFML modules can also depend on one another, e.g. sfml-graphics-s depends both on sfml-window-s and sfml-system-s. If you static link to an CrSFML library, make sure to link to the dependencies of the library in question, as well as the dependencies of the dependencies and so on. If anything along the dependency chain is missing, you *will* get linker errors. 

Additionally, because Code::Blocks makes use of GCC, the linking order *does* matter. This means that libraries that depend on other libraries have to be added to the library list *before* the libraries they depend on. If you don't follow this rule, you *will* get linker errors. 

If you are slightly confused, don't worry, it is perfectly normal for beginners to be overwhelmed by all this information regarding static linking. If something doesn't work for you the first time around, you can simply keep trying always bearing in mind what has been said above. If you still can't get static linking to work, you can check the [FAQ](../../faq.php#build-link-static "Go to the FAQ page") and the [forum](http://en.sfml-dev.org/forums/index.php?board=4.0 "Go to the general help forum") for threads about static linking. 

If you don't know the differences between dynamic (also called shared) and static libraries, and don't know which one to use, you can search for more information on the internet. There are many good articles/blogs/posts about them. 

Your project is ready, let's write some code now to make sure that it works. Add a "main.cpp" file to your project, with the following code inside: 

```
#include <CrSFML/Graphics.hpp>

int main()
{
    SF::RenderWindow window(SF::VideoMode(200, 200), "CrSFML works!");
    SF::CircleShape shape(100.f);
    shape.setFillColor(SF::Color::Green);

    while (window.isOpen())
    {
        SF::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == SF::Event::Closed)
                window.close();
        }

        window.clear();
        window.draw(shape);
        window.display();
    }

    return 0;
}
```

Compile it, and if you linked to the dynamic version of CrSFML, don't forget to copy the CrSFML DLLs (they are in *&lt;sfml-install-path/bin&gt;*) to the directory where your compiled executable is. Run it, and if everything works you should see this: 

![Screenshot of the Hello CrSFML application](images/start-cb-app.png)

If you are using the sfml-audio module (regardless whether statically or dynamically), you must also copy the DLL of the external library needed by it, which is OpenAL32.dll.  
These files can be found in *&lt;sfml-install-path/bin&gt;* too. 
