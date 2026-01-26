![TWRP](https://raw.githubusercontent.com/TeamWin/twrpme/refs/heads/master/favicon.ico "for TWRP")
# Android device tree for KYOCERA KY-41C (KY-41C)

## Contributors
 -	[Yoshinobu Date](https://github.com/yoshi3jp) 

```
#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
``` 
## Decryption library trick
There was an issue where libkeymaster_portable.so had an older nearly yet not quite compatible implementation of EcKeyFactory::CreateEmptyKey, causing libsoftkeymasterdevice.so to fail. As a fix, a compatibility layer of shared library was added as a potentially viable option for recovery-only use case. If you adopt this tree for different kind of project, it may not work or perform well. On the otherhand this trick can potentially work on other device so long as the objective is the same. (TWRP 12.1 for Android 10 MTK-ARMv7-neon-Trustonic device)
