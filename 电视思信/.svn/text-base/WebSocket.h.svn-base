//
//  WebSocket.h
//  电视微信
//
//  Created by 陈 琨 on 13-9-30.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"

@interface WebSocket : NSObject<SRWebSocketDelegate>
{
    SRWebSocket *_webSocket;
    NSMutableData *_data;


}
@property(nonatomic,retain)NSString *strUID;
- (void)_reconnect:(NSString *)str;
@end
