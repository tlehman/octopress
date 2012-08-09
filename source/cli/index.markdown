---
layout: page
title: "command line stuff"
date: 2012-08-08 18:14
comments: false
sharing: false
footer: false
---

# A PowerShell to Unix Rosetta Stone
This is written mostly for those with a Unix background that would like
to work in a command-line environment on Windows. The following is a
mapping from UNIX commands to [PowerShell
cmdlets](http://tobilehman.com/blog/2012/08/08/on-windows-powershell).


<table border="1" cellpadding="2" cellspacing="0" width="100%">
	<tr>
	  <td valign="top"><font face="Consolas"><b>UNIX Command</b></font></td>

	  <td valign="top"><font face="Consolas"><b>Windows Powershell cmdlet</b></font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">cat <i>filename</i></font></td>

	  <td valign="top"><font face="Consolas">Get-Content <i>filename</i></font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">diff <i>file1 file2</i></font></td>

	  <td valign="top"><font face="Consolas">Compare-Object $(Get-Content <i>file1</i>) $(Get-Content <i>file2</i>)</font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">grep <i>pattern filename</i></font></td>

	  <td valign="top"><font face="Consolas">Select-String <u><i>pattern&nbsp;</i></u><i>filename&nbsp;</i></font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">man <i>cmd</i></font></td>

	  <td valign="top"><font face="Consolas">Get-Help <i>cmd<br></i></font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">head -<i>n filename</i></font></td>

	  <td valign="top"><font face="Consolas">Get-Content <i>filename</i> | Select-Object -First <i>n</i></font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">tail -<i>n filename</i></font></td>

	  <td valign="top"><font face="Consolas">Get-Content <i>filename</i> | Select-Object -Last <i>n</i></font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">pwd</font></td>

	  <td valign="top"><font face="Consolas">Get-Location</font></td>
	</tr>

	<tr>
	  <td valign="top"><font face="Consolas">curl <i>url</i></font></td>

	  <td valign="top"><font face="Consolas">(New-Object Net.WebClient).DownloadString(<i>url</i>)</font></td>
	</tr>
</table>


