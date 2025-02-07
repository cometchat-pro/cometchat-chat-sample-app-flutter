import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

///[DetailUtils] is a Utility class that provides
///the default options and templates available in [CometChatDetails]
///which allows users to block and unblock other users
///group members to view, add, ban other members
class DetailUtils {
  static List<CometChatGroupMemberOption> getDefaultGroupMemberOptions(
      {User? loggedInUser,
      Group? group,
      GroupMember? member,
      required BuildContext context,}) {
    return [
      getScopeChangeOption(context),
      getBanOption(context),
      getKickOption(context),
    ]
        .where((option) {
          final result =validateGroupMemberOptions(
              loggedInUserScope: loggedInUser?.uid == group?.owner
                  ? GroupMemberScope.owner
                  : group?.scope ?? GroupMemberScope.participant,
              memberScope: member?.uid == group?.owner
                  ? GroupMemberScope.owner
                  : member?.scope ?? GroupMemberScope.participant,
              optionId: option.id);
          if(option.id==GroupMemberOptionConstants.changeScope){
            return result.isNotEmpty;
          } else {
            return result;
          }

    })
        .toList();
  }

  static CometChatGroupMemberOption getKickOption(BuildContext context) {
    return CometChatGroupMemberOption(
      id: GroupMemberOptionConstants.kick,
      title: Translations.of(context).remove,
      icon: AssetConstants.cancel,
      packageName: UIConstants.packageName,
      // backgroundColor: theme?.palette.getError() ?? Colors.red,
    );
  }

  static CometChatGroupMemberOption getBanOption(BuildContext context) {
    return CometChatGroupMemberOption(
      id: GroupMemberOptionConstants.ban,
      title: Translations.of(context).ban,
      icon: AssetConstants.block,
      packageName: UIConstants.packageName,
      // backgroundColor: theme?.palette.getOption() ?? const Color(0xffFFC900),
    );
  }

  static CometChatGroupMemberOption getScopeChangeOption(BuildContext context) {
    return CometChatGroupMemberOption(
      id: GroupMemberOptionConstants.changeScope,
      title: Translations.of(context).changeScope,
      packageName: UIConstants.packageName,
      icon: AssetConstants.changeScope96px,
    );
  }

