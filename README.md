# Only One
Made By: 1perry_ @ Brenny.zip

A simple addon to prevent the `-multirun` flag from being exploited on linked servers.

*Made for the [Atomic Networks](https://atomicnetworks.co/) DarkRP Servers*


### CHANGE LOG - V0.1.5
- Added Whitelist to bypass the check
  - Supports Usergroups, SteamIds, and Steam64 Ids
- Setup project description & Updated Change Log Format

### CHANGE LOG - V0.1.4-1
- Changed back to `GM:PlayerAuthed`
- Improved Easter Egg

### CHANGE LOG - V0.1.4
- Brought back `sv_hibernate_think` set on startup
- Checks all servers instead of all other servers
- Registers Player after checks have been made
- Added `RelogDelay` to config
  - Players cannot rejoin or switch servers until timer is up
- Disables on severe errors

### CHANGE LOG - V0.1.3
- Started using `player_connect` instead of `PlayerAuthed`
- Added check for bots
- Changed kick method

### CHANGE LOG - V0.1.2-1
- Removed `sv_hibernate_think` enabler
- Removed Delay Before SteamId Removal
- Added check if a player has already been kicked

### CHANGE LOG - V0.1.2
- Added Fancy Colors
- Set `sv_hibernate_think` to `1` on load
- Cached SteamId to fix error

### CHANGE LOG - V0.1.1
- New Startup Message
- Added SteamId Remove Delay
- Added Easter Egg ;)
