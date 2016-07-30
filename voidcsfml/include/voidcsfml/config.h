// Copyright (C) 2016 Oleh Prypin (oleh@pryp.in)
// Copyright (C) 2007-2015 Laurent Gomila (laurent@sfml-dev.org)
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgement in the product documentation would be
//    appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.


#ifndef VOIDCSFML_CONFIG_H
#define VOIDCSFML_CONFIG_H

#include <stddef.h>
#include <stdint.h>


// Check if we need to mark functions as extern "C"

#ifdef __cplusplus
    #define VOIDCSFML_EXTERN extern "C"
#else
    #define VOIDCSFML_EXTERN extern
#endif


// Helpers to create portable import / export macros for each module

#if defined(_WIN32)
    // Windows compilers need specific (and different) keywords for export and import
    #if defined(VOIDCSFML_EXPORTS)
        #define VOIDCSFML_API extern "C" __declspec(dllexport) void
    #else
        #define VOIDCSFML_API VOIDCSFML_EXTERN __declspec(dllimport) void
    #endif

    // For Visual C++ compilers, we also need to turn off this annoying C4251 warning
    #ifdef _MSC_VER
        #pragma warning(disable : 4251)
    #endif

#else // Linux, FreeBSD, Mac OS X
    #if __GNUC__ >= 4
        // GCC 4 has special keywords for showing/hidding symbols,
        // the same keyword is used for both importing and exporting
        #if defined(VOIDCSFML_EXPORTS)
            #define VOIDCSFML_API extern "C" __attribute__ ((__visibility__ ("default"))) void
        #else
            #define VOIDCSFML_API VOIDCSFML_EXTERN __attribute__ ((__visibility__ ("default"))) void
        #endif

    #else
        // GCC < 4 has no mechanism to explicitly hide symbols, everything's exported
        #if defined(VOIDCSFML_EXPORTS)
            #define VOIDCSFML_API extern "C" void
        #else
            #define VOIDCSFML_API VOIDCSFML_EXTERN void
        #endif

    #endif

#endif


// OS-specific window handle type

#if defined(_WIN32)
    // Window handle is HWND (HWND__*) on Windows
    struct HWND__;
    typedef HWND__* WindowHandle;

#elif defined(__APPLE__)
    // Window handle is NSWindow or NSView (void*) on Mac OS X - Cocoa
    typedef void* WindowHandle;

#elif defined(__unix__)
    // Window handle is Window (unsigned long) on Unix - X11
    typedef unsigned long WindowHandle;

#endif


// OS-specific socket handle type

#if defined(_WIN32)
    typedef unsigned int* SocketHandle;
#else
    typedef int SocketHandle;
#endif


#endif // VOIDCSFML_CONFIG_H
