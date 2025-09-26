CREATE TABLE Members (
  MemberID INT PRIMARY KEY AUTO_INCREMENT,
  Username VARCHAR(255),
  Email VARCHAR(255),
  PasswordHash VARCHAR(255),
  Gender VARCHAR(50),
  Birthdate DATE,
  RelationshipStatus VARCHAR(255),
  SexualOrientation VARCHAR(50),
  LocationRegion VARCHAR(100),
  LocationCity VARCHAR(100),
  JoinDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
  
CREATE TABLE Profiles (
  ProfileID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  Bio TEXT,
  ProfilePictureURL VARCHAR(255),
  LookingFor VARCHAR(50),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );
  
CREATE TABLE Interests (
  InterestID INT PRIMARY KEY AUTO_INCREMENT,
  InterestsName VARCHAR(50)
  );
  
CREATE TABLE MemberInterests (
  MemberID INT,
  InterestID INT,
  PRIMARY KEY (MemberID, InterestID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (InterestID) REFERENCES Interests(InterestID),
  );

CREATE TABLE Matches (
  MatchID INT PRIMARY KEY AUTO_INCREMENT,
  MemberA INT,
  MemberB INT,
  MatchDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberA) REFERENCES Members(MemberID),
  FOREIGN KEY (MemberB) REFERENCES Members(MemberID)
  );

CREATE TABLE Messages (
  MessageID INT PRIMARY KEY AUTO_INCREMENT,
  SenderID INT,
  ReceiverID INT,
  MessageText TEXT,
  SentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (SenderID) REFERENCES Members(MemberID),
  FOREIGN KEY (ReceiverID) REFERENCES Members(MemberID)
  );

CREATE TABLE Likes (
  LikeID INT PRIMARY KEY AUTO_INCREMENT,
  LikerID INT,
  LikedID INT,
  LikedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (LikerID) REFERENCES Members(MemberID),
  FOREIGN KEY (LikedID) REFERENCES Members(MemberID)
  );

CREATE TABLE Blocks (
  BlockID INT PRIMARY KEY AUTO_INCREMENT,
  BlockerID INT,
  BlockedID INT,
  BlockedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (BlockerID) REFERENCES Members(MemberID),
  FOREIGN KEY (BlockedID) REFERENCES Members(MemberID)
  );


CREATE TABLE Admins (
  AdminID INT PRIMARY KEY AUTO_INCREMENT,
  Username VARCHAR(255),
  Email VARCHAR(255),
  PasswordHash VARCHAR(255),
  Role VARCHAR(50),
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

CREATE TABLE Reports (
  ReportID INT PRIMARY KEY AUTO_INCREMENT,
  ReporterID INT,
  ReportedID INT,
  Reason TEXT,
  ReportedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ReporterID) REFERENCES Members(MemberID),
  FOREIGN KEY (ReportedID) REFERENCES Members(MemberID)
  );

CREATE TABLE Subscriptions (
  SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  SubscriptionType VARCHAR(50),
  StartDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  EndDate TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Notifications (
  NotificationID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  NotificationText TEXT,
  IsRead BOOLEAN DEFAULT FALSE,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE ActivityLogs (
  LogID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  ActivityType VARCHAR(50),
  ActivityDetails TEXT,
  ActivityAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Photos (
  PhotoID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  PhotoURL VARCHAR(255),
  UploadedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Events (
  EventID INT PRIMARY KEY AUTO_INCREMENT,
  EventName VARCHAR(255),
  EventDate TIMESTAMP,
  Location VARCHAR(255),
  Description TEXT
  );

CREATE TABLE EventParticipants (
  EventID INT,
  MemberID INT,
  PRIMARY KEY (EventID, MemberID),
  FOREIGN KEY (EventID) REFERENCES Events(EventID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Feedback (
  FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  FeedbackText TEXT,
  SubmittedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Settings (
  SettingID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  SettingName VARCHAR(50),
  SettingValue VARCHAR(255),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE PremiumFeatures (
  FeatureID INT PRIMARY KEY AUTO_INCREMENT,
  FeatureName VARCHAR(100),
  Description TEXT,
  Price DECIMAL(10, 2)
  );

CREATE TABLE MemberFeatures (
  MemberID INT,
  FeatureID INT,
  ActivatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MemberID, FeatureID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (FeatureID) REFERENCES PremiumFeatures(FeatureID)
  );

CREATE TABLE ChatRooms (
  ChatRoomID INT PRIMARY KEY AUTO_INCREMENT,
  RoomName VARCHAR(255),
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

CREATE TABLE ChatRoomMembers (
  ChatRoomID INT,
  MemberID INT,
  PRIMARY KEY (ChatRoomID, MemberID),
  FOREIGN KEY (ChatRoomID) REFERENCES ChatRooms(ChatRoomID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE ChatMessages (
  ChatMessageID INT PRIMARY KEY AUTO_INCREMENT,
  ChatRoomID INT,
  SenderID INT,
  MessageText TEXT,
  SentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ChatRoomID) REFERENCES ChatRooms(ChatRoomID),
  FOREIGN KEY (SenderID) REFERENCES Members(MemberID)
  );

CREATE TABLE LocationHistory (
  HistoryID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  Latitude DECIMAL(9,6),
  Longitude DECIMAL(9,6),
  RecordedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE TwoFactorAuth (
  AuthID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  AuthMethod VARCHAR(50),
  IsEnabled BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE PasswordResets (
  ResetID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  ResetToken VARCHAR(255),
  ExpiresAt TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE EmailVerifications (
  VerificationID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  VerificationToken VARCHAR(255),
  IsVerified BOOLEAN DEFAULT FALSE,
  SentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE APIKeys (
  APIKeyID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  APIKey VARCHAR(255),
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Sessions (
  SessionID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  SessionToken VARCHAR(255),
  ExpiresAt TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE DeviceLogs (
  DeviceLogID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  DeviceInfo TEXT,
  LoginAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Surveys (
  SurveyID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  SurveyData TEXT,
  SubmittedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE Friendships (
  FriendshipID INT PRIMARY KEY AUTO_INCREMENT,
  MemberA INT,
  MemberB INT,
  FriendsSince TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberA) REFERENCES Members(MemberID),
  FOREIGN KEY (MemberB) REFERENCES Members(MemberID)
  );

CREATE TABLE FriendRequests (
  RequestID INT PRIMARY KEY AUTO_INCREMENT,
  SenderID INT,
  ReceiverID INT,
  RequestDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  Status VARCHAR(50) DEFAULT 'Pending',
  FOREIGN KEY (SenderID) REFERENCES Members(MemberID),
  FOREIGN KEY (ReceiverID) REFERENCES Members(MemberID)
  );

CREATE TABLE Announcements (
  AnnouncementID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(255),
  Message TEXT,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

CREATE TABLE Tags (
  TagID INT PRIMARY KEY AUTO_INCREMENT,
  TagName VARCHAR(50)
  );

CREATE TABLE MemberTags (
  MemberID INT,
  TagID INT,
  PRIMARY KEY (MemberID, TagID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (TagID) REFERENCES Tags(TagID)
  );

CREATE TABLE VirtualGifts (
  GiftID INT PRIMARY KEY AUTO_INCREMENT,
  GiftName VARCHAR(100),
  Description TEXT,
  Price DECIMAL(10, 2)
  );

CREATE TABLE MemberGifts (
  SenderID INT,
  ReceiverID INT,
  GiftID INT,
  SentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (SenderID, ReceiverID, GiftID, SentAt),
  FOREIGN KEY (SenderID) REFERENCES Members(MemberID),
  FOREIGN KEY (ReceiverID) REFERENCES Members(MemberID),
  FOREIGN KEY (GiftID) REFERENCES VirtualGifts(GiftID)
  );

CREATE TABLE MatchPreferences (
  PreferenceID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  AgeRange VARCHAR(50),
  DistanceRange INT,
  PreferredGenders VARCHAR(100),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE SavedProfiles (
  MemberID INT,
  SavedMemberID INT,
  SavedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MemberID, SavedMemberID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (SavedMemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE ProfileViews (
  ViewerID INT,
  ViewedID INT,
  ViewedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ViewerID, ViewedID, ViewedAt),
  FOREIGN KEY (ViewerID) REFERENCES Members(MemberID),
  FOREIGN KEY (ViewedID) REFERENCES Members(MemberID)
  );

CREATE TABLE LocationPreferences (
  PreferenceID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  PreferredRegions VARCHAR(255),
  PreferredCities VARCHAR(255),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE ActivityStatus (
  StatusID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  IsOnline BOOLEAN DEFAULT FALSE,
  LastActive TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE UserRoles (
  RoleID INT PRIMARY KEY AUTO_INCREMENT,
  RoleName VARCHAR(50),
  Description TEXT
  );

CREATE TABLE MemberRoles (
  MemberID INT,
  RoleID INT,
  AssignedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MemberID, RoleID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (RoleID) REFERENCES UserRoles(RoleID)
  );

CREATE TABLE ContentModeration (
  ModerationID INT PRIMARY KEY AUTO_INCREMENT,
  ContentType VARCHAR(50),
  ContentID INT,
  Status VARCHAR(50) DEFAULT 'Pending',
  ReviewedAt TIMESTAMP,
  ReviewedBy INT,
  FOREIGN KEY (ReviewedBy) REFERENCES Admins(AdminID)
  );

CREATE TABLE DataExports (
  ExportID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  ExportData TEXT,
  RequestedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE LegalAgreements (
  AgreementID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  AgreementType VARCHAR(50),
  AgreedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE SystemSettings (
  SettingID INT PRIMARY KEY AUTO_INCREMENT,
  SettingName VARCHAR(50),
  SettingValue VARCHAR(255)
  );

CREATE TABLE MaintenanceLogs (
  LogID INT PRIMARY KEY AUTO_INCREMENT,
  AdminID INT,
  ActionType VARCHAR(50),
  ActionDetails TEXT,
  ActionAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (AdminID) REFERENCES Admins(AdminID)
  );

CREATE TABLE FeatureRequests (
  RequestID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  RequestText TEXT,
  SubmittedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE BugReports (
  BugID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  BugDescription TEXT,
  ReportedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE APIUsageLogs (
  LogID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  Endpoint VARCHAR(255),
  UsageAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE DataBackups (
  BackupID INT PRIMARY KEY AUTO_INCREMENT,
  BackupDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  BackupDetails TEXT
  );

CREATE TABLE AuditLogs (
  AuditID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  ActionType VARCHAR(50),
  ActionDetails TEXT,
  ActionAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE BankID (
  BankIDID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  BankIDToken VARCHAR(255),
  IssuedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ExpiresAt TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE TwoFactorAuthMethods (
  MethodID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  MethodType VARCHAR(50),
  IsActive BOOLEAN DEFAULT FALSE,
  AddedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE LoginAttempts (
  AttemptID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  AttemptedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  IsSuccessful BOOLEAN,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE SessionHistory (
  HistoryID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  SessionToken VARCHAR(255),
  LoginAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  LogoutAt TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE EmailPreferences (
  PreferenceID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  PreferenceType VARCHAR(50),
  IsSubscribed BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE SMSPreferences (
  PreferenceID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  PreferenceType VARCHAR(50),
  IsSubscribed BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE PushNotifications (
  PreferenceID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  PreferenceType VARCHAR(50),
  IsSubscribed BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE DataRetentionPolicies (
  PolicyID INT PRIMARY KEY AUTO_INCREMENT,
  PolicyName VARCHAR(100),
  Description TEXT,
  RetentionPeriod INT
  );

CREATE TABLE MemberDataRetention (
  MemberID INT,
  PolicyID INT,
  AppliedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MemberID, PolicyID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (PolicyID) REFERENCES DataRetentionPolicies(PolicyID)
  );

CREATE TABLE GDPRRequests (
  RequestID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  RequestType VARCHAR(50),
  RequestDetails TEXT,
  RequestedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE DataProcessingAgreements (
  AgreementID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  AgreementText TEXT,
  AgreedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE DataBreachLogs (
  BreachID INT PRIMARY KEY AUTO_INCREMENT,
  AffectedMemberID INT,
  BreachDetails TEXT,
  ReportedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (AffectedMemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE EncryptionKeys (
  KeyID INT PRIMARY KEY AUTO_INCREMENT,
  KeyType VARCHAR(50),
  KeyValue TEXT,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

CREATE TABLE DataAnonymizationLogs (
  LogID INT PRIMARY KEY AUTO_INCREMENT,
  MemberID INT,
  AnonymizationDetails TEXT,
  AnonymizedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
  );

CREATE TABLE ComplianceAudits (
  AuditID INT PRIMARY KEY AUTO_INCREMENT,
  ConductedBy VARCHAR(100),
  AuditDetails TEXT,
  ConductedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

CREATE TABLE ThirdPartyIntegrations (
  IntegrationID INT PRIMARY KEY AUTO_INCREMENT,
  IntegrationName VARCHAR(100),
  IntegrationDetails TEXT,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

CREATE TABLE MemberIntegrations (
  MemberID INT,
  IntegrationID INT,
  ConnectedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MemberID, IntegrationID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (IntegrationID) REFERENCES ThirdPartyIntegrations(IntegrationID)
  );
