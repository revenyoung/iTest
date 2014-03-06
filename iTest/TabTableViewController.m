//
//  TabTableViewController.m
//  iTest
//
//  Created by revenyoung on 14-2-19.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "TabTableViewController.h"
#import <sqlite3.h>
#import "Player.h"
#import "TableViewCellPlayer.h"
#import "PlayerDetails.h"

@interface TabTableViewController ()

@end

@implementation TabTableViewController

NSString *databasePath;
NSMutableArray *dataList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.view setBounds:CGRectMake(0, 0, 320, 100)];
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* sqlitePath = [paths objectAtIndex:0];
    databasePath = [sqlitePath stringByAppendingPathComponent:@"sqlTest.sqlite"];
    sqlite3* database;
    
    if(sqlite3_open([databasePath UTF8String], &database)!=SQLITE_OK)
    {
        //数据库打开失败，关闭数据库
        sqlite3_close(database);
        NSAssert(0,@"打开数据库失败");
    }
    
     NSString* sqlString = @"CREATE TABLE IF NOT EXISTS Player (NAME TEXT PRIMARY KEY, GENDER TEXT, AGE INT, PHOTO BIT, UPDATETIME DATETIME);";
    
     char* errorMsg;
     if(sqlite3_exec(database, [sqlString UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK)
     {
         sqlite3_close(database);
         NSAssert1(0, @"创建表失败：%s", errorMsg);
     }
    
    dataList=[[NSMutableArray alloc] init];
    sqlString = @"SELECT NAME, GENDER, AGE, PHOTO, UPDATETIME FROM Player ORDER BY UPDATETIME ASC";
    sqlite3_stmt* statment;
    if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &statment, nil) == SQLITE_OK)
    {
        while(sqlite3_step(statment) == SQLITE_ROW)
        {
            Player* player=[[Player alloc] init];
            player.Name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 0)];
            player.Gender=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 1)];
            player.Age=(int)sqlite3_column_int(statment, 2);
            player.Photo=[[NSData alloc] initWithBytes:sqlite3_column_blob(statment, 3)
                                                length:sqlite3_column_bytes(statment, 3)];
            player.UpdateTime=[[NSDate alloc] initWithTimeIntervalSince1970:sqlite3_column_double(statment, 4)];
            
            [dataList addObject:player];
        }
        sqlite3_finalize(statment);
    }
    sqlite3_close(database);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    TableViewCellPlayer* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Player* player=[dataList objectAtIndex:indexPath.item];
    cell.row=player;
    [cell cellDidLoad];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    NSLog(@"%d", indexPath.item);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TableViewCellPlayer* src=(TableViewCellPlayer*)sender;
    PlayerDetails* dest=segue.destinationViewController;
    [dest setValue:src.row forKey:@"row"];
}

-(void)viewWillAppear:(BOOL)animated
{
    for(int i=0;i<dataList.count;i++)
    {
        Player* item=[dataList objectAtIndex:i];
        if(item.changed)
        {
            sqlite3* database;
            
            if(sqlite3_open([databasePath UTF8String], &database)!=SQLITE_OK)
            {
                //数据库打开失败，关闭数据库
                sqlite3_close(database);
                NSAssert(0,@"打开数据库失败");
            }

            NSString* sqlString = @"UPDATE Player SET GENDER=?, AGE=?, PHOTO=?, UPDATETIME=? WHERE NAME=?";
            sqlite3_stmt* statement;
            if (sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                sqlite3_bind_text(statement, 1, [item.Gender UTF8String], item.Gender.length, NULL);
                sqlite3_bind_int(statement, 2, item.Age);
                sqlite3_bind_blob(statement, 3, item.Photo.bytes, item.Photo.length, NULL);
                sqlite3_bind_double(statement, 4, [[NSDate date] timeIntervalSince1970]);
                sqlite3_bind_text(statement, 5, [item.Name UTF8String], item.Name.length , NULL);
            }
            
            if (sqlite3_step(statement) != SQLITE_DONE)
            {
                NSAssert(NO, @"插入数据失败");
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    
    [self.tableView reloadData];
}
@end
