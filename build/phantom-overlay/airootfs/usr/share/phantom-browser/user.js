// Phantom Browser - Firefox Preferences
// Ghost Protocol Theme Configuration

// Enable userChrome.css and userContent.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Privacy enhancements
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.resistFingerprinting", false); // Can break some sites
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.cache", false);

// Security
user_pref("browser.safebrowsing.malware.enabled", true);
user_pref("browser.safebrowsing.phishing.enabled", true);
user_pref("dom.security.https_only_mode", true);

// Performance
user_pref("browser.cache.disk.enable", true);
user_pref("browser.cache.memory.enable", true);
user_pref("browser.sessionhistory.max_entries", 10);
user_pref("browser.tabs.animate", true);

// UI Customization
user_pref("browser.uidensity", 1); // Compact mode
user_pref("browser.tabs.inTitlebar", 1);
user_pref("browser.theme.dark-private-windows", true);

// New tab page
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

// Search
user_pref("browser.search.suggest.enabled", true);
user_pref("browser.urlbar.suggest.searches", true);

// Downloads
user_pref("browser.download.useDownloadDir", true);
user_pref("browser.download.autohideButton", false);

// Phantom OS branding
user_pref("browser.startup.homepage", "about:home");
user_pref("startup.homepage_welcome_url", "about:blank");
user_pref("browser.startup.page", 1);

// Disable telemetry
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
