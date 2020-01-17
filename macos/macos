#!bin/sh

# Ask for the administrator password upfront
sudo -v

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Dock Settings
defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock largesize -float 100
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock orientation right
defaults write com.apple.dock mineffect genie
defaults write com.apple.dock no-glass -boolean YES
defaults write com.apple.dock mouse-over-hilite-stack -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.dock autohide-immutable -bool true

# Mission Control Settings
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock workspaces-edge-delay -float 0

# Battery Settings
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# Keyboard Settings
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15;

# Launchpad Settings
defaults write com.apple.dock springboard-show-duration -int 0
defaults write com.apple.dock springboard-hide-duration -int 0

# Safari Settings
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari ShowStatusBar -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.0

# Finder Settings
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder AppleShowAllFiles NO
defaults write com.apple.finder GoToField -string /
defaults write com.apple.finder FinderSounds -bool no
defaults write -g AppleShowAllExtensions -bool true

# Quick Look Settings
defaults write com.apple.finder QLEnableTextSelection -bool true

# Trackpad Settings
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Terminal Settings
defaults write com.apple.helpviewer DevMode -bool true
defaults write com.apple.terminal StringEncodings -array 4

if [[ -e monokai.terminal ]]; then
	open ./monokai.terminal; sleep 2
	echo "Please the following command in a new terminal."
	echo '	defaults write com.apple.Terminal "Startup Window Settings" -string "monokai"'
	echo '	defaults write com.apple.Terminal "Default Window Settings" -string "monokai"'
fi

# Othre Settings
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE H:mm'
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write com.apple.screencapture location ~/Pictures
defaults write com.apple.screencapture include-date -bool false
defaults write com.apple.dock no-bouncing -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g NSWindowResizeTime 0.1
defaults write com.apple.finder AutoStopWhenSelectionChanges -bool false
defaults write com.apple.finder AutoStopWhenScrollingOffBounds -bool false
defaults write com.apple.finder QLInlinePreviewMinimumSupportedSize -int 0
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.NetworkBrowser ShowThisComputer -bool true
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.screencapture disable-shadow -bool true
sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
defaults write -g AppleLanguages -array ja
defaults write com.apple.ImageCapture disableHotPlug -bool NO
defaults write com.apple.CrashReporter DialogType none
defaults write com.apple.dashboard devmode YES
defaults write com.apple.dock itunes-notifications -bool TRUE
defaults write com.apple.iTunes high-contrast-mode-enable -bool true
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES
defaults write com.apple.dashboard mcx-disabled -boolean true
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

killall Dock
killall Dockkillall SystemUIServer
killall Dockkillall Finder
