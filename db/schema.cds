namespace ntfn.db;
using { Actor } from './types';

entity BulkActionResultType {
  key NotificationId: UUID not null;
  Success: Boolean not null;
  DeleteOnReturn: Boolean not null;
}

entity Channel {
  key ChannelId: String(21) not null;
  IsActive: Boolean not null;
  Description: String(60);
}

entity NavigationTargetParam {
  key NotificationId: UUID not null;
  key ![Key]: String(100) not null;
  Value: String not null;
}

entity Notification {
  key Id: UUID not null;
  OriginId: String(16) not null;
  CreatedAt: DateTime not null;
  IsActionable: Boolean not null;
  IsRead: Boolean not null;
  IsGroupable: Boolean not null;
  IsGroupHeader: Boolean not null;
  NavigationTargetAction: String not null;
  NavigationTargetObject: String not null;
  NavigationIntent: String not null;
  NotificationTypeId: String not null;
  NotificationTypeKey: String(32) not null;
  ParentId: UUID;
  Priority: String(20) not null;
  SensitiveText: String not null;
  Text: String not null;
  GroupHeaderText: String not null;
  NotificationCount: Integer not null;
  SubTitle: String;
  NotificationTypeDesc: String(40);
  Actor: Actor not null;

  Actions: Association to many Action on Actions.ActionId = NavigationTargetAction;
  NavigationTargetParams: Association to many NavigationTargetParam on NavigationTargetParams.NotificationId = Id;
}

entity NotificationTypePersonalization {
  key NotificationTypeId: UUID not null;
  NotificationTypeDesc: String(40) not null;
  PriorityDefault: String(20);
  DoNotDeliver: Boolean not null;
  DoNotDeliverMob: Boolean not null;
}

entity Action {
  key ActionId: String(32) not null;
  ActionText: String(40) not null;
  GroupActionText: String(40) not null;
  Nature: String(20) not null;
}
