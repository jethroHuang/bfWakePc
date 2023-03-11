#include <stdio.h>
#include <memory.h>
#include "MQTTLinux.h"
#include "MQTTClient.h"

#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

#include <sys/time.h>

volatile int toStop = 0;

void cfinish(int sig)
{
    signal(SIGINT, NULL);
    toStop = 1;
}

struct opts_struct
{
    char *clientid;
    int nodelimiter;
    char *delimiter;
    enum QoS qos;
    char *username;
    char *password;
    char *host;
    int port;
    int showtopics;
} opts =
    {
        (char *)"client id", 0, (char *)"\n", QOS1, NULL, NULL, (char *)"bemfa.com", 9501, 0};

void usage()
{
    printf("bfWakePc <巴法云私钥> <Topic Name> \n");
    exit(-1);
}

void messageArrived(MessageData *md)
{
    MQTTMessage *message = md->message;
    char *text = (char *)malloc(message->payloadlen);
    strncpy(text, (char *)message->payload, message->payloadlen);
    if (strcmp(text, "on") == 0)
    {
        printf("open the pc \n");
        system("ls -l > test.txt");
    }
    // printf("message: %s\n", text);
    free(text);
}

int main(int argc, char **argv)
{
    int rc = 0;
    unsigned char buf[100];
    unsigned char readbuf[100];

    if (argc < 3)
        usage();

    opts.clientid = argv[1];
    char *topic = argv[2];

    Network n;
    MQTTClient c;

    signal(SIGINT, cfinish);
    signal(SIGTERM, cfinish);

    NetworkInit(&n);
    NetworkConnect(&n, opts.host, opts.port);
    MQTTClientInit(&c, &n, 1000, buf, 100, readbuf, 100);

    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.willFlag = 0;
    data.MQTTVersion = 4;
    data.clientID.cstring = opts.clientid;
    data.username.cstring = opts.username;
    data.password.cstring = opts.password;

    data.keepAliveInterval = 10;
    data.cleansession = 1;
    printf("Connecting to %s %d\n", opts.host, opts.port);

    rc = MQTTConnect(&c, &data);
    printf("Connected %d\n", rc);

    printf("Subscribing to %s\n", topic);
    rc = MQTTSubscribe(&c, topic, opts.qos, messageArrived);
    printf("Subscribed %d\n", rc);

    while (!toStop)
    {
        MQTTYield(&c, 1000);
    }

    printf("Stopping\n");

    MQTTDisconnect(&c);
    NetworkDisconnect(&n);

    return 0;
}
