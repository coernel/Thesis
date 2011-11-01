//
//  Record.h
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject {
    
    //Patient related
    float float_Height;
    float float_Weight;
    NSString *str_Sex;
    NSString  *date_Born;
    
    //study related    
    NSString *str_FollowUp;
    NSString *str_Joint;
    NSDate   *date_DateOfRecord;
    
    //thesis related
    NSString *str_OSVersion;
    NSString *str_Device;
    
}

@property (nonatomic, retain) NSString *str_Sex;
@property (nonatomic, retain) NSString *date_Born;

@property (nonatomic, retain) NSString *str_FollowUp;
@property (nonatomic, retain) NSString *str_Joint;

@property (nonatomic, retain) NSDate *date_DateOfRecord;
@property (nonatomic, retain) NSString *str_OSVersion;
@property (nonatomic, retain) NSString *str_Device;



//set informationS
-(void)setPatientData:(NSString *)born andHeight:(float *)height andWeight:(float *)weight andSex:(NSString *)sex;
-(void)setStudyData:(NSString *)followUp andJoint:(NSString *)joint andDate:(NSDate *)date;
-(void)setThesisData:(NSString *)device andVersion:(NSString *)version;

//retrieve data
-(NSString *)getFileName;
-(NSString *)getFileHeader;

                                                                                                                                

@end
