---
layout: post
title: "Avoiding a catch-22"
date: 2012-08-18 16:50
comments: true
categories: [windows, powershell, cli, dotnet]
---

I recently needed to find out if I had a particular version of the .NET
Framework installed. I googled around and found the registry key that
has this information.

Then, like a moron, I decided to write a C# program that would return
this information, and I wrapped it in a cmdlet so I could run it from
the powershell. I made my first powershell cmdlet,
[get-dotnet-versions](https://github.com/tlehman/get-dotnet-versions).
 All it does is fetch the subkeys of *HKLM\SOFTWARE\Microsoft\NET
Framework Setup\NDP*.

So, in order to find which versions of .NET I had installed, I compiled
the C# source code, and this process used .NET libraries. So, which
version of .NET do I target the assembly? Well, let's see which versions
I have installed? Catch-22.

To avoid this, I googled around some more and found the ~~crusty~~ trusty old reg.exe, I
can query the windows registry with the simple command:

``` bat
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP"
```

The benefit of this is that I avoid that catch-22. Sometimes all that
infrastructure gets in the way.
