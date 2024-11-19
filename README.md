# Fort Zancudo Project - README

## Overview

The **Fort Zancudo Project** introduces an immersive and dynamic hacking and defense system for Fort Zancudo. This script includes interactive hacking mini-games, alarms, restricted airspace defense, and functional elevators, offering an engaging experience for players. **Requires ZRULX Duty systems** to work correctly. *Contact me on Discord @ Xenty.dev For info on Zrulx Duty Systems*

## Features

### Cipher Hacking
- **Control Panel Hacks**:  
  - Interactive mini-games to disable defenses or trigger events like alarms and air defense systems.
  - Uses the `lightsout` mini-game for enhanced gameplay.
  - Cooldown system prevents repeated attempts in quick succession.
  
- **Door Hacks**:  
  - Unlock secured doors using skill checks.
  - Failure results in cooldown and system alarms.

### Restricted Airspace Defense
- **Air Defense Activation**:  
  - Enters a countdown upon unauthorized entry into restricted airspace.
  - Blasts hostile entities with explosions if they don’t leave the restricted area.
  - Automatic reset when leaving the airspace.
  
- **No-Fly Zone Blip**:  
  - Highlights restricted areas on the map.

### Elevators
- Fully functional elevators for navigating between multiple floors.
- Access restricted based on duty status.
- Includes sound effects and notifications.

### Alarms
- Interactive alarms triggered on hacking failures.
- Players can manually stop alarms if clocked in.

## Installation

1. **Dependencies**:
   - Ensure **[ZRULX Duty System](https://example-link.com)** is installed and configured.
   - Required resources: 
     - `ox_target` for interaction zones.
     - `lightsout` for mini-games.
     - `okokNotify` for notifications.

2. **Download and Add Resource**:
   - Clone or download this repository into your FiveM resources folder.
   - Name the folder `fort_zancudo` for consistency.

3. **Configuration**:
   - Adjust locations (e.g., control panel, door hacks, elevators) in the script to match your desired map layout.
   - Verify dependencies are correctly loaded in your server configuration.

4. **Start the Resource**:
   Add the following to your `server.cfg`:
   ```plaintext
   ensure fort_zancudo
   ```

## Usage

### Hacking System
- Approach designated hack locations to start a hack mini-game.
- Successful hacks grant access or disable defenses; failures may trigger alarms or cooldowns.

### Air Defense
- Players entering the restricted airspace will receive a warning.
- Continued presence triggers explosions targeting their position.

### Elevator Control
- Interact with the elevators to travel between floors.
- Requires players to be clocked into duty to use.

## Customization
- **Hack Locations**: Edit the `coords` in the hacking section.
- **Elevator Floors**: Add or modify floor coordinates in the elevator configuration.
- **Air Defense Radius**: Adjust the `dist` value in the restricted airspace defense section.

## Future Enhancements
Planned features include:
- Dynamic patrolling NPC guards.
- Advanced security clearance systems.
- Integration with additional duty systems.

## Contributing
Feel free to submit pull requests or report issues for improvements. This project is intended to grow with community feedback.

---

### License
This project is licensed under [MIT License](LICENSE).

Enjoy the immersive Fort Zancudo experience!
