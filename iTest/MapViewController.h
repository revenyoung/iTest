//
//  MapViewController.h
//  iTest
//
//  Created by revenyoung on 14-3-27.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property(retain, nonatomic) IBOutlet UITextField* textField_Longitude;
@property(retain, nonatomic) IBOutlet UITextField* textField_Latitude;
@property(retain, nonatomic) IBOutlet MKMapView* mapView;

@end
