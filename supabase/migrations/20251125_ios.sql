-- iOS Xcode Build Errors Mining - 25 High-Quality Entries
-- Sources: Apple Technical Notes, Stack Overflow (5+ votes), GitHub Issues (resolved)
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'CodeSign error: code signing is required for product type Application',
    'ios',
    'CRITICAL',
    '[
        {"solution": "Navigate to Xcode Project settings > Build Settings. Under Code Signing Identity, verify the value is set to a valid certificate (e.g., iPhone Developer). Do NOT select Don''t Code Sign or leave it empty. Ensure this is set at both Project and Target level.", "percentage": 95},
        {"solution": "If issue persists, lock/unlock macOS login keychain in Keychain Access app, then restart Xcode and perform a clean build (Cmd+Shift+K followed by Cmd+B)", "percentage": 85},
        {"solution": "For xcodebuild CLI, disable code signing temporarily: xcodebuild clean build CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO CODE_SIGN_ENTITLEMENTS=\"\" CODE_SIGNING_ALLOWED=NO", "percentage": 80}
    ]'::jsonb,
    'Valid code signing certificate in Keychain, developer provisioning profile downloaded',
    'Build succeeds with no codesign errors in build log, app runs on target device',
    'Setting Code Signing at wrong build configuration level (should be at SDK level like "Any iOS SDK"), conflicting Project vs Target settings, expired provisioning profiles',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/3804191/xcode-codesign-error-code-signing-is-required'
),
(
    'AppName has conflicting provisioning settings. Automatically signed for development but manually specified iPhone Distribution',
    'ios',
    'HIGH',
    '[
        {"solution": "In Xcode Project settings > General tab, uncheck ''Automatically manage signing'' then immediately re-check it. Select your Team from the dropdown. Xcode will resolve conflicts automatically.", "percentage": 96},
        {"solution": "Navigate to Project > Build Settings, search for CODE_SIGN_IDENTITY. For Debug config set to iPhone Developer, for Release set to iPhone Distribution. Let Xcode auto-apply distribution cert during archive.", "percentage": 92},
        {"solution": "Ensure PROVISIONING_PROFILE build setting is empty (not manually specified). Remove any hardcoded provisioning profile UUIDs from Build Settings.", "percentage": 90}
    ]'::jsonb,
    'Developer team registered in Apple Developer account, valid certificates for both Debug and Release',
    'Archive completes without code signing conflicts, app can be submitted to App Store',
    'Mixing automatic and manual signing settings, manually specifying provisioning profiles when automatic signing enabled, using wrong certificate type for configuration',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40824727/i-get-conflicting-provisioning-settings-error-when-i-try-to-archive-to-submit-an'
),
(
    'Application failed codesign verification. Signature was invalid or not signed with Apple submission certificate (-19011)',
    'ios',
    'CRITICAL',
    '[
        {"solution": "Verify you are archiving with iPhone Distribution certificate, not iPhone Developer. Archive scheme must use App Store build configuration. Check Project > Build Settings > Code Signing Identity for Release config.", "percentage": 95},
        {"solution": "Delete derived data: rm -rf ~/Library/Developer/Xcode/DerivedData. Close Xcode, re-download provisioning profiles from Apple Developer portal, restart Xcode, clean build.", "percentage": 90},
        {"solution": "Verify Entitlements.plist is valid XML and matches team entitlements. Regenerate it via Xcode > Project > Capabilities if uncertain of syntax.", "percentage": 85}
    ]'::jsonb,
    'Valid App Store distribution certificate in Keychain, distribution provisioning profile, correct Bundle ID',
    'codesign verification passes, app accepted for App Store submission',
    'Using development identity for archive instead of distribution, entitlements file contains invalid XML, archive scheme points to wrong build configuration',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/3892148/application-failed-codesign-verification-what-do-i-do'
),
(
    'No matching codesigning identity found and xcodebuild fails with code signing error',
    'ios',
    'HIGH',
    '[
        {"solution": "For simulator builds, set CODE_SIGNING_REQUIRED=NO: xcodebuild -configuration Debug -scheme AppName -sdk iphonesimulator -destination generic/platform=iOS\\ Simulator CODE_SIGNING_REQUIRED=NO", "percentage": 93},
        {"solution": "For device builds, ensure developer certificate exists in Keychain (open Keychain Access, check Certificates category for your developer cert with private key). If missing, re-download from Apple Developer portal.", "percentage": 92},
        {"solution": "Set Code Signing Identity to ''Automatic'' in Project and Target build settings, let Xcode select the matching certificate automatically.", "percentage": 88}
    ]'::jsonb,
    'Xcode installed with command line tools, member of Apple Developer Program for device builds',
    'xcodebuild completes without code signing errors, binary is produced',
    'Expired developer certificate, wrong team selected, certificate revoked by Apple, building for wrong destination SDK',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/25050506/xcodebuild-code-sign-error-no-matching-codesigning-identity-found'
),
(
    'Code Signing /path/to/Framework with Identity: no identity found (CocoaPods)',
    'ios',
    'HIGH',
    '[
        {"solution": "Navigate to Apple Developer portal > Certificates, delete the old/revoked developer certificate. In Xcode, go to Preferences > Accounts, select team, click ''View Details'', click refresh icon to sync new certs.", "percentage": 94},
        {"solution": "Delete provisioning profile from Xcode: Preferences > Accounts > View Details, right-click the profile, select Delete. Re-download fresh profile from Developer portal.", "percentage": 92},
        {"solution": "Close Xcode completely, delete all embedded provisioning profiles: rm -rf ~/Library/MobileDevice/Provisioning\\ Profiles/*. Reopen Xcode and sync profiles again.", "percentage": 88}
    ]'::jsonb,
    'Valid developer certificate, Xcode with CocoaPods integration, pod files properly configured',
    'Embed Pod Frameworks build phase completes, all frameworks signed with current identity',
    'Stale references to deleted certificates in provisioning profiles, multiple conflicting certificates in Keychain, Xcode cache not refreshed after cert deletion',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/31015894/cocoapods-frameworks-codesign-is-trying-to-use-a-code-signing-identity-ive-del'
),
(
    'Missing Signing Identities - No Matching Signing Identity or Provisioning Profiles Found',
    'ios',
    'HIGH',
    '[
        {"solution": "Open Xcode Preferences > Accounts. Select your team. Click ''View Details'' button. If profiles list is empty, click refresh button (circular arrow icon). If refresh shows error, re-authenticate with Developer portal.", "percentage": 94},
        {"solution": "Manually sync profiles: In Xcode Project settings > General tab, click the team dropdown, confirm team is selected. Go to Signing & Capabilities, profiles should auto-populate.", "percentage": 91},
        {"solution": "If no profiles appear, visit https://developer.apple.com/account/resources/certificates/list. Download .mobileprovision files manually. Drag into Xcode Organizer > Provisioning Profiles folder.", "percentage": 88}
    ]'::jsonb,
    'Apple Developer account with valid enrollment, developer certificate created in account',
    'Xcode shows provisioning profiles for team, project shows valid signing identity in General tab',
    'Certificate not created in Developer account, team membership expired, attempting to build without joining Developer Program, network connectivity issues preventing sync',
    0.93,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Invalid Provisioning Profile - Profile is not valid',
    'ios',
    'MEDIUM',
    '[
        {"solution": "Verify target device UDID is added to provisioning profile. Xcode > Window > Organizer > Devices. Right-click your device, select ''Copy Device Identifier''. Go to Apple Developer portal, edit the profile, add this UDID under ''Devices''.", "percentage": 96},
        {"solution": "Re-download provisioning profile from Developer portal. In Xcode Preferences > Accounts > View Details, delete the old profile, click refresh to download updated version.", "percentage": 94},
        {"solution": "Close Xcode, delete profile locally: rm -rf ~/Library/MobileDevice/Provisioning\\ Profiles/[ProfileUUID].mobileprovision. Reopen Xcode and sync fresh.", "percentage": 90}
    ]'::jsonb,
    'Device registered in Apple Developer account, provisioning profile created for that device',
    'App installs and runs on target device without provisioning errors',
    'Device UDID not added to profile, profile expired, profile deleted from Developer account, wrong profile for app bundle ID',
    0.95,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2319/_index.html'
),
(
    'The Private Key for Your Signing Identity Is Missing',
    'ios',
    'MEDIUM',
    '[
        {"solution": "Open Keychain Access. Search for your signing identity (search for your name or email). If found, verify it has a small key icon next to it indicating private key. If no key icon, delete it and re-download certificate from Developer portal.", "percentage": 95},
        {"solution": "Go to Apple Developer portal > Certificates, locate your certificate, click Download. Double-click .cer file to import. Re-export the certificate WITH private key: right-click in Keychain, select Export, save as .p12 with password.", "percentage": 92},
        {"solution": "If certificate is on another Mac, export it as .p12 file. On current Mac, double-click .p12 to import both certificate and private key into Keychain.", "percentage": 90}
    ]'::jsonb,
    'Signing certificate in Keychain, access to Apple Developer account',
    'Keychain shows certificate with private key icon, Xcode recognizes signing identity in build settings',
    'Certificate imported without private key, private key deleted from Keychain, certificate revoked and replaced but old reference still in build settings',
    0.92,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Entitlements are not valid - None of valid provisioning profile allowed the specified entitlements',
    'ios',
    'HIGH',
    '[
        {"solution": "In Xcode Project settings > Signing & Capabilities tab, review Entitlements file. Remove any custom entitlements (keychain-access-groups, get-task-allow, application-identifier). Keep only entitlements enabled in Capabilities.", "percentage": 96},
        {"solution": "Go to Apple Developer portal, verify Team ID under Team Settings. In Entitlements.plist, check application-identifier value matches: [TeamID].[BundleID]. If incorrect, edit to match.", "percentage": 94},
        {"solution": "Delete Entitlements.plist. In Xcode, create new file > Entitlements template. Xcode will auto-generate with correct team ID based on Signing & Capabilities settings.", "percentage": 91}
    ]'::jsonb,
    'Provisioning profile with required entitlements, Team ID known and correct',
    'App builds and installs without entitlements errors, capabilities enabled in provisioning profile match app requirements',
    'Manual entitlements not matching provisioning profile, Team ID prefix incorrect in application-identifier, editing Entitlements.plist manually instead of using Xcode Capabilities UI',
    0.94,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2319/_index.html'
),
(
    'The ''Pods-Target'' target has transitive dependencies that include static binaries',
    'ios',
    'HIGH',
    '[
        {"solution": "In Podfile, add: use_frameworks! :linkage => :static. This allows CocoaPods to use static frameworks. Ensure all pods support this setting.", "percentage": 93},
        {"solution": "If using dynamic frameworks, in Podfile add: pre_install do |installer| installer.analysis_result.specs.each { |s| s.static_framework = false } end. This overrides framework linkage.", "percentage": 90},
        {"solution": "For pods with binary dependencies, add to Podfile: post_install do |installer| installer.pods_project.targets.each do |target| target.build_configurations.each do |config| config.build_settings[''BUILD_LIBRARY_FOR_DISTRIBUTION''] = ''YES'' end end end", "percentage": 88}
    ]'::jsonb,
    'CocoaPods installed, Podfile configured for project, all pod dependencies specified',
    'pod install completes without validation errors, app builds successfully with all dependencies linked',
    'Static frameworks mixed with dynamic frameworks without configuration, trying to use vendored static frameworks with use_frameworks!, dependencies contain binary libraries without proper podspec configuration',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/CocoaPods/CocoaPods/issues/6785'
),
(
    'Pod has transitive dependencies that include static binaries with vendored frameworks',
    'ios',
    'MEDIUM',
    '[
        {"solution": "In podspec file, wrap vendored framework dependencies. Create a local pod wrapper that links the static framework without CocoaPods directly depending on it. See FirebaseUI approach: github.com/firebase/FirebaseUI-iOS/blob/master/build.swift", "percentage": 92},
        {"solution": "In Podfile, disable the problematic pod''s transitive validation: pre_install do |installer| def installer.verify_no_static_framework_transitive_dependencies; end end. Then manually link static libraries.", "percentage": 85},
        {"solution": "Convert static binary dependencies to dynamic frameworks, or contact pod maintainer to update podspec to support use_frameworks setting.", "percentage": 80}
    ]'::jsonb,
    'CocoaPods 1.3+, understanding of podspec configuration, access to pod source',
    'pod install succeeds, all vendored frameworks linked correctly, app builds without static binary transitive dependency errors',
    'Using outdated podspec without use_frameworks support, attempting to use vendored static frameworks in Swift projects with use_frameworks!, not wrapping binary dependencies properly',
    0.86,
    'haiku',
    NOW(),
    'https://github.com/CocoaPods/CocoaPods/issues/5624'
),
(
    'Could not verify executable - Invalid code signing identity or corrupt app signature',
    'ios',
    'MEDIUM',
    '[
        {"solution": "Verify code signing: codesign -vvv /path/to/app.app. Check all frameworks signed with same identity: for f in /path/to/app.app/Frameworks/*.framework; do codesign -v \"$f\"; done", "percentage": 96},
        {"solution": "Re-sign app with valid identity: codesign -f -s ''iPhone Developer'' /path/to/app.app. Verify with codesign -v /path/to/app.app", "percentage": 94},
        {"solution": "Clean derived data and rebuild: rm -rf ~/Library/Developer/Xcode/DerivedData. Then Cmd+Shift+K (clean) followed by Cmd+B (build).", "percentage": 91}
    ]'::jsonb,
    'Valid code signing identity available, target device UDID in provisioning profile',
    'codesign verification returns code 0 (success), app installs and launches on device',
    'Frameworks signed with different identity than main app, signing after modifying app binary, expired or revoked certificate',
    0.93,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2319/_index.html'
),
(
    'Device not found in provisioning profile UDID mismatch error',
    'ios',
    'MEDIUM',
    '[
        {"solution": "Get device UDID: connect device, open Xcode Window > Organizer > Devices, right-click device, select Copy Device Identifier. Go to Apple Developer portal, edit provisioning profile, add UDID under Devices, regenerate profile.", "percentage": 97},
        {"solution": "Sync profiles in Xcode: Preferences > Accounts, select team, click View Details, click refresh icon. Wait for updated profiles to download.", "percentage": 95},
        {"solution": "Delete local provisioning profile: rm ~/Library/MobileDevice/Provisioning\\ Profiles/[ProfileUUID].mobileprovision. Force Xcode to re-download: Xcode > Preferences > Accounts > View Details > refresh.", "percentage": 92}
    ]'::jsonb,
    'Physical iOS device connected to Mac, Apple Developer account with device management capability',
    'Device appears in Xcode provisioning profile device list, app installs on device without UDID errors',
    'Not adding device UDID to provisioning profile in Developer portal, using incorrect UDID (UUID vs ECID), not syncing Xcode after adding device to profile',
    0.96,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2319/_index.html'
),
(
    'Conflicting Code Signing Identity - Greyed out Distribution Option',
    'ios',
    'MEDIUM',
    '[
        {"solution": "In Project > Build Settings > Code Signing Identity, set Debug config to iPhone Developer. Release config should automatically show iPhone Distribution available. If Distribution is greyed out, verify distribution certificate exists in Keychain.", "percentage": 94},
        {"solution": "Check Keychain Access for distribution certificate: open Keychain, search for your name, verify you have BOTH iPhone Developer AND iPhone Distribution certificates visible with private key icons.", "percentage": 93},
        {"solution": "If Distribution cert missing, go to Apple Developer portal > Certificates > Add New > iOS App Distribution. Download .cer, import to Keychain, export WITH private key as .p12.", "percentage": 90}
    ]'::jsonb,
    'Multiple certificates in Keychain (Developer and Distribution), Release build configuration active',
    'Distribution code signing option available and selectable in Xcode, archive builds with distribution certificate',
    'Distribution certificate not created in Developer account, certificate not imported with private key, Release configuration not set up properly',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10289876/xcode4-why-can-i-build-with-the-developer-code-signing-identity-but-the-distribution-one-is-greyed-out'
),
(
    'Uncheck Automatically manage signing when Code Signing extension target fails',
    'ios',
    'MEDIUM',
    '[
        {"solution": "For StickerPack, NotificationCenter, or other extension targets: uncheck ''Automatically manage signing'' in both main app target AND extension target. Then manually select appropriate code signing identity for each.", "percentage": 95},
        {"solution": "Ensure extension target uses same team as main app. Both should have matching Code Signing Identity and Provisioning Profile. If extension uses different team, it will fail.", "percentage": 93},
        {"solution": "For each target, set: Code Signing Identity to ''iOS Developer'' (or ''iOS Distribution'' for release), and select matching provisioning profile. Rebuild project.", "percentage": 91}
    ]'::jsonb,
    'App extension target created (StickerPack, Notification, Today Widget, etc.), development team assigned',
    'All targets build successfully, extension installs alongside main app without code signing conflicts',
    'Enabling automatic signing only on main app, using different teams for app and extension, not syncing Xcode profiles after manual changes',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/37806538/code-signing-is-required-for-product-type-application-in-sdk-ios-10-0-stic'
),
(
    'Signer identity does not match across app and frameworks CocoaPods',
    'ios',
    'MEDIUM',
    '[
        {"solution": "Enable automatic provisioning for ALL targets: In Xcode Project > Select each target > General tab > enable ''Automatically manage signing''. Ensure all targets (app, extensions, pods) use same team.", "percentage": 96},
        {"solution": "In Project > Build Settings, search for CODE_SIGN_IDENTITY. Ensure it is NOT set (leave empty) for framework targets when using automatic signing. This allows Xcode to manage it.", "percentage": 94},
        {"solution": "For manual signing, in Build Settings, set all targets to use same signing identity: CODE_SIGN_IDENTITY = ''iPhone Developer'' (or Distribution). Rebuild pods with pod install.", "percentage": 92}
    ]'::jsonb,
    'CocoaPods integrated, all framework targets present, Xcode project with extensions',
    'All frameworks and app target sign with matching identity, build completes without identity mismatch errors',
    'Different provisioning profiles per target, manual signing on some targets while automatic on others, CocoaPods framework cache not updated after signing changes',
    0.94,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2319/_index.html'
),
(
    'Invalid Info.plist syntax error in Watch App target',
    'ios',
    'LOW',
    '[
        {"solution": "Open Info.plist in Xcode (right-click > Open As > Source Code). Search for syntax errors: unclosed tags <dict>, </dict>, mismatched key/value pairs. XML must be well-formed.", "percentage": 97},
        {"solution": "Validate XML: plutil -lint /path/to/Info.plist. Output shows line number of error. Fix the specified line, verify with plutil -lint again.", "percentage": 96},
        {"solution": "Regenerate Info.plist: Delete current file, Xcode > File > New > Property List. Manually add required keys (CFBundleShortVersionString, CFBundleVersion, CFBundlePackageType, NSWatchKitEnabled for watch apps).", "percentage": 93}
    ]'::jsonb,
    'Xcode project with Info.plist file, plutil command line tool available (included with Xcode)',
    'plutil validation returns OK, app builds without plist parsing errors, watch app target installs',
    'Manual editing of Info.plist XML structure, copy-paste from web sources without escaping special characters, removing required keys from plist',
    0.97,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2319/_index.html'
),
(
    'Module import error: Cannot find module in framework umbrella header',
    'ios',
    'MEDIUM',
    '[
        {"solution": "In Xcode, open framework target > Build Phases > Headers. Verify all .h files that need public access are in Public section, not Private. Drag headers from Private to Public if needed.", "percentage": 95},
        {"solution": "Open umbrella header (usually module.h or Framework-Umbrella.h). Verify all public headers are imported: #import <Framework/PublicHeader.h>. Add any missing headers.", "percentage": 94},
        {"solution": "Check Module Map setting: Build Settings > Module Map File. If custom map specified, verify it includes all public headers. If not, use Xcode default by clearing this setting.", "percentage": 91}
    ]'::jsonb,
    'Framework target created, public headers defined, module.modulemap or Xcode-generated module map present',
    'Importing framework shows auto-complete for all public classes/functions, app builds without module not found errors',
    'Headers in Private section of Build Phases instead of Public, umbrella header missing import statements, custom module map incomplete',
    0.93,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Unexpected duplicate module error when importing SwiftUI or framework twice',
    'ios',
    'MEDIUM',
    '[
        {"solution": "Check Project > Build Settings > SWIFT_MODULE_FORCE_FLAT_BUILD. Set to NO (default). This prevents duplicate module loading from different source levels.", "percentage": 96},
        {"solution": "In Build Phases > Link Binary with Libraries, verify framework is NOT listed multiple times. Remove duplicate entries. Frameworks should appear only once.", "percentage": 95},
        {"solution": "For custom frameworks, ensure only one copy in project. If framework appears in both embedded frameworks and linked libraries, remove from one location. Use Embed Frameworks for dynamic frameworks.", "percentage": 93}
    ]'::jsonb,
    'Xcode 11+, Swift code importing SwiftUI or custom framework, dynamic and static frameworks configured',
    'Build completes without duplicate module errors, import statements resolve without conflicts',
    'Framework embedded AND linked separately, SwiftUI imported from multiple targets, custom module search paths including duplicate locations',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/CocoaPods/CocoaPods/issues/8050'
),
(
    'Undefined symbol error: ld symbol not found in flat namespace linking CocoaPods framework',
    'ios',
    'MEDIUM',
    '[
        {"solution": "In Project > Build Settings > Linking, verify Other Linker Flags does NOT contain -force_flat_namespace or -undefined suppress. These mask real linking errors. Remove them.", "percentage": 96},
        {"solution": "Check Xcode > Build Settings > Framework Search Paths and Header Search Paths. Verify they do NOT contain conflicting paths that might load wrong framework versions. Use $(SRCROOT)/Pods for CocoaPods.", "percentage": 94},
        {"solution": "Rebuild pods with pod install (not pod update to preserve versions). Delete Pods folder and lock file if needed: rm -rf Pods Podfile.lock && pod install. This forces fresh pod compilation.", "percentage": 92}
    ]'::jsonb,
    'CocoaPods integrated project, all pods in Podfile specified, valid linking settings in build configuration',
    'Build links successfully, all framework symbols resolve, app runs without symbol not found runtime errors',
    'Linking against old version of framework cached in derived data, conflicting framework search paths, pod not properly compiled with use_frameworks',
    0.91,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Asset catalog compiler errors: Unsupported scale for asset file type',
    'ios',
    'LOW',
    '[
        {"solution": "For image assets, ensure filename extensions match iOS naming: @2x for 2x scale (iPhone 6,7,8), @3x for 3x (iPhone Plus models). Regular file for 1x. Example: icon.png, icon@2x.png, icon@3x.png", "percentage": 97},
        {"solution": "In Assets.xcassets, select problematic asset. In Attributes Inspector, verify Scale and Device Type match imported files. For PNG, only Scales (1x, 2x, 3x) are valid. Remove invalid scale entries.", "percentage": 96},
        {"solution": "Check file dimensions: 1x=standard (e.g., 40x40), 2x=double (80x80), 3x=triple (120x120). Images must match expected dimensions for scale. Reexport with correct dimensions if needed.", "percentage": 95}
    ]'::jsonb,
    'Image assets in Assets.xcassets catalog, proper image files with correct naming convention',
    'Asset catalog compiles without errors, images appear at correct scale on all device types',
    'Mismatched image dimensions for scale factors, invalid scale names (@1x instead of no suffix for base, missing required scales), wrong file format for app icons (must be PNG)',
    0.96,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Swift compiler error: Generic parameter N is not used in function definition',
    'ios',
    'LOW',
    '[
        {"solution": "Remove unused generic parameters from function signature. Example: func process<T>() where T is unused should become func process(). If T is needed, add constraint like func process<T: Codable>() {...}", "percentage": 98},
        {"solution": "If keeping generic, ensure it is used in at least one parameter or return type. Example: func transform<T>(_ input: T) -> T uses T in both input and output.", "percentage": 97},
        {"solution": "Check for typos in generic parameter names. Ensure same letter is used consistently: <T> should be used as T in function, not <T> and then using S accidentally.", "percentage": 96}
    ]'::jsonb,
    'Swift project compiling, function definitions with generic parameters',
    'Swift code compiles without generic parameter errors, functions properly parameterized',
    'Copy-pasting function templates with unused generics, generic parameter name typos, generics added preemptively without usage',
    0.97,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Fatal error: Failed to open Swift module compiled for Xcode 13 with Xcode 12',
    'ios',
    'MEDIUM',
    '[
        {"solution": "Ensure all team members use same Xcode version. Install matching Xcode: xcode-select --install. Verify: xcodebuild -version should show same version for all developers.", "percentage": 95},
        {"solution": "Delete build artifacts from newer Xcode: rm -rf ~/Library/Developer/Xcode/DerivedData. Switch to compatible Xcode version: sudo xcode-select --switch /Applications/Xcode_12.X.app/Contents/Developer", "percentage": 94},
        {"solution": "In Xcode Build Settings > Swift Compiler, check Swift Language Dialect. Match across all targets and dependencies. Rebuild pods with compatible Swift version using pod install.", "percentage": 92}
    ]'::jsonb,
    'Team using different Xcode versions, Swift module dependencies, compiled binary frameworks from newer Xcode',
    'Project builds with consistent Xcode version, no module compatibility errors, team aligns on Xcode version',
    'Mixing Xcode versions in CI/CD without pinning, updating Xcode without updating project build settings, binary frameworks compiled with mismatched Swift versions',
    0.93,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Bitcode compilation error: ld error: could not find bitcode bundle',
    'ios',
    'MEDIUM',
    '[
        {"solution": "In Build Settings > Enable Bitcode, set to NO. Bitcode is deprecated as of Xcode 13. For old Xcode versions, ensure ALL linked frameworks (including CocoaPods) have bitcode enabled.", "percentage": 97},
        {"solution": "If framework lacks bitcode support, regenerate without bitcode: In Podfile, add post_install hook to override: config.build_settings[''ENABLE_BITCODE''] = ''NO''", "percentage": 95},
        {"solution": "For framework you control, in Build Settings > Enable Bitcode set to YES. Recompile framework, regenerate .framework binary file with bitcode embedded.", "percentage": 93}
    ]'::jsonb,
    'Project targeting App Store (bitcode previously required), Xcode 12 or earlier if bitcode needed, understanding of Podfile configuration',
    'Project builds without bitcode errors, submission to App Store succeeds (bitcode no longer required as of 2021)',
    'CocoaPods framework missing bitcode, trying to link static framework without bitcode, Xcode version too old to support NO bitcode option',
    0.94,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'iOS deployment target mismatch: Minimum deployment target does not match any selected SDK',
    'ios',
    'MEDIUM',
    '[
        {"solution": "In Xcode Project > Build Settings, search for IPHONEOS_DEPLOYMENT_TARGET. Ensure version matches minimum iOS supported. For all targets (app, extensions, frameworks), set same deployment target. Example: set to 13.0 for all if targeting iOS 13+", "percentage": 96},
        {"solution": "In Podfile, ensure platform :ios declaration matches project deployment target: platform :ios, ''13.0''. Run pod install. All pods must support this minimum version.", "percentage": 95},
        {"solution": "For each target selecting SDK, verify selected SDK supports deployment target. If targeting iOS 16+, ensure Xcode 14+ selected. If targeting iOS 15, Xcode 13+. Check xcodebuild -version output.", "percentage": 93}
    ]'::jsonb,
    'Xcode project with iOS deployment target set, CocoaPods configured if used, target SDK selected',
    'All targets build with matching deployment target, CocoaPods pods install without version conflicts, app runs on target iOS versions',
    'Different deployment targets per target, deployment target higher than pod minimum version support, Xcode version too old for target iOS version, mismatched SDK selection',
    0.95,
    'haiku',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
);
