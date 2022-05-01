# Lolipop: Offline
This program uses a lot of code from Wrapper: Offline to build, Mostly because me  
(RedBoi/SilverStudios#0001) could not figure out some very complicated things, for example: getting a localhost link. But there are some cool features and a more costomizable space to make your videos!
it is kinda using to much data but it was the best i can do.



## Running / Installation
To start Offline on Windows, open start_lolipop.bat. It'll automate just about everything for you and, well, start Lolipop: Offline. On your first run, you will likely need to right-click it and click "Run as Administrator". This allows it to properly install what it needs to run. After your initial run, you shouldn't need to do that again, you can start it as normal.

If you want to import videos and characters from the original Wrapper or any other clones of it, open its folder and drag the "_SAVED" folder into Offline's "lolipop" folder. If you have already made any videos or characters, this will not work. Please only import on a new install with no saved characters or videos, or take the "_SAVED" folder in Offline out before dragging the old one in. If you want to import character IDs from the original LVM, you can paste `&original_asset_id=[ID HERE]` at the end of the link for the matching character creator.

## Updates & Support
For support, the first thing you should do is read through faq.txt, it most likely has what you want to know. If you can't find what you need, you can join the [Discord server](https://discord.gg/M6eq8jcsRX). Joining the server is recommended, as there is a whole community to help you out. If you don't use Discord, you can email SendMailRedBoi@protonmail.com to get in contact with me directly, but don't expect nearly as quick of a response.

## Dependencies
This program relies on Flash, Node.js and http-server to work properly. SilentCMD is also used to suppress all the extra logging noise you'd only need for troubleshooting and development. These all have been included with the project (utilities folder) to ensure full offline operation and will be installed if missing. The "lolipop" folder and http-server have their own dependencies, but they are included as well.

## License
Most of this project is free/libre software[1] under the MIT license. You have the freedom to run, change, and share this as much as you want.
This includes:
  - Files in the "lolipop" folder
  - Batch files made for Lolipop: Offline
  - Node.js
  - http-server
  - SilentCMD
  - Chromium Web Store

ungoogled-chromium is under the BSD 3-Clause license, which grants similar rights, but has some differences from MIT. MediaInfo has a similar BSD 2-Clause license. 7zip's license is mostly LGPL, but some parts are under the BSD 3-clause License, and some parts have an unRAR restriction. Stylus is under the GNU GPLv3 license. These licenses can be found in each program's folder in utilities\sourcecode.

The source code for compiled programs are all stored in utilities\sourcecode, and you can modify these as you wish. Parts of Offline that run from their source code directly (such as batch scripts) are not included in that folder, for obvious reasons.

Flash Player (utilities folder) and GoAnimate's original assets (server folder) are proprietary and do not grant you these rights, but if they did, this project wouldn't need to exist. Requestly, an addon included in Offline's browser, is sadly proprietary software, but you're free to remove the Chromium profile and use a fresh one if this bothers you. Requestly is primarily included because of how popular it is with our community.

While completely unnecessary, if you decide to use your freedom to change the software, it would be greatly appreciated if you sent it to me so I can implement it into the main program! With credit down here of course :)

## Credits
**Please do not contact anyone on the list for support, use the Discord server.**

Original Wrapper credits:
| Name             | Contribution         |
| ---------------- | -------------------- |
| VisualPlugin (C) | GoAnimate Wrapper    |
| xomdjl_ (D)      | Custom/Modded Assets |
| CLarramore (D)   | Bug fixes            |
| Poley Magik      | Asset Recreation     |

Some members of the original team have asked to not be given credit, and they have been removed.

Developers will have (D) on their name, to show they are officially working on Lollipop: Offline. Beta testers will have (B) on their name to show that they are beta testers for Lollipop: Offline. Contributors will have (C) on their name to show that they are making contributions to Lollipop: Offline by sharing some of their files with us. Everyone else has simply contributed something at some point.
Lollipop: Offline credits:

| Name               | Contribution                                                                                                                      |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------  |
| FlowLoop (D)         | Lollipop: Offline Project Lead
                                                                                                                |
| jaime. (D)         |Co-Project Lead Bug Fixer                                                                                                                         |
| Abylm8or 2 (D) (B) | Beta Tester and mini dev                                                                                                          |
| BlueMystery (D)    |  Possible fixes to TTS voices, Importing more things to the comedy world theme, Possibly actually the importer itself, Bug fixes. |
|RubyWrapperCartoon(D)| Developer                                                                                                                        |
| MacoiAnimate (D)   | Developer                                                                                                                         |





These are unaffiliated people that they haven't directly done anything for the project (and probably don't even know it exists) but still deserve credit for their things. Kinda like a shoutout but in a project's readme. ***Please do not contact them about Lollipop: Offline.***

| Name               | Contribution                     |
| ------------------ | -------------------------------- |
| Vyond              | Creators of the themes we love   |
| http-party         | Creators of http-server          |
| Stephan Brenner    | Creator of SilentCMD             |
| vocatus            | Some of TronScript's batch code  |
| ss64.com           | Incredible CMD info resource     |
| robvanderwoude.com | Also amazing CMD info resource   |
| darktohka          | Creator of FlashPatch            |

## Footnotes
[1] - See <https://www.gnu.org/philosophy/free-sw.html> for a better definition of free software.
