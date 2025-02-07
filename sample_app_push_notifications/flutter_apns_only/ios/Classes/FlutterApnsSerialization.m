//
//  Serialization.m
//  flutter_apns
//
//  Created by Pawel Szot on 19/03/2021.
//

#import "FlutterApnsSerialization.h"
#import <UserNotifications/UserNotifications.h>

@implementation FlutterApnsSerialization

+ (NSDictionary *)remoteMessageUserInfoToDict:(NSDictionary *)userInfo {
  NSMutableDictionary *message = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *notification = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *notificationIOS = [[NSMutableDictionary alloc] init];

  // message.data
  for (id key in userInfo) {
    // message.messageId
    if ([key isEqualToString:@"gcm.message_id"] || [key isEqualToString:@"google.message_id"] ||
        [key isEqualToString:@"message_id"]) {
      message[@"messageId"] = userInfo[key];
      continue;
    }

    // message.messageType
    if ([key isEqualToString:@"message_type"]) {
      message[@"messageType"] = userInfo[key];
      continue;
    }

    // message.collapseKey
    if ([key isEqualToString:@"collapse_key"]) {
      message[@"collapseKey"] = userInfo[key];
      continue;
    }

    // message.from
    if ([key isEqualToString:@"from"]) {
      message[@"from"] = userInfo[key];
      continue;
    }

    // message.sentTime
    if ([key isEqualToString:@"google.c.a.ts"]) {
      message[@"sentTime"] = userInfo[key];
      continue;
    }

    // message.to
    if ([key isEqualToString:@"to"] || [key isEqualToString:@"google.to"]) {
      message[@"to"] = userInfo[key];
      continue;
    }

    // build data dict from remaining keys but skip keys that shouldn't be included in data
    if ([key isEqualToString:@"aps"] || [key hasPrefix:@"gcm."] || [key hasPrefix:@"google."]) {
      continue;
    }

    // message.apple.imageUrl
    if ([key isEqualToString:@"fcm_options"]) {
      if (userInfo[key] != nil && userInfo[key][@"image"] != nil) {
        notificationIOS[@"imageUrl"] = userInfo[key][@"image"];
      }
      continue;
    }

    data[key] = userInfo[key];
  }
  message[@"data"] = data;

  if (userInfo[@"aps"] != nil) {
    NSDictionary *apsDict = userInfo[@"aps"];
    // message.category
    if (apsDict[@"category"] != nil) {
      message[@"category"] = apsDict[@"category"];
    }

    // message.threadId
    if (apsDict[@"thread-id"] != nil) {
      message[@"threadId"] = apsDict[@"thread-id"];
    }

    // message.contentAvailable
    if (apsDict[@"content-available"] != nil) {
      message[@"contentAvailable"] = @([apsDict[@"content-available"] boolValue]);
    }

    // message.mutableContent
    if (apsDict[@"mutable-content"] != nil && [apsDict[@"mutable-content"] intValue] == 1) {
      message[@"mutableContent"] = @([apsDict[@"mutable-content"] boolValue]);
    }

    // message.notification.*
    if (apsDict[@"alert"] != nil) {
      // can be a string or dictionary
      if ([apsDict[@"alert"] isKindOfClass:[NSString class]]) {
        // message.notification.title
        notification[@"title"] = apsDict[@"alert"];
      } else if ([apsDict[@"alert"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *apsAlertDict = apsDict[@"alert"];

        // message.notification.title
        if (apsAlertDict[@"title"] != nil) {
          notification[@"title"] = apsAlertDict[@"title"];
        }

        // message.notification.titleLocKey
        if (apsAlertDict[@"title-loc-key"] != nil) {
          notification[@"titleLocKey"] = apsAlertDict[@"title-loc-key"];
        }

        // message.notification.titleLocArgs
        if (apsAlertDict[@"title-loc-args"] != nil) {
          notification[@"titleLocArgs"] = apsAlertDict[@"title-loc-args"];
        }

        // message.notification.body
        if (apsAlertDict[@"body"] != nil) {
          notification[@"body"] = apsAlertDict[@"body"];
        }

        // message.notification.bodyLocKey
        if (apsAlertDict[@"loc-key"] != nil) {
          notification[@"bodyLocKey"] = apsAlertDict[@"loc-key"];
        }

        // message.notification.bodyLocArgs
        if (apsAlertDict[@"loc-args"] != nil) {
          notification[@"bodyLocArgs"] = apsAlertDict[@"loc-args"];
        }

        // Apple only
        // message.notification.apple.subtitle
        if (apsAlertDict[@"subtitle"] != nil) {
          notificationIOS[@"subtitle"] = apsAlertDict[@"subtitle"];
        }

        // Apple only
        // message.notification.apple.subtitleLocKey
        if (apsAlertDict[@"subtitle-loc-key"] != nil) {
          notificationIOS[@"subtitleLocKey"] = apsAlertDict[@"subtitle-loc-key"];
        }

        // Apple only
        // message.notification.apple.subtitleLocArgs
        if (apsAlertDict[@"subtitle-loc-args"] != nil) {
          notificationIOS[@"subtitleLocArgs"] = apsAlertDict[@"subtitle-loc-args"];
        }

        // Apple only
        // message.notification.apple.badge
        if (apsAlertDict[@"badge"] != nil) {
          notificationIOS[@"badge"] = apsAlertDict[@"badge"];
        }
      }

      notification[@"apple"] = notificationIOS;
      message[@"notification"] = notification;
    }

    // message.notification.apple.sound
    if (apsDict[@"sound"] != nil) {
      if ([apsDict[@"sound"] isKindOfClass:[NSString class]]) {
        // message.notification.apple.sound
        notification[@"sound"] = @{
          @"name" : apsDict[@"sound"],
          @"critical" : @NO,
          @"volume" : @1,
        };
      } else if ([apsDict[@"sound"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *apsSoundDict = apsDict[@"sound"];
        NSMutableDictionary *notificationIOSSound = [[NSMutableDictionary alloc] init];

        // message.notification.apple.sound.name String
        if (apsSoundDict[@"name"] != nil) {
          notificationIOSSound[@"name"] = apsSoundDict[@"name"];
        }

        // message.notification.apple.sound.critical Boolean
        if (apsSoundDict[@"critical"] != nil) {
          notificationIOSSound[@"critical"] = @([apsSoundDict[@"critical"] boolValue]);
        }

        // message.notification.apple.sound.volume Number
        if (apsSoundDict[@"volume"] != nil) {
          notificationIOSSound[@"volume"] = apsSoundDict[@"volume"];
        }

        // message.notification.apple.sound
        notificationIOS[@"sound"] = notificationIOSSound;
      }

      notification[@"apple"] = notificationIOS;
      message[@"notification"] = notification;
    }
  }

  return message;
}

@end
