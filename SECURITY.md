# Security review

This was a source review plus targeted regression tests, not an independent penetration test or a guarantee that the app is vulnerability-free.

## Findings and changes

- No network clients, listening ports, remote commands, credential access, telemetry, clipboard reading or keystroke logging were found in the application source.
- Replaced drag-and-drop object payload handling with a private in-memory source-row reference. The app does not deserialize data supplied by external drag sources. Only its own active row may be reordered within the same list.
- Settings XML explicitly prohibits DTDs, disables external resolvers, and limits file/document size and item counts. Settings are data parsed by XmlSerializer into fixed app types, not executable commands.
- Native imports are restricted to the Windows System32 directory.
- Removed the device-inventory diagnostics export from the production application.
- The repository excludes user settings, device IDs, local inventories and generated test output. It intentionally includes the ready-to-run application EXE; other generated binaries are ignored.

## Permissions the app still needs

The app uses a low-level global keyboard hook and reads held-key state to recognize shortcuts. It keeps held keys temporarily in memory and does not record typed text or write a key history. Removing this hook would remove the requested global multi-key shortcuts, including Windows + F12.

Audio device enumeration and switching use Windows COM interfaces. Default-device switching relies on the undocumented PolicyConfig interface and may be affected by future Windows changes. Media controls send fixed Windows application commands. Mute affects the default output only.

Startup is an optional per-user Run registry entry changed from Settings. The manifest requests ordinary user privileges (`asInvoker`). The app does not require administrator rights or change firewall/security settings. Configuration and backups stay in the config folder beside the executable. This makes the configuration portable and shared by anyone using that copy of the app. Git ignores the personal config folder.

## Remaining limitations

Anyone who can replace an executable in its installation directory can replace what you run. Keep the app in a trusted folder and publish builds made from reviewed source. This locally built application is unsigned. Other software with access to your Windows account can also change your portable settings.

No audit can honestly promise that every possible vulnerability has been removed. Report a suspected issue with reproduction steps and the relevant source version; do not include private settings or device inventories in a public report.
