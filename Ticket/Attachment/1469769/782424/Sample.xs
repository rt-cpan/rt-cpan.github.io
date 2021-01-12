/*
 * sample.xs - This file is in the public domain
 * Author: "Salvador FandiÃ±o <sfandino@yahoo.com>, Dave Rolsky <autarch@urth.org>"
 *
 * Generated on: 2015-02-10 08:20:42
 * Math::Int128 version: 0.20
 */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

/* begin cut/paste from perl_math_int128.xs */

#if __GNUC__ == 4 && __GNUC_MINOR__ >= 4 && __GNUC_MINOR__ < 6

/* workaroung for gcc 4.4/4.5 - see http://gcc.gnu.org/gcc-4.4/changes.html */
typedef int int128_t __attribute__ ((__mode__ (TI)));
typedef unsigned int uint128_t __attribute__ ((__mode__ (TI)));

#else

typedef __int128 int128_t;
typedef unsigned __int128 uint128_t;

#endif

/* perl memory allocator does not guarantee 16-byte alignment */
typedef int128_t int128_t_a8 __attribute__ ((aligned(8)));
typedef uint128_t uint128_t_a8 __attribute__ ((aligned(8)));

/* end cut/paste */

#include "perl_math_int128.h"

uint128_t
test_uint128(pTHX_ SV *rv) {
    return SvU128(rv);
}


MODULE = Sample         PACKAGE = Sample

BOOT:
    PERL_MATH_INT128_LOAD;

