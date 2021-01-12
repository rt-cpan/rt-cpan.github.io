#include <stdio.h>
#include <dirent.h>
#include <errno.h>
#include <vector>
#include <algorithm>
#include <bitset>
#include <pHash.h>

using namespace std;

#define TRUE 1
#define FALSE 0

//data structure for a hash and id
struct ph_imagepoint{
    ulong64 hash;
    char *id;
};

//aux function to create imagepoint data struct
struct ph_imagepoint* ph_malloc_imagepoint(){
    return (struct ph_imagepoint*)malloc(sizeof(struct ph_imagepoint));
}

//auxiliary function for sorting list of hashes 
bool cmp_lt_imp(struct ph_imagepoint dpa, struct ph_imagepoint dpb){
    int result = strcmp(dpa.id, dpb.id);
    if (result < 0)
	      return TRUE;
    return FALSE;
}

/*
 * This is a modified version of the examples/test_imagephash.cpp program shipped with 
 * v0.9.6 of pHash.  The purpose of this program is to provide output that can be 
 * matched with my perl test program define the problem with the ph_hamming_distance
 * function when accessed via FFI::Phash.  The specific problem is that the pHash
 * function returns a 4 byte int, but Phash::FFI, built upon FFI::Platypus, appears to 
 * ony return a distance based upon the 2 low order bytes on my Mac (which is little 
 * endian)
 */

int main(int argc, char **argv){

    if (argc < 2){
			  printf("no input args\n");
			  printf("expected: \"test_imagephash [dir_name]\"\n");
			  exit(1);
    }
    const char *dir_name = argv[1];
    struct dirent *dir_entry;
    vector<ph_imagepoint> hashlist1; 
    ph_imagepoint *dp = NULL;

    //read directory, process files therein, calculate hash & store
    DIR *dir = opendir(dir_name);
    if (!dir){
	      printf("unable to open directory\n");
	      exit(1);
    }
    errno = 0;
    int i = 0;

    ulong64 tmphash; 
    char path[100];
    path[0] = '\0';
    while ((dir_entry = readdir(dir)) != 0){
	      if (strcmp(dir_entry->d_name,".") && strcmp(dir_entry->d_name,"..")){
	          strcat(path, dir_name);
	          strcat(path, "/");
	          strcat(path, dir_entry->d_name);
	          if (ph_dct_imagehash(path, tmphash) < 0)  //calculate the hash
		            continue;
            dp = ph_malloc_imagepoint();              //store in structure with file name
	          dp->id = dir_entry->d_name;
	          dp->hash = tmphash;
	          hashlist1.push_back(*dp);
	          i++;
	      }
	      errno = 0;
        path[0]='\0';
    }

    if (errno){
	      printf("error reading directory\n");
	      exit(1);
    }

    sort(hashlist1.begin(),hashlist1.end(),cmp_lt_imp);

    int nbfiles1 = hashlist1.size();
    for (i=0;i<nbfiles1;i++){
	      for (int j=i+1;j<nbfiles1;j++){

            //calculate & print distance
						int distance = -1;
	          distance = ph_hamming_distance(hashlist1[i].hash,hashlist1[j].hash);
            printf("Distance = %2d <- from pHash\n", distance);

	          char tmpStr[64];
            tmpStr[0] = '\0';
						for (int k=1;k<=8;k++){
							  strcat(tmpStr, "[      ]");
						}
						printf("%s  %-16s %s\n", tmpStr, "Hash in Hex", "File Name");

						std::bitset<sizeof(hashlist1[i].hash)*8> hash1b (hashlist1[i].hash);
            printf("%s  %016llx %s\n",hash1b.to_string().c_str(),
								                      hashlist1[i].hash,
															  			hashlist1[i].id);

					  std::bitset<sizeof(hashlist1[j].hash)*8> hash2b (hashlist1[j].hash);
            printf("%s  %016llx %s\n",hash2b.to_string().c_str(),
								                      hashlist1[j].hash,
																  		hashlist1[j].id);

						// calculate and print where differences exist between the to hashes
						char diffs [64];
						diffs[0]='\0';
						distance = 0;
            for (int l=63;l>=0;l--) {
							  if ( hash1b[l] ^ hash2b[l] ) {
								    strcat( diffs, "^" );
										distance++;
								}
								else {
									  strcat( diffs, " " );
								}
						}
						printf("%s\n", diffs);
	      }
    }
    return 0;
}
