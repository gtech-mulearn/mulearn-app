import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';

/// A campaign status from the backend. An unknown or missing one reads as
/// `failed`, which never offers Send or Cancel.
CampaignStatus parseCampaignStatus(String? value) => CampaignStatus.values
    .firstWhere((s) => s.name == value, orElse: () => CampaignStatus.failed);