  static CometChatDetailsOption getViewMemberOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
        id: GroupOptionConstants.viewMembers,
        title: Translations.of(context).viewMembers,
        packageName: UIConstants.packageName,
        tail: const Icon(Icons.navigate_next),
        titleStyle: _getPrimaryGroupOptionTextStyle(theme));
  }

  static CometChatDetailsOption getBannedMemberOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
        id: GroupOptionConstants.bannedMembers,
        title: Translations.of(context).bannedMembers,
        packageName: UIConstants.packageName,
        tail: const Icon(Icons.navigate_next),
        titleStyle: _getPrimaryGroupOptionTextStyle(theme));
  }

  static CometChatDetailsOption getAddMembersOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
        id: GroupOptionConstants.addMembers,
        title: Translations.of(context).addMembers,
        packageName: UIConstants.packageName,
        tail: const Icon(Icons.navigate_next),
        titleStyle: _getPrimaryGroupOptionTextStyle(theme));
  }

  static CometChatDetailsOption getLeaveGroupOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
        id: GroupOptionConstants.leave,
        title: Translations.of(context).leaveGroup,
        packageName: UIConstants.packageName,
        titleStyle: _getSecondaryGroupOptionTextStyle(theme));
  }

  static CometChatDetailsOption getDeleteGroupOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
        id: GroupOptionConstants.delete,
        title: Translations.of(context).deleteAndExit,
        packageName: UIConstants.packageName,
        titleStyle: _getSecondaryGroupOptionTextStyle(theme));
  }

  static CometChatDetailsOption getBlockUserOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
      id: UserOptionConstants.blockUser,
      title: Translations.of(context).blockUser,
      packageName: UIConstants.packageName,
      titleStyle: _getSecondaryGroupOptionTextStyle(theme),
    );
  }

  static CometChatDetailsOption getUnBlockUserOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
      id: UserOptionConstants.unblockUser,
      title: Translations.of(context).unblockUser,
      packageName: UIConstants.packageName,
      titleStyle: _getSecondaryGroupOptionTextStyle(theme),
    );
  }

  static CometChatDetailsOption getViewProfileOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
        id: UserOptionConstants.viewProfile,
        title: Translations.of(context).viewProfile,
        packageName: UIConstants.packageName,
        titleStyle: _getPrimaryOptionTextStyle(theme));
  }

  static CometChatDetailsOption getLeaveOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
      id: GroupOptionConstants.leave,
      title: Translations.of(context).leaveGroup,
      titleStyle: _getSecondaryGroupOptionTextStyle(theme),
    );
  }

  static CometChatDetailsOption getDeleteOption(BuildContext context,
      {CometChatTheme? theme}) {
    return CometChatDetailsOption(
      id: GroupOptionConstants.delete,
      title: Translations.of(context).deleteAndExit,
      packageName: UIConstants.packageName,
      titleStyle: _getSecondaryGroupOptionTextStyle(theme),
    );
  }

  static CometChatDetailsTemplate? getPrimaryDetailsTemplate(
    BuildContext context,
    User? loggedInUser,
    User? user,
    Group? group, {
    CometChatTheme? theme,
  }) {
    return CometChatDetailsTemplate(
      id: DetailsTemplateConstants.primaryActions,
      hideItemSeparator: true,
      hideSectionSeparator: false,
      options: (user, group, context, theme) => user != null
          ? []
          : [
              getViewMemberOption(context!, theme: theme),
              getAddMembersOption(context, theme: theme),
              getBannedMemberOption(context, theme: theme)
            ]
              .where((option) => validateDetailOptions(
                  loggedInUserScope: loggedInUser?.uid == group?.owner
                      ? GroupMemberScope.owner
                      : group?.scope ?? GroupMemberScope.participant,
                  optionId: option.id))
              .toList(),
    );
  }

  static CometChatDetailsTemplate? getSecondaryDetailsTemplate(
      BuildContext context, User? loggedInUser, User? user, Group? group,
      {CometChatTheme? theme}) {
    if (user != null) {
      return CometChatDetailsTemplate(
          id: DetailsTemplateConstants.secondaryActions,
          title: Translations.of(context).privacyAndSecurity,
          hideItemSeparator: true,
          hideSectionSeparator: false,
          options: (user, group, context, theme) => [
                getBlockUserOption(context!, theme: theme),
                getUnBlockUserOption(context, theme: theme)
              ]
                  .where((option) =>
                      validateUserOptions(loggedInUser, user, option.id))
                  .toList());
    } else if (group != null) {
      return CometChatDetailsTemplate(
          id: DetailsTemplateConstants.secondaryActions,
          title: Translations.of(context).more,
          hideItemSeparator: true,
          hideSectionSeparator: false,
          options: (user, group, context, theme) => [
                getLeaveGroupOption(context!, theme: theme),
                getDeleteGroupOption(context, theme: theme)
              ]
                  .where((option) => validateDetailOptions(
                      loggedInUserScope: loggedInUser?.uid == group?.owner
                          ? GroupMemberScope.owner
                          : group?.scope ?? GroupMemberScope.participant,
                      optionId: option.id))
                  .toList());
    }
    return null;
  }

  static List<CometChatDetailsTemplate> getDefaultDetailsTemplates(
      BuildContext context, User? loggedInUser,
      {User? user, Group? group}) {
    if (user != null || group != null) {
      CometChatDetailsTemplate? primaryTemplate =
          getPrimaryDetailsTemplate(context, loggedInUser, user, group);
      CometChatDetailsTemplate? secondaryTemplate =
          getSecondaryDetailsTemplate(context, loggedInUser, user, group);
      return [
        if (primaryTemplate != null) primaryTemplate,
        if (secondaryTemplate != null) secondaryTemplate
      ];
    } else {
      return [];
    }
  }

  static TextStyle _getPrimaryGroupOptionTextStyle(CometChatTheme? theme) {
    return TextStyle(
        fontFamily: theme?.typography.name.fontFamily,
        fontWeight: theme?.typography.name.fontWeight ?? FontWeight.w500,
        color: theme?.palette.getAccent800() ?? const Color(0xff000000));
  }

  static TextStyle _getSecondaryGroupOptionTextStyle(CometChatTheme? theme) {
    return TextStyle(
        fontFamily: theme?.typography.name.fontFamily,
        fontWeight: theme?.typography.name.fontWeight ?? FontWeight.w500,
        color: theme?.palette.getError() ?? const Color(0xffFF3B30));
  }

  static TextStyle _getPrimaryOptionTextStyle(CometChatTheme? theme) {
    return TextStyle(
        fontFamily: theme?.typography.name.fontFamily,
        fontWeight: theme?.typography.name.fontWeight ?? FontWeight.w500,
        color: theme?.palette.getPrimary() ?? const Color(0xff3399FF));
  }

  static dynamic validateDetailOptions(
      {required String loggedInUserScope, required String optionId}) {
    return _allowedDetailOptions[loggedInUserScope]?[optionId];
  }

  static dynamic validateGroupMemberOptions(
      {required String loggedInUserScope,
      String memberScope = GroupMemberScope.participant,
      required String optionId}) {
    print("277=> ${loggedInUserScope + memberScope}");
    return _allowedGroupMemberOptions[loggedInUserScope + memberScope]
        ?[optionId];
  }

  static final Map<String, Map<String, dynamic>> _allowedDetailOptions = {
    GroupMemberScope.participant: {
      GroupOptionConstants.addMembers: false, //Details
      GroupOptionConstants.delete: false, //Details
      GroupOptionConstants.leave: true, //Details
      GroupOptionConstants.bannedMembers: false, //Details
      GroupOptionConstants.viewMembers: true //Details
    },
    GroupMemberScope.moderator: {
      GroupOptionConstants.addMembers: false,
      GroupOptionConstants.delete: false,
      GroupOptionConstants.leave: true,
      GroupOptionConstants.bannedMembers: true,
      GroupOptionConstants.viewMembers: true
    },
    GroupMemberScope.admin: {
      GroupOptionConstants.addMembers: true,
      GroupOptionConstants.delete: true,
      GroupOptionConstants.leave: true,
      GroupOptionConstants.bannedMembers: true,
      GroupOptionConstants.viewMembers: true
    },
    GroupMemberScope.owner: {
      GroupOptionConstants.addMembers: true,
      GroupOptionConstants.delete: true,
      GroupOptionConstants.leave: true,
      GroupOptionConstants.bannedMembers: true,
      GroupOptionConstants.viewMembers: true
    },
  };

  static final Map<String, Map<String, dynamic>> _allowedGroupMemberOptions = {
    GroupMemberScope.participant + GroupMemberScope.participant: {
      GroupMemberOptionConstants.kick: false, //GroupMembers
      GroupMemberOptionConstants.ban: false, //GroupMembers
      GroupMemberOptionConstants.unban: false, //Banned Members
      GroupMemberOptionConstants.changeScope: <String>[], //GroupMembers
    },
    GroupMemberScope.participant + GroupMemberScope.moderator: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: false,
      GroupMemberOptionConstants.changeScope: <String>[],
    },
    GroupMemberScope.participant + GroupMemberScope.admin: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: false,
      GroupMemberOptionConstants.changeScope: <String>[],
    },
    GroupMemberScope.participant + GroupMemberScope.owner: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: false,
      GroupMemberOptionConstants.changeScope: <String>[],
    },
    GroupMemberScope.moderator + GroupMemberScope.participant: {
      GroupMemberOptionConstants.kick: true,
      GroupMemberOptionConstants.ban: true,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: [
        GroupMemberScope.participant,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.moderator + GroupMemberScope.moderator: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[
        GroupMemberScope.participant,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.moderator + GroupMemberScope.admin: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[],
    },
    GroupMemberScope.moderator + GroupMemberScope.owner: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[],
    },
    GroupMemberScope.admin + GroupMemberScope.participant: {
      GroupMemberOptionConstants.kick: true,
      GroupMemberOptionConstants.ban: true,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[
        GroupMemberScope.participant,
        GroupMemberScope.admin,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.admin + GroupMemberScope.moderator: {
      GroupMemberOptionConstants.kick: true,
      GroupMemberOptionConstants.ban: true,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[
        GroupMemberScope.participant,
        GroupMemberScope.admin,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.admin + GroupMemberScope.admin: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[
        GroupMemberScope.participant,
        GroupMemberScope.admin,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.admin + GroupMemberScope.owner: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[],
    },
    GroupMemberScope.owner + GroupMemberScope.participant: {
      GroupMemberOptionConstants.kick: true,
      GroupMemberOptionConstants.ban: true,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[
        GroupMemberScope.participant,
        GroupMemberScope.admin,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.owner + GroupMemberScope.moderator: {
      GroupMemberOptionConstants.kick: true,
      GroupMemberOptionConstants.ban: true,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[
        GroupMemberScope.participant,
        GroupMemberScope.admin,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.owner + GroupMemberScope.admin: {
      GroupMemberOptionConstants.kick: true,
      GroupMemberOptionConstants.ban: true,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[
        GroupMemberScope.participant,
        GroupMemberScope.admin,
        GroupMemberScope.moderator
      ],
    },
    GroupMemberScope.owner + GroupMemberScope.owner: {
      GroupMemberOptionConstants.kick: false,
      GroupMemberOptionConstants.ban: false,
      GroupMemberOptionConstants.unban: true,
      GroupMemberOptionConstants.changeScope: <String>[],
    },
  };

  static bool validateUserOptions(User? loggedInUser, User? user, String id) {
    if (user?.uid == loggedInUser?.uid && id == UserOptionConstants.blockUser) {
      return false;
    } else if ((user?.blockedByMe == true) &&
        id == UserOptionConstants.blockUser) {
      return false;
    } else if ((user?.blockedByMe == false || user?.blockedByMe == null) &&
        id == UserOptionConstants.unblockUser) {
      return false;
    }

    return true;
  }
}
