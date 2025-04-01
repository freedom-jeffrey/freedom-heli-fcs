#ifndef FREEDOM_HELI_FMSG_H
#define FREEDOM_HELI_FMSG_H

#include <stdint.h>

typedef union {
    uint8_t raw;
    struct {
        uint8_t payload : 4;
        uint8_t dest    : 2;
        uint8_t type    : 2;
    };
} Fmsg;

#endif // FREEDOM_HELI_FMSG_H
