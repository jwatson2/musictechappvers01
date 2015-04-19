//
//  ViewController.m
//  musictechappvers01
//
//  Created by Jordan Watson on 4/5/15.
//  Copyright (c) 2015 Jordan Watson. All rights reserved.
//

#import "ViewController.h"
#include <arpa/inet.h>
#include <fcntl.h>
#include <ifaddrs.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)slowerPressed:(UIButton *)sender {
    NSLog(@"slower");
    // When slower button is pressed, the message slower is sent to the debug window
    int sock;
    struct sockaddr_in sa;
    ssize_t bytes_sent;
    
    char            OutBuffer[1024];
    ssize_t            OutBufferLength;
    
    strcpy(OutBuffer,"Hello World!");
    OutBufferLength = strlen("Hello World!");
    
    
    sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (-1 == sock) /* if socket failed to initialize, exit */
    {
        fprintf(stderr,"Error creating socket: %s\n",strerror(errno));
        exit(EXIT_FAILURE);
    }
    
    memset(&sa, 0, sizeof(sa));
    sa.sin_family = AF_INET;
    sa.sin_addr.s_addr = htonl(0x7F000001); /* IP address: 127.0.0.1 */
    sa.sin_port = htons(1337);
    
    
    OutBufferLength = 0;
    bytes_sent = sendto(sock, OutBuffer, OutBufferLength, 0,(struct sockaddr*)&sa, sizeof (struct sockaddr_in));
    if (bytes_sent < 0)
        fprintf(stderr,"Error sending packet: %s\n",strerror(errno));
    
    close(sock); /* close the socket */
}

- (IBAction)fasterPressed:(UIButton *)sender {
    NSLog(@"faster");
    // When faster button is pressed, the message faster is sent to the debug window
}
@end
