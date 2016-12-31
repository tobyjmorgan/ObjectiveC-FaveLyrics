//
//  AlbumCell.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/30/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumVanityLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackCount;

@end
