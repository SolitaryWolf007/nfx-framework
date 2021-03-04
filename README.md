# nfx-framework
FiveM nFX Framework (Roleplay)
* https://solitarywolf007.github.io/nfx-framework/

## Installation:
  1) Create a clean installation of FX Server. ([FiveM Docs](https://docs.fivem.net/docs/server-manual/setting-up-a-server/)) (Template Coming Soon)
  2) Leave only the `sessionmanager` and `chat` resources in your resources folder.
  3) [Download](https://github.com/GHMatti/ghmattimysql/releases/tag/1.3.2), Install and Configure GHMattiMySQL. And remember to set the database to `nfx`.
  4) [Download/Clone](https://github.com/SolitaryWolf007/nfx-framework), nFX files. And extract them to the resources folder.
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
      ensure nfx_notify
      ensure nfx_progressbar
      ensure nfx_status
      ensure nfx_vsync
  ```
  6) Open the `nfx/nfx.sql` file in your database, and run it.
  7) Basic installation complete! Browse the `config` folders for additional settings!
