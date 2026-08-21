![TWRP](https://raw.githubusercontent.com/TeamWin/twrpme/refs/heads/master/favicon.ico "for TWRP")
# Android device tree for KYOCERA KY-42C

This branch is the KY-42C TWRP 12.1 re-bring-up tree. It starts from merge commit
`8c3a3eb0cc9c799ddfb88b00c7fd43d58ba11354` and audits KY-41C material before
re-enabling device-specific features.

The KY-42C prebuilt kernel, DTB and DTBO from the original KY-42C tree are kept.
The first objective is a stable, non-destructive recovery with display, ADB,
reboot-to-system, storage discovery and raw keypad input.

The KY-41C merge also brought in a Trustonic/Keymaster decryption stack. KY-42C
uses Trustonic TEE, Keymaster 3.0 and Gatekeeper 1.0, but those imported binaries
and their recovery dependencies are not assumed to be interchangeable. FBE
support remains disabled until the KY-42C stack is validated directly.

The `para` partition is intentionally not exposed as TWRP `/misc` during initial
bring-up. KY-42C boot-mode state can persist there, so recovery must not modify it
until its semantics are understood and a verified restore path exists.
