//
//  CollectionViewController.m
//  iTest
//
//  Created by revenyoung on 14-3-8.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "CollectionViewController.h"
#import <sqlite3.h>
#import "Func.h"
#import "CollectionViewCellFunc.h"
#import "ReusableViewHeader.h"
#import "ReusableViewFooter.h"
#import "FuncDetails.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

NSString *databasePath;
NSMutableArray *dataList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    
    NSString* sqlString = @"CREATE TABLE IF NOT EXISTS Func (CD TEXT PRIMARY KEY, NAME TEXT, ICON BIT, UPDATETIME DATETIME);";
    
    char* errorMsg;
    if(sqlite3_exec(database, [sqlString UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"创建表失败：%s", errorMsg);
    }
    
    dataList=[[NSMutableArray alloc] init];
    sqlString = @"SELECT CD, NAME, ICON, UPDATETIME FROM Func ORDER BY NAME ASC";
    sqlite3_stmt* statment;
    if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &statment, nil) == SQLITE_OK)
    {
        while(sqlite3_step(statment) == SQLITE_ROW)
        {
            Func* func=[[Func alloc] init];
            func.CD=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 0)];
            func.Name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 1)];
            func.Icon=[[NSData alloc] initWithBytes:sqlite3_column_blob(statment, 2)
                                                length:sqlite3_column_bytes(statment, 2)];
            func.UpdateTime=[[NSDate alloc] initWithTimeIntervalSince1970:sqlite3_column_double(statment, 3)];
            
            [dataList addObject:func];
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

//显示多少行
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//显示多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataList.count;
}
//为每个单元设置UI
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCellFunc *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    Func* func=[dataList objectAtIndex:indexPath.item];
    cell.row=func;
    [cell cellDidLoad];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        ReusableViewHeader* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        NSString *title = [[NSString alloc] initWithFormat:@"Header"];
        headerView.label_Header.text = title;
        [headerView setBackgroundColor:[UIColor redColor]];
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        ReusableViewFooter* footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        
        NSString *title = [[NSString alloc] initWithFormat:@"Footer"];
        footerView.label_Footer.text = title;
        [footerView setBackgroundColor:[UIColor greenColor]];

        
        reusableview = footerView;
    }
    
    return reusableview;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CollectionViewCellFunc* src=(CollectionViewCellFunc*)sender;
    FuncDetails* dest=segue.destinationViewController;
    [dest setValue:src.row forKey:@"row"];
}

@end
