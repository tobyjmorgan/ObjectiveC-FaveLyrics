//
//  AlbumCollectionViewCell.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/31/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackCount;
@property (strong, nonatomic) IBOutlet UIView *containingView;

@property (strong, nonatomic) NSString *photoURLString;

@end
