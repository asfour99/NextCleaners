//
//  APIKeys.h
//  Koovs-Fashion
//
//  Created by Deepak on 04/06/14.
//  Copyright (c) 2014 Koovs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


#define NAVIGATION_BAR_HEIGHT 64.0f
#define TAB_BAR_HEIGHT 49.0f

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define VALID_MAIL_REGEX @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"\
@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"\
@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"\
@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"\
@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"\
@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"\
@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"\




//PRODUCT DETAIL
#define KEY_ID @"id"
#define KEY_PARENT_ID @"parent_id"
#define KEY_PRODUCT_DESCRIPTION @"product_description"
#define KEY_PRODUCT_NAME @"product_name"
#define KEY_RESPONSE @"response"
#define KEY_DOC @"docs"
#define KEY_ANCHOR @"anchor"
#define KEY_MASTER_CATEGORYID_REF @"master_categoryid_ref"
#define KEY_META_KEYWORDS @"meta_keywords"
#define KEY_DISCOUNT @"discount"
#define KEY_MASTER_CATEGORY_NAME @"master_category_name"
#define KEY_PRICE @"price"
//#define KEY_SELLING_PRICE @"selling_price"
#define KEY_DISCOUNT_PRICE @"discount_price"
#define KEY_META_KEYWORDS @"meta_keywords"
#define KEY_DEFAULT_SKU @"default_sku"
#define KEY_IS_OOS @"is_oos"
#define KEY_OTHER_DETAIL @"other_details"
#define KEY_SIZECHARTIMAGE @"sizeChartImage"
#define KEY_STYLETIP_INFO @"styletipInfo"
#define KEY_STYLETIP_MATERIAL @"styletipMaterial"
#define KEY_STYLETIP_SIZEFIT @"styletipSizeFit"
#define KEY_STYLETIP_MODEL_SIZE @"styletipModelSize"
//#define KEY_STYLETIP_MODEL_HEIGHT @"styletipModelHeight"
//#define KEY_STYLETIP_MODEL_BUST @"styletipModelBust"
//#define KEY_STYLETIP_MODEL_HIPS @"styletipModelHips"
//#define KEY_STYLETIP_MODEL_WAIST @"styletipModelWaist"
#define KEY_STYLETIP_MODEL_SIZE_TEXT @"styletipModelSizeText"
#define KEY_BRAND_INFO @"brandInfo"
#define KEY_BRAND_NAME_KEY @"brandName"
#define KEY_BRAND_NAME_RECOMMENDED @"brand_name"
#define KEY_BRAND_DESCRIPTION @"brandDescription"
#define KEY_TAB_BODY_NAME @"tabBodyName"
#define KEY_AUDIO_URL @"audioURL"
#define KEY_VIDEOFILE @"videoFile"
#define KEY_BODY @"body"
#define KEY_PRODUCT_OOS @"productOOS"
#define KEY_INFO_CARE @"infoCare"
#define KEY_SKU_DETAILS @"sku_details"
#define KEY_SKU @"sku"
#define KEY_BACK_IMG @"back_img"
#define KEY_LEFT_IMG @"left_img"
#define KEY_FRONT_IMG @"front_img"
#define KEY_DEFAULT_IMG @"default_img"
#define KEY_OOS @"oos"
#define KEY_OPTIONS @"options"
#define KEY_OPTIONS_SIZE @"options.Size"
#define KEY_OPTIONS_COLOR @"options.Color"

#define KEY_ATTRIBUTE_VALUE @"attribute_value"
#define KEY_ATTRIBUTE_VALUE_ID @"attribute_value_id"
#define KEY_ATTRIBUTE_CODE @"attribute_code"

#define KEY_COLOR_ATTRIBUTE_VALUE @"color_attribute_value"
#define KEY_COLOR_ATTRIBUTE_VALUE_ID @"color_attribute_value_id"
#define KEY_COLOR_ATTRIBUTE_CODE @"color_attribute_code"
#define KEY_SIZE_ATTRIBUTE_VALUE @"size_attribute_value"
#define KEY_TITLE @"title"
#define KEY_VIDEO_FILE @"video_file"

#define KEY_DELIVERY @"delivery"
#define KEY_RETURNS @"returns"


#define TAG_RECOMMENDED_API @"recommendedApiCall"
#define TAG_SAVE_FOR_LATER  @"saveForLaterCall"
#define KEY_PRODUCT_ID @"product_id"
#define KEY_CONTENTS @"contents"
#define KEY_SOCIAL_SHARING_LINK @"shareLink"
#define KEY_SUB_CATEGORY_ID_REF @"sub_categoryid_ref"
#define KEY_AVAILABLE_COLORS @"available_colors"
#define KEY_DEFAULT_COLOR @"default_color"

//#define SHOPPING_BAG_API_CALL @"shoppingBagApiCall"


//Home api keys
#define KEY_MEN_BANNERS @"men_banners"
#define KEY_WOMEN_BANNERS @"women_banners"


@interface APIKeys : NSObject

@end
