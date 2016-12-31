//
//  HTTPKey.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/23/16.
//  Copyright © 2016 redBred. All rights reserved.
//


// Default Parameter Keys
#define HTTPKey_format                      @"format"
#define HTTPKey_apikey                      @"apikey"
#define HTTPKey_page_size                   @"page_size"

// Artist Related HTTP Keys
#define HTTPKey_artist                      @"artist"
#define HTTPKey_artist_id                   @"artist_id"
#define HTTPKey_artist_name                 @"artist_name"
#define HTTPKey_artist_country              @"artist_country"
#define HTTPKey_artist_rating               @"artist_rating"
#define HTTPKey_artist_twitter_url          @"artist_twitter_url"
#define HTTPKey_music_genre_name            @"music_genre_name"

#define HTTPKeyPath_artist_get_result       @"message.body.artist"
#define HTTPKeyPath_artist_search_results   @"message.body.artist_list"
#define HTTPKeyPath_primary_genres          @"primary_genres.music_genre_list.music_genre"
#define HTTPKeyPath_secondary_genres        @"secondary_genres.music_genre_list.music_genre"

// Album Related HTTP Keys
#define HTTPKey_album                       @"album"
#define HTTPKey_album_id                    @"album_id"
#define HTTPKey_album_name                  @"album_name"
#define HTTPKey_album_rating                @"album_rating"
#define HTTPKey_album_track_count           @"album_track_count"
#define HTTPKey_album_release_date          @"album_release_date"
#define HTTPKey_album_release_type          @"album_release_type"
#define HTTPKey_album_label                 @"album_label"
#define HTTPKey_album_copyright             @"album_copyright"
#define HTTPKey_album_coverart_100x100      @"album_coverart_100x100"
#define HTTPKey_album_vanity_id             @"album_vanity_id"

#define HTTPKeyPath_albums_get_results      @"message.body.album_list"


// Track Related HTTP Keys
#define HTTPKey_track                       @"track"
#define HTTPKey_track_id                    @"track_id"
#define HTTPKey_track_name                  @"track_name"
#define HTTPKey_track_rating                @"track_rating"
#define HTTPKey_track_length                @"track_length"
#define HTTPKey_commontrack_id              @"commontrack_id"
#define HTTPKey_instrumental                @"instrumental"
#define HTTPKey_explicit                    @"explicit"
#define HTTPKey_has_lyrics                  @"has_lyrics"
#define HTTPKey_lyrics_id                   @"lyrics_id"
#define HTTPKey_num_favourite               @"num_favourite"
#define HTTPKey_track_share_url             @"track_share_url"
#define HTTPKey_first_release_date          @"first_release_date"


#define HTTPKeyPath_track_get_result        @"message.body.track"
#define HTTPKeyPath_tracks_get_results      @"message.body.track_list"


// Query Related HTTP Keys
#define HTTPKey_q_artist                    @"q_artist"
#define HTTPKey_q_lyrics                    @"q_lyrics"
#define HTTPKey_f_has_lyrics                @"f_has_lyrics"
#define HTTPKey_s_artist_rating             @"s_artist_rating"
#define HTTPKey_s_album_rating              @"s_album_rating"
#define HTTPKey_s_track_rating              @"s_track_rating"
#define HTTPKey_s_album_release_date        @"s_album_release_date"

