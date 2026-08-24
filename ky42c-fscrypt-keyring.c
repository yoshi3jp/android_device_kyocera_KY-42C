/*
 * KY-42C TWRP old-kernel fscrypt keyring bootstrap.
 *
 * Android 10-era kernels use the legacy session-keyring fscrypt interface.
 * Modern recovery userspace no longer creates the "fscrypt" child keyring
 * which vold expects to already exist.
 *
 * IMPORTANT: Do not join/create a new session keyring here.  We must modify
 * the session keyring inherited from init so that later recovery processes
 * see the same child keyring.
 */

#include <errno.h>
#include <linux/keyctl.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/syscall.h>
#include <unistd.h>

#ifndef SYS_keyctl
#define SYS_keyctl __NR_keyctl
#endif

#ifndef SYS_add_key
#define SYS_add_key __NR_add_key
#endif

typedef int32_t key_serial_t;

static long search_fscrypt_keyring(void)
{
    return syscall(SYS_keyctl,
                   KEYCTL_SEARCH,
                   (long)KEY_SPEC_SESSION_KEYRING,
                   (long)"keyring",
                   (long)"fscrypt",
                   0L);
}

static long create_fscrypt_keyring(void)
{
    return syscall(SYS_add_key,
                   "keyring",
                   "fscrypt",
                   NULL,
                   0,
                   (long)KEY_SPEC_SESSION_KEYRING);
}

int main(void)
{
    long id = search_fscrypt_keyring();

    if (id >= 0) {
        fprintf(stderr,
                "ky42c-fscrypt-keyring: existing fscrypt keyring id=%ld\n",
                id);
        return 0;
    }

    if (errno != ENOKEY) {
        fprintf(stderr,
                "ky42c-fscrypt-keyring: search failed: %s (%d)\n",
                strerror(errno), errno);
        return 1;
    }

    id = create_fscrypt_keyring();
    if (id < 0) {
        fprintf(stderr,
                "ky42c-fscrypt-keyring: create failed: %s (%d)\n",
                strerror(errno), errno);
        return 1;
    }

    fprintf(stderr,
            "ky42c-fscrypt-keyring: created fscrypt keyring id=%ld\n",
            id);
    return 0;
}
