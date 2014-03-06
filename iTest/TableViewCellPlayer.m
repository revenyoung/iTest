//
//  TableViewCellPlayer.m
//  iTest
//
//  Created by revenyoung on 14-2-23.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "TableViewCellPlayer.h"

@implementation TableViewCellPlayer

@synthesize row;
@synthesize label_Name;
@synthesize label_Gender;
@synthesize label_Age;
@synthesize imageView_Photo;

-(void)cellDidLoad
{
    label_Name.text=row.Name;
    label_Gender.text=row.Gender;
    label_Age.text=[[NSString alloc] initWithFormat:@"%d",row.Age ];
    imageView_Photo.image=[[UIImage alloc] initWithData:row.Photo];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
