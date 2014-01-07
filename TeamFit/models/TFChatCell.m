//
//  TFChatCell.m
//  TeamFit
//
//  Created by Nirav Patel on 23/12/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "TFChatCell.h"

@implementation TFChatCell

@synthesize userLabel, timeLabel, textString;

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
