#include "id3.h"
#include "stdio.h"
 
void to_ascii(unicode_t *in, size_t len, char* out) {
    if (*in == 0xfeff ) {
        in++;
        len-=2;
        while ( len > 0 ) {
            *out = *in & 0xff;
            out++;
            in++;
            len-=2;
        }
    }
    else {
        while ( len > 0 ) {
            *out = *in >> 8; 
            out++;
            in++;
            len-=2;
        }
    }
    *out = '\0';
}

int
main (int *arg, char **argv) {

     ID3Tag *tag = ID3Tag_New();
     ID3Tag_Link(tag, argv[1]);
     ID3TagIterator* iterator = ID3Tag_CreateIterator(tag);

     ID3Frame* frame;
     while ((frame = ID3TagIterator_GetNext(iterator)) != NULL) {

        ID3_FrameID id = ID3Frame_GetID(frame);
        ID3Field* field;
        if ((field = ID3Frame_GetField(frame, ID3FN_TEXT)) != NULL) {

            size_t chrs;
            char text[100];
            unicode_t utext[100];
            /*
             * The functions that would tell us if we had Unicode (actually UCS-2)
             * are not exported to C by libid3. However, if this fails, we assume
             * ASCII's worth a try. This appears to be the same thing as testing
             * for ID3 v2.3, but, again no exported function. We could read the file.
             * See: http://www.id3.org/id3v2.3.0 
             */
            if ( ( chrs = ID3Field_GetUNICODE(field, utext, 100) ) != 0 ) {
                to_ascii(utext, chrs, text);
            }
            else {
                if ( ID3Field_GetASCII(field, text, 100) == 0 ) return;
            }
            printf("%d %s\n", id, text);
       }
    }
}
