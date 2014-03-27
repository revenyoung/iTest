//
//  PlayerDetails.m
//  iTest
//
//  Created by revenyoung on 14-2-26.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "PlayerDetails.h"

@interface PlayerDetails ()

@end

@implementation PlayerDetails

@synthesize row;
@synthesize textField_Name;
@synthesize switch_Gender;
@synthesize textField_Age;
@synthesize imageView_Photo;
@synthesize label_UpdateTime;

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
    textField_Name.text=row.Name;
    if ([row.Gender isEqualToString:@"MALE"])
    {
        switch_Gender.on=YES;
    }
    else
    {
        switch_Gender.on=NO;
        
    }
    textField_Age.text=[[NSString alloc] initWithFormat:@"%ld",(long)row.Age];
    imageView_Photo.image=[[UIImage alloc] initWithData:row.Photo];
    NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd, HH:mm:ss"];
    label_UpdateTime.text=[formatter stringFromDate:row.UpdateTime];
    
    imageView_Photo.userInteractionEnabled=YES;
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView_Click:)];
    [imageView_Photo addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)imageView_Click:(id)sender
{
    UIActionSheet* imageActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    [imageActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self fromLocalPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
        default:
            break;
    }
}

-(void)fromLocalPhoto
{
    //资源类型为相册
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate=self;
        picker.sourceType=sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"无法进入相册");
    }
}

-(void)takePhoto
{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"该设备无摄像头");
    }
}

#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"Get image");
    NSData* photo = UIImageJPEGRepresentation(image, 1.0);
    row.Photo=photo;
    row.changed=YES;
    
    CGSize size= CGSizeMake(120, 120);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* display = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView_Photo.image=display;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"will disappear");
    if(switch_Gender.isOn)
    {
        row.Gender=@"MALE";
    }
    else
    {
        row.Gender=@"FEMALE";
    }
    row.Age= [textField_Age.text intValue];
    row.changed=YES;
}
@end
