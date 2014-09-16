//
//  SUserDB.m
//  SDatabase
//
//  Created by SunJiangting on 12-10-20.
//  Copyright (c) 2012年 sun. All rights reserved.
//

#import "SUserDB.h"
#import "FMResultSet.h"
#define kUserTableName @"SUser"
#define kMessageTableName @"Message"

@implementation SUserDB

- (id) init {
    self = [super init];
    if (self) {
        //========== 首先查看有没有建立message的数据库，如果未建立，则建立数据库=========
        _db = [SDBManager defaultDBManager].dataBase;
        
    }
    return self;
}

/**
 * @brief 创建数据库
 */
- (void) createDataBase {
    NSLog(@"sssssssssss");
    FMResultSet * set = [_db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",kUserTableName]];
    
    [set next];
    
    NSInteger count = [set intForColumnIndex:0];
    
    BOOL existTable = !!count;
    
    if (existTable) {
        // TODO:是否更新数据库
//        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
    } else {
        // TODO: 插入新的数据库
        NSString * sql = @"CREATE TABLE SUser (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,UserId VARCHAR(500),f_UserId VARCHAR(500),Type VARCHAR(500), Message VARCHAR(500),Pic VARCHAR(500),mixPic VARCHAR(500),Midea VARCHAR(500),Time1 VARCHAR(500),TypeUser VARCHAR(500), description VARCHAR(100))";
        BOOL res = [_db executeUpdate:sql];
        if (!res) {
//            [AppDelegate showStatusWithText:@"数据库创建失败" duration:2];
        } else {
//            [AppDelegate showStatusWithText:@"数据库创建成功" duration:2];
        }
    }
}
- (void) createDataBase1 {
    NSLog(@"ssssssdddddd");

    FMResultSet * set = [_db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",kMessageTableName]];
    
    [set next];
    
    NSInteger count = [set intForColumnIndex:0];
    
    BOOL existTable = !!count;
    
    if (existTable) {
        // TODO:是否更新数据库
        //        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
    } else {
        // TODO: 插入新的数据库
        NSString * sql = @"CREATE TABLE Message (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,UserId VARCHAR(500),f_UserId VARCHAR(500), Message VARCHAR(500),Time1 VARCHAR(500),TypeUser VARCHAR(500),TypeSize VARCHAR(500), description VARCHAR(100))";
        BOOL res = [_db executeUpdate:sql];
        if (!res) {
            //            [AppDelegate showStatusWithText:@"数据库创建失败" duration:2];
            NSLog(@"shibai");
        } else {
            //            [AppDelegate showStatusWithText:@"数据库创建成功" duration:2];
            NSLog(@"chenggong");

        }
    }
}

/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void) saveUser:(SUser *) user {
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO SUser"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:100];
    if (user.userId) {
        [keys appendString:@"UserId,"];
        [values appendString:@"?,"];
        [arguments addObject:user.userId];
    }
    if (user.f_userId) {
        [keys appendString:@"f_UserId,"];
        [values appendString:@"?,"];
        [arguments addObject:user.f_userId];
    }
    if (user.Type) {
        [keys appendString:@"Type,"];
        [values appendString:@"?,"];
        [arguments addObject:user.Type];
    }
    if (user.Time1) {
        [keys appendString:@"Time1,"];
        [values appendString:@"?,"];
        [arguments addObject:user.Time1];
    }
    if (user.Message) {
        [keys appendString:@"Message,"];
        [values appendString:@"?,"];
        [arguments addObject:user.Message];
    }
    if (user.Pic) {
        [keys appendString:@"Pic,"];
        [values appendString:@"?,"];
        [arguments addObject:user.Pic];
    }
    if (user.Midea) {
        [keys appendString:@"Midea,"];
        [values appendString:@"?,"];
        [arguments addObject:user.Midea];
    }
    if (user.TypeUser) {
        [keys appendString:@"TypeUser,"];
        [values appendString:@"?,"];
        [arguments addObject:user.TypeUser];
    }
    if (user.mixPic) {
        [keys appendString:@"mixPic,"];
        [values appendString:@"?,"];
        [arguments addObject:user.mixPic];
    }
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
//    NSLog(@"%@",query);
//    [AppDelegate showStatusWithText:@"插入一条数据" duration:2.0];
    [_db executeUpdate:query withArgumentsInArray:arguments];
}

/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
//- (void) deleteUserWithId:(NSString *) uid {
//    NSString * query = [NSString stringWithFormat:@"DELETE FROM SUser WHERE uid = '%@'",uid];
////    [AppDelegate showStatusWithText:@"删除一条数据" duration:2.0];
//    [_db executeUpdate:query];
//}

/**
 * @brief 修改用户的信息
 *
 * @param user 需要修改的用户信息
 */
//- (void) mergeWithUser:(SUser *) user {
////    if (!user.uid) {
////        return;
////    }
////    
//    NSString * query = [NSString stringWithFormat:@"UPDATE SUser SET Type=%@ where f_UserId=%@",user.Type,user.f_userId ];
//    [_db executeUpdate:query];
//}

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 */

-(BOOL)updateOperationInfoQuestionID:(arryCell *)arrCell
{
       NSString *selectSQL = @"SELECT *FROM Message WHERE f_UserId = ? and UserId=?";
    FMResultSet *resultSet = [_db executeQuery:selectSQL,arrCell.fuid,arrCell.uid];
    BOOL success;
    if ([resultSet next])
    {
        NSString *updateSQL = @"UPDATE Message SET Time1=?,Message = ?,TypeUser=?,description=?,TypeSize=? WHERE f_UserId = ? and UserId=?";
        success = [_db executeUpdate:updateSQL,arrCell.Time1,arrCell.Message,arrCell.Pic,arrCell.description,arrCell.Midea,arrCell.fuid,arrCell.uid];
    }
    else
    {
        NSString *insertSQL = @"INSERT INTO Message(UserId,f_UserId,Message,Time1,TypeUser,description,TypeSize) values (?,?,?,?,?,?,?)";
        success = [_db executeUpdate:insertSQL,arrCell.uid,arrCell.fuid,arrCell.Message,arrCell.Time1,arrCell.Pic,arrCell.description,arrCell.Midea];
        
    }
//    [exerciseDB close];
    
    return success;
    
}
-(BOOL)updateOperationInfoQuestionIDSize:(arryCell *)arrCell
{
    NSString *selectSQL = @"SELECT *FROM Message WHERE f_UserId = ? and UserId=?";
    FMResultSet *resultSet = [_db executeQuery:selectSQL,arrCell.fuid,arrCell.uid];
    BOOL success;
    if ([resultSet next])
    {
        NSString *updateSQL = @"UPDATE Message SET description=?,Time1=? WHERE f_UserId = ? and UserId=?";
        success = [_db executeUpdate:updateSQL,arrCell.description,arrCell.Time1,arrCell.fuid,arrCell.uid];
    }
    else
    {

        NSString *insertSQL = @"INSERT INTO Message(UserId,f_UserId,description,TypeUser,TypeSize,Time1) values (?,?,?,?,?,?)";
        success = [_db executeUpdate:insertSQL,arrCell.uid,arrCell.fuid,arrCell.description,arrCell.TypeUser,arrCell.Midea,arrCell.Time1];
        
    }
    //    [exerciseDB close];
    
    return success;
    
}

-(NSMutableArray *)findAll:(NSString *)Fuid UserId:(NSString *)sUid
{
    NSMutableArray *array=[[[NSMutableArray alloc]init] autorelease];
    NSString *str=[NSString stringWithFormat:@"select * from suser where f_userId=%@ and UserId=%@ order by time1 asc",Fuid,sUid];
    FMResultSet * rs = [_db executeQuery:str];
    //        NSLog(@"question%i:%@",i,[arr objectAtIndex:i]);
    if ([_db hadError]) {
        [_db rollback];
    }
    else{

        while ([rs next]) {

            SUser * tmpModel = [[SUser alloc] init];
            tmpModel.f_userId = [rs stringForColumn:@"f_UserId"] ;
            tmpModel.Message = [rs stringForColumn:@"Message"];
            tmpModel.Pic = [rs stringForColumn:@"Pic"] ;
            tmpModel.Midea = [rs stringForColumn:@"Midea"] ;
            tmpModel.Type = [[rs  stringForColumn:@"Type"] retain];
            tmpModel.Time1 = [[rs stringForColumn:@"Time1"] retain];
            tmpModel.TypeUser = [[rs stringForColumn:@"TypeUser"] retain];
            tmpModel.mixPic=[rs stringForColumn:@"mixPic"];

            [array addObject:tmpModel];
            [tmpModel release];
          }
    }
    
    return array;


}
-(arryCell *)findUserId:(NSString *)Fuid UserId:(NSString *)userId
{
    arryCell * tmpModel = [[[arryCell alloc] init] autorelease];
    
    NSString *str=[NSString stringWithFormat:@"select * from Message where f_userId=%@ and UserId=%@",Fuid,userId];
    FMResultSet * rs = [_db executeQuery:str];
    //        NSLog(@"question%i:%@",i,[arr objectAtIndex:i]);
    if ([_db hadError]) {
        [_db rollback];
    }
    else{
        while ([rs next]) {
            tmpModel.fuid = [rs stringForColumn:@"f_UserId"] ;
            tmpModel.Message = [rs stringForColumn:@"Message"] ;
            tmpModel.Pic = [[rs stringForColumn:@"TypeUser"] retain];
            tmpModel.description = [rs  stringForColumn:@"description"] ;
            tmpModel.Time1 = [rs stringForColumn:@"Time1"] ;
            tmpModel.Midea=[rs stringForColumn:@"TypeSize"] ;

            
            
        }
    }
    
    return tmpModel;
    
    
}
-(void)deleteMiaUserId:(NSString *)Fuid UserId:(NSString *)userId
{

    NSString *str=[NSString stringWithFormat:@"select * from Message where f_userId=%@ and UserId=%@",Fuid,userId];
    FMResultSet * rs = [_db executeQuery:str];
    //        NSLog(@"question%i:%@",i,[arr objectAtIndex:i]);
    if ([_db hadError]) {
        [_db rollback];
    }
    else{
        
        while ([rs next]) {
            
//           [rs stringForColumn:@"Pic"] ;
//             [rs stringForColumn:@"Midea"] ;
//            [rs stringForColumn:@"mixPic"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSLog(@"wwwww=%@",[rs stringForColumn:@"Midea"]);
//            [[rs stringForColumn:@"Midea"] substringWithRange:NSMakeRange(50, 8)];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            //    [NSString stringWithFormat:@"%@.3pg",self.strMia]
            NSString *file=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.3gp",[[rs stringForColumn:@"Midea"] substringWithRange:NSMakeRange(50, 8)]]];
            [fileManager removeItemAtPath:[rs stringForColumn:@"Pic"] error:nil];
            [fileManager removeItemAtPath:file error:nil];
            [fileManager removeItemAtPath:[rs stringForColumn:@"mixPic"] error:nil];

        }
    }




}
-(BOOL)deleteUserId:(NSString *)Fuid UserId:(NSString *)userId
{

    NSString *str=[NSString stringWithFormat:@"delete from Message where f_userId=%@ and UserId=%@",Fuid,userId];
        NSLog(@"question:%@",str);
    BOOL  success= [_db executeUpdate:str];
    return success;       
    
}
-(BOOL)deleteJiLuUserId:(NSString *)Fuid UserId:(NSString *)userId
{
    
    NSString *str=[NSString stringWithFormat:@"delete from SUser where f_userId=%@ and UserId=%@",Fuid,userId];
    NSLog(@"question:%@",str);
    BOOL  success= [_db executeUpdate:str];
    return success;
    
}

-(NSMutableArray *)findMessageAll:(NSString *)UserId
{
    NSMutableArray *array1=[[[NSMutableArray alloc]init] autorelease] ;
    NSString *str=[NSString stringWithFormat:@"select * from Message where UserId=%@ order by Time1 desc",UserId];
    FMResultSet * rs = [_db executeQuery:str];
    //        NSLog(@"question%i:%@",i,[arr objectAtIndex:i]);
    if ([_db hadError]) {
        [_db rollback];
    }
    else{
        while ([rs next]) {
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            NSDictionary *arr= [userDefaults dictionaryForKey:@"personF_Uid"];
            if (([arr objectForKey:[rs stringForColumn:@"f_UserId"]]==nil)&&([[rs stringForColumn:@"TypeSize"] length]==0)) {
                continue;
            }
            arryCell * tmpModel = [[arryCell alloc] init];
            tmpModel.fuid = [rs stringForColumn:@"f_UserId"] ;
            tmpModel.Message = [rs stringForColumn:@"Message"] ;
            tmpModel.Pic = [rs stringForColumn:@"TypeUser"] ;
            tmpModel.description = [rs  stringForColumn:@"description"] ;
            tmpModel.Time1 = [rs stringForColumn:@"Time1"];
            tmpModel.Midea=[rs stringForColumn:@"TypeSize"] ;

            [array1 addObject:tmpModel];
            [tmpModel release];
        }
    }
  
    return array1;
    
    
}
-(int)findSizeAll:(NSString *)UserId
{
    int index=0;
    NSString *str=[NSString stringWithFormat:@"select * from Message where UserId=%@ order by Time1 desc",UserId];
    FMResultSet * rs = [_db executeQuery:str];
    //        NSLog(@"question%i:%@",i,[arr objectAtIndex:i]);
    if ([_db hadError]) {
        [_db rollback];
    }
    else{
        while ([rs next]) {
            
        
            index =index + [[rs  stringForColumn:@"description"] intValue];

        }
    }
    
    return index;
    
    
}

//-(void)findType
//{
//
// NSString *str=@"select f_userId from suser where type=1 group by f_userId";
//    NSMutableArray *array=[[[NSMutableArray alloc]init] autorelease];
//    //        NSLog(@"ddd:%@",[arr objectAtIndex:i]);
//    FMResultSet * rs = [_db executeQuery:str];
//    //        NSLog(@"question%i:%@",i,[arr objectAtIndex:i]);
//    if ([_db hadError]) {
//        //NSLog(@"Err %d :%@",[db lastErrorCode],[database.db lastError]);
//        [_db rollback];
//    }
//    else{
//        while ([rs next]) {
//            //            uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,UserId VARCHAR(500),f_UserId VARCHAR(500),Type VARCHAR(500), Message VARCHAR(500),Pic VARCHAR(500),Midea VARCHAR(500),Time1 VARCHAR(500),TypeUser VARCHAR(500), description VARCHAR(100))
//            SUser * tmpModel = [[SUser alloc] init];
//            
//            tmpModel.f_userId = [rs stringForColumn:@"f_UserId"];
//            tmpModel.Message = [rs stringForColumn:@"Message"];
//            //                NSLog(@"tttt:%d.%@",tmpModel.questionID,tmpModel.question);
//            tmpModel.Pic = [rs stringForColumn:@"Pic"];
//            tmpModel.Midea = [rs stringForColumn:@"Midea"];
//            tmpModel.Type = [rs  stringForColumn:@"Type"];
//            tmpModel.Time1 = [rs stringForColumn:@"Time1"];
//            tmpModel.TypeUser = [rs stringForColumn:@"TypeUser"];
//            [array addObject:tmpModel];
//            [tmpModel release];
//        }
//    }
//    
//
//
//
//
//
//}
-(void)dealloc
{
    [super dealloc];
    


}
@end
