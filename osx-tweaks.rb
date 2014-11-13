#!/usr/bin/env ruby
# http://jasahackintosh.wordpress.com/2014/09/04/tweak-os-x-from-command-terminal/
# https://gist.github.com/brandonb927/3195465
# https://gist.github.com/erikh/2260182
# https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# https://gist.github.com/brandonb927/3195465

def option(text, options = {})
  printf text
  option = gets.chomp.downcase
  if option == 'y' || options == 'yes'
    system options[:yes]
  elsif option == 'n' || option == 'no'
    system options[:no]
  else
    puts "No change made."
  end
end

puts "This script doesn't make any change without your confirmation."
puts "You'll be prompted before make any change, you choose what to do: y (Yes), n (No), enter (Skip)"
printf "Do you want to start running the script (y/n)? "

return if gets.chomp.downcase != 'y'

system 'sudo -v'
system 'while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &'

puts "**********************************************"

option  "Disable Spotlight? ",
        yes: "sudo chmod 700 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search",
        no: "sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search"

option  "Increase the window resize speed for Cocoa applications? ",
        yes: "defaults write NSGlobalDomain NSWindowResizeTime -float 0.001",
        no: "defaults delete NSGlobalDomain NSWindowResizeTime"

option  "Save to disk, rather than iCloud, by default? ",
        yes: "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud FALSE",
        no: "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud TRUE"

option  "Check for software updates daily, not just once per week? ",
        yes: "defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1",
        no: "defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 7"

option  "Disable the sudden motion sensor? (it's not useful for SSDs/current MacBooks) ",
        yes: "sudo pmset -a sms 0",
        no: "sudo pmset -a sms 1"

option  "Disable auto-correct? ",
        yes: "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled FALSE",
        no: "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled TRUE"

option  "Require password immediately after sleep or screen saver begins? ",
        yes: "defaults write com.apple.screensaver askForPassword TRUE",
        no: "defaults write com.apple.screensaver askForPasswordDelay FALSE"

option  "Enable subpixel font rendering on non-Apple LCDs? ",
        yes: "defaults write NSGlobalDomain AppleFontSmoothing -int 2",
        no: "defaults delete NSGlobalDomain AppleFontSmoothing"

option  "Enable tap to click (Trackpad)? ",
        yes: "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking TRUE",
        no: "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking FALSE"

option "Menu bar: disable transparency? ",
      yes: "defaults write NSGlobalDomain AppleEnableMenuBarTransparency FALSE",
      no: "defaults write NSGlobalDomain AppleEnableMenuBarTransparency TRUE"

option  "Time Machine: Disable local snapshots ",
        yes: "sudo tmutil disablelocal",
        no: "sudo tmutil enablelocal"

optino  "Finder: Show the ~/Library folder ",
      yes: "chflags nohidden ~/Library",
      no: "chflags hidden ~/Library"

option  "Finder: Show icons for hard drives, servers, and removable media on the desktop? ",
        yes: "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop TRUE",
        no: "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop TRUE"

option  "Finder: Show hidden files by default? ",
          yes: "defaults write com.apple.Finder AppleShowAllFiles TRUE",
          no: "defaults write com.apple.Finder AppleShowAllFiles FALSE"

option  "Finder: Show all filename extensions by default? ",
        yes: "defaults write NSGlobalDomain AppleShowAllExtensions TRUE",
        no: "defaults write NSGlobalDomain AppleShowAllExtensions FALSE"

option  "Finder: Show status bar by default? ",
        yes: "defaults write com.apple.finder ShowStatusBar TRUE",
        no: "defaults write com.apple.finder ShowStatusBar FALSE"

option  "Finder: Display full POSIX path as window title? ",
        yes: "defaults write com.apple.finder _FXShowPosixPathInTitle TRUE",
        no: "defaults write com.apple.finder _FXShowPosixPathInTitle FALSE"

option  "Finder: Disable the warning when changing a file extension? ",
        yes: "defaults write com.apple.finder FXEnableExtensionChangeWarning FALSE",
        no: "defaults write com.apple.finder FXEnableExtensionChangeWarning TRUE"

option  "Finder: Use column view in all windows by default? ",
        yes: "defaults write com.apple.finder FXPreferredViewStyle Clmv",
        no: "defaults write com.apple.finder FXPreferredViewStyle icnv"

option  "Finder: Avoid creation of .DS_Store files on network volumes? ",
        yes: "defaults write com.apple.desktopservices DSDontWriteNetworkStores TRUE",
        no: "defaults write com.apple.desktopservices DSDontWriteNetworkStores FALSE"

option  "Mission Control: speed up animations? ",
        yes: "defaults write com.apple.dock expose-animation-duration -float 0.1",
        no: "defaults delete com.apple.dock expose-animation-duration"

option  "Mission Control: group windows by application? ",
        yes: "defaults write com.apple.dock \"expose-group-by-app\" -bool true",
        no: "defaults write com.apple.dock \"expose-group-by-app\""

option  "Dock: enable auto-hide? ",
        yes: "defaults write com.apple.dock autohide TRUE",
        no: "defaults write com.apple.dock autohide FALSE"

option  "Dock: remove the auto-hiding delay? ",
        yes: "defaults write com.apple.dock autohide-delay -float 0 &&
              defaults write com.apple.dock autohide-time-modifier -float 0",
        no:  "defaults delete com.apple.dock autohide-delay &&
              defaults delete com.apple.dock autohide-time-modifier"

option  "Safari: search default to Contains instead of Starts With? ",
        yes: "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly FALSE",
        no: "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly TRUE"

option  "Safari: allow hitting the Backspace key to go to the previous page in history? ",
        yes: "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled TRUE",
        no: "defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled"

option  "Safari: show full website address? ",
        yes: "defaults write com.apple.Safari ShowFullURLInSmartSearchField TRUE",
        no: "defaults write com.apple.Safari ShowFullURLInSmartSearchField FALSE"

option  "Mail.app: setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>'? ",
        yes: "defaults write com.apple.mail AddressesIncludeNameOnPasteboard FALSE",
        no: "defaults write com.apple.mail AddressesIncludeNameOnPasteboard TRUE"


#### CLEAN UP ###
option  "Clear Out Font Caches? ",
        yes: "sudo atsutil databases -remove"

puts "**********************************************"
puts "We're done!!!"
puts "Note that some of these changes require a logout/restart to take effect."
