using ntfn.db from '../db/schema';
using { ExecuteActionResultType } from '../db/types';

service NtfnService {

  entity Actions as projection on db.Action;
  entity BulkActionResultTypes as projection on db.BulkActionResultType actions {
    action BulkActionByHeader(ParentId: UUID not null, ActionId: String(32) not null) returns BulkActionResultTypes;

  };
  entity Channels as projection on db.Channel;
  entity NavigationTargetParams as projection on db.NavigationTargetParam;
  entity Notifications as projection on db.Notification;
  entity NotificationTypePersonalizationSet as projection on db.NotificationTypePersonalization;

  action Dismiss(NotificationId: UUID not null);
  action DismissAll(ParentId: UUID not null);
  action ExecuteAction(NotificationId: UUID not null, ActionId: String(32) not null) returns ExecuteActionResultType;
  action MarkRead(NotificationId: UUID not null);
  action ResetBadgeNumber();
  action ResetBadgeNumberByIntent(NavigationIntent: String not null);
  function GetBadgeNumber() returns Integer not null;
  function GetBadgeNumberByIntent(NavigationIntent: String not null) returns Integer not null;
}
