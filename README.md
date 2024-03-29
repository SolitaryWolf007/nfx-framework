# nfx-framework [discontinued]
FiveM nFX Framework (Roleplay)

![logo](https://user-images.githubusercontent.com/67601962/109988166-08fc3200-7ce6-11eb-9a01-1f5532706af9.png)
* https://solitarywolf007.github.io/nfx-framework/

## Installation:
  1) Create a clean installation of FX Server. ([FiveM Docs](https://docs.fivem.net/docs/server-manual/setting-up-a-server/)) (Template Coming Soon)
  2) Leave only the `sessionmanager` and `chat` resources in your resources folder.
  3) [Download](https://github.com/GHMatti/ghmattimysql/releases/tag/1.3.2), Install and Configure GHMattiMySQL. And remember to set the database to `nfx`.
  4) [Download](https://github.com/SolitaryWolf007/nfx-framework), nFX files. And extract them to the resources folder.
  5) Configure your server.cfg, here is an example:
  ```cfg
      #--====================================================================================
      #-- RESOURCES
      #--====================================================================================

      #--==========================================
      #-- Default
      #--==========================================
      
      ensure sessionmanager
      ensure chat

      #--==========================================
      #-- nFX
      #--==========================================

      ensure ghmattimysql
      ensure nfx
      ensure nfx_admin
      ensure nfx_jobs
      ensure nfx_nui
      ensure nfx_status
  ```
  6) Open the `nfx/nfx.sql` file in your database, and run it.
  7) Basic installation complete! Browse the `config` folders for additional settings!


## Features:

  * Player identification through license.
  * Whitelist system.
  * Temporary or Permanent Banning System.
  * Access Level System, for administrative functions.
  * Simple clothing store integrated.
  * Player Groups (Police, EMS, Mechanics), with level, and salary values.
  * Prompts & Requests to use in developing scripts that need confirmation, and input by the user.
  * Inventory system, items with weights, index and types.
  * System to save the player's status, health, armor, weapons, weapon customization, position (with heading) and clothes.
  * Monetary System.
  * Identity System, First Name, Last Name, Age, Registration, Telephone.
  * Custom Data Saving System.
  * Vehicle Database, Trunk Size, Hashes, Models, Names, Classes, Manufacturers and Prices.

## Commands:
  ### Basic
  * `exit` - Recommended way to disconnect from the server, save everything and then quit the game.
  ### Admin
  * `wl [id]` - Open the dialog box, paste the player's license to add the whitelist.
  * `unwl [id]`- Open the dialog box, paste the player's license to remove from the whitelist.
  
  * `ban [id]` - If the [source] is not passed, open a dialog box asking for the player's license, and then the time in hours of banning:
    - `-1` - Permanent Ban.
    - `0`  - Remove Ban.
    - `1`  - Banning time in hours, number greater than or equal to 1.
    
  * `nc` - Toggle NoClip.
  * `money [value]` - Gives the specified [value] of money to the player.
  * `tpway` - Teleport to the waypoint.
  * `tpcds` - Open the dialog box to paste the coordinates, separated by `,`.
  * `tptome [id]` - Teleport [source] to you.
  * `tpto [id][id]` - Teleport you to [source].
  * `setgroup [id] [group] [level]` - Set the player passed by [source] in [group] and [level].
  * `remgroup [id] [group]` - Removes the player passed by [source] from [group].
  * `vclothes` - Displays the player's fitted clothes.
  * `weapon [name]` - Gives the weapon[name] to the player.
  * `cds`, `cds2`, `cds3`, `cds4` and `cds5` - Opens the dialog box and displays the formatted coordinates.
  * `pon` - Shows players online.
  * `kick [id]` - Open the dialog box, to inform the reason for the kick, after confirming, the player is kicked.
  * `kickall` - Open the dialog box, to inform the reason for the kick, after confirming, all players are kicked.
  * `god [id]` - Revive the player[source].
  * `godall` - Revive all players online.
  * `car [model]` - Spawn the vehicle[model].
  * `tuning` - Tuning the current or nearby vehicle.
  * `vhash` - Shows the hash of the current or nearby vehicle.
  * `vinfo` - Shows details of the current or nearby vehicle.
  * `dv` - Deletes the current or nearby vehicle.
  * `fix`- Repair the current or nearby vehicle.
  * `heading` - Shows the player's heading.
  * `item [nameid] [amount]` - Give the item to the player.
  * `changename [id]` - Opens a dialog box to change the player's[source] name.
  ### Jobs
  * `vtuning` - Shows the level of tuning of the vehicle. (Mechanic Group)
  * `toogle [group]` - Enter/Exit Service, indicating the [group].
  * `tbusy [group]` - Enter/Exit Busy Mode, indicating the group.
  * `call [name]` - Calls the groups specified in the settings by [name].
  * `preset [name]` - Sets the player's clothing through a preset.
  * `revive` - Revive the next player.
  * `treatment` - Apply treatment to the next player.
  * `repair` - Repair the next vehicle.
  * `cone [del?]` - Adds a cone to the map. If the [del?] Argument is "del", delete the next cone.
  * `barrier [del?]` - Adds a barrier to the map. If the [del?] Argument is "del", delete the next barrier.
  * `prison [id]` - Opens the dialog box to enter the prison time in minutes.
  * `pv` - Place the next player in the next vehicle.
  * `rv` - Remove the player from the nearby vehicle.
  * `reg [id]` - Displays the record of the next player, or the player passed in [source].

  ### Weather
  * `weather [WEATHER]` - Changes the server's climate to the one indicated.
  * `time [hours] [min]` - Set the server time.
