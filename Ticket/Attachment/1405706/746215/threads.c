#include <assert.h>
#include <nanomsg/nn.h>
#include <nanomsg/pair.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

struct argument_block {
  int socket;
  void *message;
};


void *threadFunc(void *args)
{
  struct argument_block *foo = args;
  int ts = foo -> socket;
  void *message = foo -> message;
  int ret = nn_recv(ts, &message, NN_MSG, 0);
  assert (ret == 3);
  return message;
}

int main()
{
  // Setup receive sockets for the threads
  int ts = nn_socket(AF_SP, NN_PAIR);
  assert (ts >= 0);
  
  int bind = nn_bind(ts, "inproc://a");
  assert (bind >= 0);

  pthread_t pth1;
  pthread_t pth2;

  struct argument_block argu;
  struct argument_block argu2;
  argu.socket = ts;
  argu2.socket = ts;
  argu.message = NULL;
  argu2.message = NULL;
  pthread_create(&pth1,NULL,threadFunc,(void *)&argu);
  pthread_create(&pth2,NULL,threadFunc,(void *)&argu2);

  // Setup sender
  int s = nn_socket(AF_SP, NN_PAIR);
  assert (s >= 0);
  
  int eid = nn_connect(s, "inproc://a");
  assert (eid >= 0);
  
  void *foo = "foo";
  
  int ret1 = nn_send(s, foo, 3, 0);
  int ret2 = nn_send(s, foo, 3, 0);
  
  assert (ret1 == 3);
  assert (ret2 == 3);
  
  int pthjoin1 = pthread_join(pth1, &argu.message);
  assert (pthjoin1 == 0);
  
  int pthjoin2 = pthread_join(pth2, &argu2.message);
  assert (pthjoin2 == 0);
  
  printf("One: %s\nTwo: %s\n", (char*)argu.message, (char*)argu2.message);
  
  return 0;
}
